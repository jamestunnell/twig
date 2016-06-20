PROJECT_DIR = ..
HEADERS = $(PROJECT_DIR)/include/trie.h
OBJECTS = $(PROJECT_DIR)/src/trie.o trie_test.o
PROGRAM = trie_test
INCLUDES = -I$(PROJECT_DIR)/include

default: $(PROGRAM)

%.o: %.c $(HEADERS)
	gcc $(INCLUDES) -g -c $< -o $@

$(PROGRAM): $(OBJECTS)
	gcc $(OBJECTS) -g -o $@

clean:
	-rm -f $(OBJECTS)
	-rm -f $(PROGRAM)
