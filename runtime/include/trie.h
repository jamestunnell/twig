#ifndef TRIE_H
#define TRIE_H

#include <stdint.h>

typedef struct node_s node_t;

struct node_s {
  uint8_t n_minus_one;
  uint8_t * keys;
  node_t ** nodes;
  void * value;
};

node_t * create_tree(uint32_t n, uint8_t ** key_strings, void ** values);

#endif
