#include "trie.h"
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

static uint8_t * Test_Key_Strings[] = {
  "abc", "hello", "beef", "forks",
  "print", "puts", "to_s", "to_a",
  "+", "-", "*", "/"
};

int main(void){
  uint32_t i = 0;
  uint32_t j = 0;
  trie_node_t * root_node = NULL;
  uint32_t n = sizeof(Test_Key_Strings) / sizeof(uint8_t*);
  void ** test_values = malloc(sizeof(void*) * n);
  uint32_t * hash_sums = malloc(sizeof(uint32_t) * n);
  void * val = NULL;

  for(i = 0; i < n; i++){
    hash_sums[i] = 0;
    for(j = 0; j < strlen(Test_Key_Strings[i]); j++){
      hash_sums[i] += Test_Key_Strings[i][j];
    }
    test_values[i] = &hash_sums[i];
  }
  root_node = trie_create(12, Test_Key_Strings, test_values);
  printf("tree created successfully\r\n");
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

  free(test_values);
  free(hash_sums);
}
