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
  node_t * root_node = NULL;
  uint32_t n = sizeof(Test_Key_Strings) / sizeof(uint8_t*);
  void ** test_values = malloc(sizeof(void*) * n);
  uint32_t * hash_sums = malloc(sizeof(uint32_t) * n);

  for(i = 0; i < n; i++){
    hash_sums[i] = 0;
    for(j = 0; j < strlen(Test_Key_Strings[i]); j++){
      hash_sums[i] += Test_Key_Strings[i][j];
    }
    test_values[i] = &hash_sums[i];
  }
  root_node = create_tree(12, Test_Key_Strings, test_values);
  printf("tree created successfully\r\n");
  printf("# root keys: %d\r\n", root_node->n_minus_one + 1);
  printf("root node keys:");
  for(i = 0; i <= root_node->n_minus_one; i++){
    printf(" %c", root_node->keys[i]);
  }
  printf("\r\n");

  free(test_values);
  free(hash_sums);
}
