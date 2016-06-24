// This is an implementation of a power-of-two adaptive radix tree.
// It's based in part on the adaptive radix tree (ART) in
// http://codematch.muehe.org/~leis/papers/ART.pdf

#include <string.h>
#include <stdlib.h>
#include <assert.h>

#include "trie.h"
#include <stdio.h>

#define SUBNODE_NOT_FOUND (-1)

// TODO: Given any node, search through each subnode for a matching first key char.
// The search is done in a binary search fashion since the subnodes are in
// sorted order by first key char.
// If a match is found, a pointer to the found subnode is returned, and match_position
// is set to the matching node index.
// If no match is found, then NULL is returned and match_position is set to the
// index where a subnode with the target_key_char should be inserted.
static trie_node_t * find_matching_subnode_idx(trie_node_t * node, uint8_t target_key_char, int32_t * match_position)
{
  assert(node != NULL);

  uint16_t l = 0;
  uint16_t r = node->n_subnodes - 1;
  uint16_t m = 0;
  int32_t cmp_result = 0;
  uint8_t key_char = 0;
  trie_node_t * found_node = NULL;

  if(node->n_subnodes > 0){
    while(l <= r){
      m = (l+r)/2;
      assert(m < node->n_subnodes);
      key_char = node->subnodes[m]->key[0];
      if (target_key_char > key_char){
        if (m == MAX_TRIE_SUBNODES){
          break;
        }
        l = m + 1;
      }
      else if (target_key_char < key_char){
        if (m == 0){
          break;
        }
        r = m - 1;
      }
      else {
        found_node = node->subnodes[m];
        break;
      }
    }
  }
  *match_position = m;
  return found_node;
}

static trie_node_t * create_terminal_trie_node(uint8_t * key, void * val){
  trie_node_t * node = malloc(sizeof(trie_node_t));
  assert(node != NULL);

  node->n_subnodes = 0;
  node->subnodes = NULL;
  node->key = key;
  node->key_length = strlen(key);
  node->val = val;

  return node;
}

static trie_node_t * create_nonterminal_trie_node(uint16_t n_subnodes, uint8_t * key_char, void * val){
  trie_node_t * node = malloc(sizeof(trie_node_t));
  assert(node != NULL);

  node->n_subnodes = n_subnodes;
  node->subnodes = malloc(sizeof(trie_node_t*) * n_subnodes);
  assert(node->subnodes != NULL);
  node->key = key_char;
  node->key_length = 1;
  node->val = val;

  return node;
}

static uint8_t * unique_keys(uint32_t key_counts[256], uint32_t * n_unique_keys){
  uint32_t i = 0;
  uint32_t j = 0;
  uint8_t * unique_keys = NULL;
  uint32_t n_unique = 0;

  for(i = 0; i < 256; i++){
    if (key_counts[i] != 0){
      n_unique++;
    }
  }

  unique_keys = (uint8_t *) malloc(n_unique * sizeof(uint8_t));

  j = 0;
  for(i = 0; i < 256; i++){
    if (key_counts[i] != 0){
      unique_keys[j++] = (uint8_t) i;
      if(j == n_unique){
        break;
      }
    }

  }

  *n_unique_keys = n_unique;
  return unique_keys;
}

static uint32_t Key_Counts[256] = { 0 };

static trie_node_t * trie_create_root(uint32_t n_keyval_pairs, uint8_t ** keys, void ** vals){
  uint32_t i = 0;
  uint32_t j = 0;
  uint32_t max_strlen = 0;
  uint8_t * root_keys = NULL;
  uint32_t n_root_keys = 0;
  trie_node_t * root_node = NULL;

  for(i = 0; i <= 256; i++){
    Key_Counts[i] = 0;
  }

  for(i = 0; i < n_keyval_pairs; i++){
    assert(strlen(keys[i]) > 0);
    Key_Counts[keys[i][0]]++;
  }

  root_keys = unique_keys(Key_Counts, &n_root_keys);
  root_node = create_nonterminal_trie_node(n_root_keys, NULL, NULL);

  for(i = 0; i < root_node->n_subnodes; i++){
    root_node->subnodes[i] = create_terminal_trie_node(NULL, NULL);
  }

  return root_node;
}


// TODO:
// 1. Begin with root node
// 2. Find child node of root with a key whose first char matches that of the given key
// 3. If no matching child node is found then a new child node is inserted,
//    with the entire given key is the new node key. If a matching subnode is
//    found, then the procedure advances to the next position of the given key,
//    and continues starting at the subnode instead of the root. Also, if the
//    subnode found is a terminal node (contains no subnodes yet), then it
//    needs to be split up and further subnodes aidded.
//
// If the terminal subnode for the given key already exists, then the given
// value will replace the existing value.
void trie_add(trie_node_t * root, uint8_t * key, void * val){
  uint32_t subnode_idx = 0;
  trie_node_t * subnode_ptr = NULL;
  trie_node_t ** prev_subnodes = NULL;
  uint32_t i = 0;
  uint32_t j = 0;
  trie_node_t * node = root;
  uint32_t key_length = strlen(key);

  for(i = 0; i < key_length;){
    assert(node != NULL);
    subnode_ptr = find_matching_subnode_idx(node, key[i], &subnode_idx);
    if(subnode_ptr != NULL){
      if (i == (key_length - 1)){
        subnode_ptr->val = val;
      }
      node = subnode_ptr;
      i++;
    }
    else {
      prev_subnodes = node->subnodes;
      node->subnodes = (trie_node_t **) malloc(sizeof(trie_node_t *) * (node->n_subnodes + 1));

      for(j = 0; j < subnode_idx; j++){
        node->subnodes[j] = prev_subnodes[j];
      }

      node->subnodes[subnode_idx] = create_terminal_trie_node(key, val);

      for(i = subnode_idx; j < node->n_subnodes; j++){
        node->subnodes[j+1] = prev_subnodes[j];
      }

      node->n_subnodes++;
      free(prev_subnodes);
      break;
    }
  }
}

void * trie_fetch(trie_node_t * root, uint8_t * key){
  trie_node_t * node = root;
  trie_node_t * subnode = NULL;
  uint32_t subnode_idx = 0;
  uint32_t key_length = strlen(key);
  uint32_t i = 0;
  void * val = NULL;

  while(i < key_length){
    assert(node != NULL);
    subnode = find_matching_subnode_idx(node, key[i], &subnode_idx);

    if (subnode != NULL){
      if (subnode->key_length == 1){
        node = subnode;
        i++;
      }
      else {
        if (0 == strcmp(subnode->key, &key[i])){
          val = subnode->val;
        }
        break;
      }
    } else {
      break;
    }
  }
  return val;

}
//   for(i = 0; i < n_root_keys; i++){
//     if (Key_Counts[root_keys[i]] == 1){
//       root_node->subnodes[i] = create_terminal_trie_node()
//     }
//     else {
//       root_node->subnodes[i] = create_nonterminal_trie_node(Key_Counts[root_keys[i],
//         )
//     }
//
//     root_node->subnodes[i] = create_trie_node(Key_Counts[root_keys[i]], NULL,
//       root_node->keys[i]], root_keys[i], NULL, NULL);
//
//     for(j = 0; j < n; j++){
//       if((keys[j][0] == root_node->keys[i]) && (strlen(keys[j]) == 1)){
//         root_node->subnodes[i]->val = vals[j];
//       }
//     }
//   }
//
//   return root_node;
// }

trie_node_t * trie_create(uint32_t n_keyval_pairs, uint8_t ** keys, void ** vals){
  uint32_t i = 0;
  uint32_t j = 0;
  uint32_t k = 0;
  // trie_node_t * root = trie_create_root(n_keyval_pairs, keys, vals);
  trie_node_t * root = create_nonterminal_trie_node(0, NULL, NULL);

  for(i = 0; i < n_keyval_pairs; i++){
    trie_add(root, keys[i], vals[i]);
  }

  return root;

  // uint32_t ** key_indices = (uint32_t **) malloc((root_node->n_minus_one + 1) * sizeof(uint32_t *));
  // uint32_t * key_lengths = (uint32_t *) malloc((root_node->n_minus_one + 1) * sizeof(uint32_t));
  // trie_node_t * child_root = NULL;
  //
  // for(j = 0; j < n_keyval_pairs; j++){
  //   key_lengths[i] = strlen(keys[j]);
  // }
  //
  // for(i = 0; i <= root_node->n_minus_one; i++){
  //   child_root = root_node->subnodes[i]
  //   key_indices[i] = (uint32_t *) malloc((child_root->n_minus_one + 1) * sizeof(uint32_t));
  //
  //   k = 0;
  //   for(j = 0; j < n_keyval_pairs; j++){
  //     if(key_lengths[j] >= child_node->key_length){
  //       if(0 == strncmp(child_node->key, keys[j], child_node->key_length)){
  //         key_indices[i][k++] = j;
  //         if(k > root_node->subnodes[i]->n_minus_one){
  //           break;
  //         }
  //       }
  //     }
  //   }
  // }
  //
  //
  // /* TODO: Comprehensively fill in the rest of the tree.
  //    Go through each child node of the root node, using the key_indices
  //    to restrict search space, and search all key strings at each level (*cringe*)
  //    to be able to a) avoid recursion and b) construct each child node
  //    completely (not incrementally) */
  //
  // for(i = 0; i <= root_node->n_minus_one; i++){
  //   free(key_indices[i]);
  // }
  // free(key_indices);
}
