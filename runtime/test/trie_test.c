#include "trie.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <assert.h>

static uint8_t * Test_Key_Strings[] = {
  "abc", "hello", "beef", "forks",
  "print", "puts", "to_s", "to_a",
  "+", "-", "*", "/"
};

#define N_RAND_TEST_KEYS 200000
#define MIN_RAND_TEST_KEY_SIZE 1
#define MAX_RAND_TEST_KEY_SIZE 40

void basic_test(){
  uint32_t i = 0;
  uint32_t j = 0;
  trie_node_t * root_node = NULL;
  uint32_t n = sizeof(Test_Key_Strings) / sizeof(uint8_t*);
  uint32_t * hash_sums = malloc(sizeof(uint32_t) * n);
  void * val = NULL;

  root_node = trie_create();

  for(i = 0; i < n; i++){
    hash_sums[i] = 0;
    for(j = 0; j < strlen(Test_Key_Strings[i]); j++){
      hash_sums[i] += Test_Key_Strings[i][j];
    }
    trie_add(root_node, Test_Key_Strings[i], &hash_sums[i]);
  }

  printf("# child nodes: %d\r\n", root_node->n_subnodes);
  printf("child node (first) keys:");
  for(i = 0; i < root_node->n_subnodes; i++){
    printf(" %c", root_node->subnodes[i]->key[0]);
  }
  printf("\r\n");

  printf("\r\n");
  printf("Checking that proper values are retrieved...\r\n");
  for(i = 0; i < n; i++){
    printf("%s -> ", Test_Key_Strings[i]);
    val = trie_fetch(root_node, Test_Key_Strings[i]);
    if (val != NULL){
      if (val == &hash_sums[i]){
        printf("SUCCESS\r\n");
      }
      else {
        printf("MISMATCH\r\n");
      }
    }
    else {
      printf("FAILED\r\n");
    }
  }

  free(hash_sums);
}

// Test for trie add/fetch functions
void random_test(){
  uint32_t i = 0;
  uint32_t j = 0;
  uint32_t str_size = 0;
  uint8_t * test_keys[N_RAND_TEST_KEYS] = {0};
  uint32_t test_values[N_RAND_TEST_KEYS] = {0};
  trie_node_t * trie_root = NULL;
  void * val = NULL;

  printf("\r\nRandom add/fetch test\r\n");

  trie_root = trie_create();

  printf("Adding random key/val pairs...\r\n");
  // generate random key/val pairs
  for(i; i < N_RAND_TEST_KEYS; i++){
    str_size = (rand() % MAX_RAND_TEST_KEY_SIZE) + MIN_RAND_TEST_KEY_SIZE;
    test_keys[i] = malloc(str_size * sizeof(uint8_t));
    for(j = 0; j < str_size; j++){
      test_keys[i][j] = (uint8_t)(rand() % 256);
    }
    test_values[i] = rand();

    trie_add(trie_root, test_keys[i], &test_values[i]);
  }

  printf("Fetching and verifying key/val pairs...\r\n");
  // fetch each value using key
  for(i; i < N_RAND_TEST_KEYS; i++){
    val = trie_fetch(trie_root, test_keys[i]);
    if (val != &test_values[i]){
      printf("Mismatch found!");
    }
  }

  printf("Test complete\r\n");

  // free allocated memory
  for(i; i < N_RAND_TEST_KEYS; i++){
    free(test_keys[i]);
  }
}

int main(void){
  basic_test();
  random_test();
}
