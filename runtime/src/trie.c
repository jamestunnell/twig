#include <string.h>
#include <stdlib.h>
#include <assert.h>

#include "trie.h"
#include <stdio.h>

#define SUBNODE_NOT_FOUND (-1)

static int32_t find_matching_subnode_idx(trie_node_t * node, uint8_t target_key_char)
{
  assert(node != NULL);

  int32_t l = 0;
  int32_t r = 0;
  int32_t m = 0;
  int32_t cmp_result = 0;
  uint8_t key_char = 0;

  assert(node != NULL);
  if (node->n_subnodes == 0){
    assert(0);
  }
  assert(node->n_subnodes > 0);
  r = node->n_subnodes - 1;

  while(l <= r){
    m = (l+r)/2;
    key_char = node->subnodes[m]->key[0];
    if (target_key_char > key_char){
      l = m + 1;
    }
    else if (target_key_char < key_char){
      r = m - 1;
    }
    else {
      return m;
    }
  }
  return -(l + 1);
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

// If the terminal subnode for the given key already exists, then the given
// value will replace the existing value.
void trie_add(trie_node_t * root, uint8_t * key, void * val){
  int32_t subnode_idx = 0;
  trie_node_t ** prev_subnodes = NULL;
  uint32_t i = 0;
  uint32_t j = 0;
  trie_node_t * node = root;
  uint32_t key_length = strlen(key);

  while(i < key_length){
    assert(node != NULL);

    if (node->n_subnodes == 0){
      free(node->subnodes);
      node->subnodes = (trie_node_t **) malloc(sizeof(trie_node_t*));
      node->n_subnodes = 1;
      if(node->key_length > 1){
        node->key_length = 1;
        node->subnodes[0] = create_terminal_trie_node(&node->key[1], node->val);
        node->val = NULL;
        // more to be done, will be picked up by the rest of loop
      }
      else
      {
        node->subnodes[0] = create_terminal_trie_node(&key[i], val);
        break; // no more to be done
      }
    }

    subnode_idx = find_matching_subnode_idx(node, key[i]);
    if(subnode_idx >= 0){
      if (i == (key_length - 1)){
        node->subnodes[subnode_idx]->val = val;
      }
      node = node->subnodes[subnode_idx];
      i++;
    }
    else {
      // turn into insertion index
      subnode_idx = -(subnode_idx + 1);

      prev_subnodes = node->subnodes;
      node->subnodes = (trie_node_t **) malloc(sizeof(trie_node_t *) * (node->n_subnodes + 1));

      for(j = 0; j < subnode_idx; j++){
        node->subnodes[j] = prev_subnodes[j];
      }

      node->subnodes[subnode_idx] = create_terminal_trie_node(&key[i], val);

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
  int32_t subnode_idx = 0;
  uint32_t key_length = strlen(key);
  uint32_t i = 0;
  void * val = NULL;

  while(i < key_length){
    assert(node != NULL);
    if(node->n_subnodes == 0){
      if (0 == strcmp(key, node->key)){
        val = subnode->val;
      }
      break;
    }
    else {
      subnode_idx = find_matching_subnode_idx(node, key[i]);

      if (subnode_idx >= 0){
        subnode = node->subnodes[subnode_idx];
        if (subnode->key_length == 1){
          if (i == (key_length - 1)){
            val = subnode->val;
          }
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
  }
  return val;

}

trie_node_t * trie_create(uint32_t n_keyval_pairs, uint8_t ** keys, void ** vals){
  uint32_t i = 0;
  uint32_t j = 0;
  uint32_t k = 0;
  trie_node_t * root = NULL;

  assert(n_keyval_pairs > 0);
  root = create_nonterminal_trie_node(1, NULL, NULL);
  root->subnodes[0] = create_terminal_trie_node(keys[0], vals[0]);

  for(i = 1; i < n_keyval_pairs; i++){
    trie_add(root, keys[i], vals[i]);
  }

  return root;
}
