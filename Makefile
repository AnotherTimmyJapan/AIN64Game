# Use the toolchain path
N64_INST ?= /n64_toolchain
include $(N64_INST)/include/n64.mk

# Program name
PROG_NAME = mygame

# Object files (placed in build directory)
OBJS = build/main.o

# The primary target
$(PROG_NAME).z64: $(OBJS)

# How to compile C files
build/main.o: main.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf build $(PROG_NAME).z64 $(PROG_NAME).elf

.PHONY: clean
