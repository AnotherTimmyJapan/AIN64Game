all: mygame.z64

include $(N64_INST)/libdragon.mk

OBJS = build/main.o

mygame.z64: $(OBJS)
	$(N64_LD) -o build/mygame.elf $(OBJS) $(LDFLAGS)
	$(N64_OBJCOPY) build/mygame.elf mygame.z64 --pad-to 1M

clean:
	rm -rf build mygame.z64

