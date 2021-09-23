SOURCES := $(shell find src -type f -name "*.c")
HEADERS := $(shell find include -type f -name "*.h")
OBJECTS := $(patsubst src/%,obj/%,$(SOURCES:.c=.o))
EXE := mapgame

$(EXE): $(OBJECTS)
	@echo $(SOURCES)
	gcc $(OBJECTS) -lglfw -lglad -lX11 -lpthread -lXrandr -lXi -ldl -lGL -lm -o $@

obj/%.o: src/%.c $(HEADERS) $(ASMHEADERS)
	@mkdir -p obj
	gcc -c -o $@ $< -Wall -Iinclude

debug: $(EXE)
	gdb $(EXE)

run: $(EXE)
	./$(EXE)

clean:
	rm -rf obj/*.o
	rm -rf $(EXE)

.PHONY: clean
