# If N64_INST isn't set, try the container default or local default
N64_INST ?= /n64_toolchain

# Include the core N64 build rules
# Try the most likely paths in the container
-include $(N64_INST)/include/n64.mk
-include $(N64_INST)/libdragon.mk

PROG_NAME = mygame
OBJS = build/main.o

# The .z64 target is defined in n64.mk, we just need to link it
$(PROG_NAME).z64: $(OBJS)

build/main.o: main.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf build $(PROG_NAME).z64 $(PROG_NAME).elf
