# Default N64_INST if not set (for local builds)
N64_INST ?= /usr/local

# Correct path for modern libdragon
include $(N64_INST)/include/n64.mk

# Your game name
PROG_NAME = mygame

# Object files
OBJS = build/main.o

# Final ROM Target
$(PROG_NAME).z64: $(OBJS)

build/main.o: main.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf build $(PROG_NAME).z64 $(PROG_NAME).elf
