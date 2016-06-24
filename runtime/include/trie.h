#ifndef TRIE_H
#define TRIE_H

#include <stdint.h>

#define MAX_TRIE_SUBNODES 65535

typedef struct trie_node_s trie_node_t;

struct trie_node_s {
  trie_node_t ** subnodes;
  uint16_t n_subnodes;

  uint8_t * key;
  uint16_t key_length;

  void * val;
};

trie_node_t * trie_create(uint32_t n_keyval_pairs, uint8_t ** keys, void ** vals);
uint8_t trie_add(trie_node_t * root, uint8_t * key, void * val);
void * trie_fetch(trie_node_t * root, uint8_t * key);
// uint8_t trie_remove(trie_node_t * root, uint8_t * key, void * val);

#endif
