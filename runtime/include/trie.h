#ifndef TRIE_H
#define TRIE_H

#include <stdint.h>

typedef struct trie_node_s trie_node_t;

struct trie_node_s {
  trie_node_t ** subnodes;
  uint16_t n_subnodes;

  uint8_t * key;
  uint16_t key_length;

  void * val;
};

trie_node_t * trie_create();
void trie_add(trie_node_t * root, uint8_t * key, void * val);
void * trie_fetch(trie_node_t * root, uint8_t * key);
// void trie_remove(trie_node_t * root, uint8_t * key);
uint16_t trie_n_subnodes(trie_node_t * root);

#endif
