#include <string.h>
#include <stdlib.h>
#include <assert.h>

#include "trie.h"
#include <stdio.h>

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

static trie_node_t * create_subnode(uint8_t * key, void * val){
  trie_node_t * node = malloc(sizeof(trie_node_t));
  assert(node != NULL);

  node->n_subnodes = 0;
  node->subnodes = NULL;
  node->key = key;
  node->key_length = strlen(key);
  node->val = val;

  return node;
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
        node->subnodes[0] = create_subnode(&node->key[1], node->val);
        node->val = NULL;
        // more to be done, will be picked up by the rest of loop
      }
      else
      {
        node->subnodes[0] = create_subnode(&key[i], val);
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

      node->subnodes[subnode_idx] = create_subnode(&key[i], val);

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

trie_node_t * trie_create(){
  trie_node_t * root = malloc(sizeof(trie_node_t));
  assert(root != NULL);

  root->n_subnodes = 0;
  root->subnodes = malloc(0);
  assert(root->subnodes != NULL);
  root->key = NULL;
  root->key_length = 0;
  root->val = NULL;

  return root;
}
