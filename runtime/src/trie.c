// This is an implementation of a power-of-two adaptive radix tree.
// It's based in part on the adaptive radix tree (ART) in
// http://codematch.muehe.org/~leis/papers/ART.pdf

#include <string.h>
#include <stdlib.h>
#include <assert.h>

#include "trie.h"
#include <stdio.h>

static node_t * find_matching_node(node_t * node, uint8_t target_key)
{
  assert(node != NULL);
  uint16_t n = (uint16_t)node->n_minus_one + 1;

  uint8_t l = 0;
  uint8_t r = n - 1;
  uint8_t m;

  while(l <= r){
    m = (uint16_t)(l+r)/2;
    if (node->keys[m] < target_key){
      l = m + 1;
    }
    else if (node->keys[m] > target_key){
      r = m - 1;
    }
    else {
      return node->nodes[m];
    }
  }
  return (node_t*) NULL;
}

static node_t * create_node(uint16_t fanout, uint8_t * keys, node_t ** nodes, void * value){
  assert(fanout <= 256);

  node_t * node = malloc(sizeof(node_t));
  assert(node != NULL);

  node->n_minus_one = (uint8_t)(fanout - 1);

  if(keys != NULL){
    node->keys = keys;
  }
  else {
    node->keys = malloc(sizeof(uint8_t) * fanout);
  }

  if (nodes != NULL){
    node->nodes = nodes;
  }
  else {
    node->nodes = malloc(sizeof(node_t*) * fanout);
  }

  node->value = value;

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
static void reset_key_counts(){
  uint16_t i = 0;
  for(i = 0; i <= 256; i++){
    Key_Counts[i] = 0;
  }
}

static node_t * create_root_node(uint32_t n, uint8_t ** key_strings, void ** values){
  uint32_t i = 0;
  uint32_t j = 0;
  uint32_t max_strlen = 0;
  uint8_t * root_keys = NULL;
  uint32_t n_root_keys = 0;
  node_t * root_node = NULL;

  reset_key_counts();

  for(i = 0; i < n; i++){
    assert(strlen(key_strings[i]) > 0);
    Key_Counts[key_strings[i][0]]++;
  }

  root_keys = unique_keys(Key_Counts, &n_root_keys);
  root_node = create_node(n_root_keys, root_keys, NULL, NULL);

  for(i = 0; i < n_root_keys; i++){
    root_node->nodes[i] = create_node(Key_Counts[root_node->keys[i]], NULL, NULL, NULL);

    for(j = 0; j < n; j++){
      if((key_strings[j][0] == root_node->keys[i]) && (strlen(key_strings[j]) == 1)){
        root_node->nodes[i]->value = values[j];
      }
    }
  }

  return root_node;
}

node_t * create_tree(uint32_t n, uint8_t ** key_strings, void ** values){
  uint32_t i = 0;
  uint32_t j = 0;
  uint32_t k = 0;
  node_t * root_node = create_root_node(n,key_strings,values);
  uint32_t ** key_string_indices = (uint32_t **) malloc((root_node->n_minus_one + 1) * sizeof(uint32_t *));

  for(i = 0; i <= root_node->n_minus_one; i++){
    key_string_indices[i] = (uint32_t *) malloc((root_node->nodes[i]->n_minus_one + 1) * sizeof(uint32_t));

    k = 0;
    for(j = 0; j < n; j++){
      if(key_strings[j][0] == root_node->keys[i]){
        key_string_indices[i][k++] = j;
        if(k > root_node->nodes[i]->n_minus_one){
          break;
        }
      }
    }
  }


  /* TODO: Comprehensively fill in the rest of the tree.
     Go through each child node of the root node, using the key_string_indices
     to restrict search space, and search all key strings at each level (*cringe*)
     to be able to a) avoid recursion and b) construct each child node
     completely (not incrementally) */

  for(i = 0; i <= root_node->n_minus_one; i++){
    free(key_string_indices[i]);
  }
  free(key_string_indices);

  return root_node;
}
