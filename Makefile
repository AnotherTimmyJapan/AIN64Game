# Project Settings
TARGET := mygame
BUILD_DIR := build
# Use LibreUltra headers
LIBULTRA_DIR := tools/libreultra
INC_DIRS += $(LIBULTRA_DIR)/include $(LIBULTRA_DIR)/include/PR

# Tools
CROSS_COMPILE := mips-linux-gnu-
AS      := $(CROSS_COMPILE)as
LD      := $(CROSS_COMPILE)ld
OBJCOPY := $(CROSS_COMPILE)objcopy
CC      := tools/ido5.3/cc
ifeq ($(shell uname -s),Linux)
  # Use the recomp wrapper if on Linux
  CC := tools/ido5.3/cc
endif

# Flags
# -mips2 is required for IDO 5.3 compatibility
CFLAGS := -Wab,-mips2 -non_shared -G 0 -Xcpluscomm -fullwarn
ASFLAGS := -march=vr4300 -mabi=32
LDFLAGS += -L$(LIBULTRA_DIR)/build -lultra

# Directories
SRC_DIRS := src src/engine
ASM_DIRS := asm
INC_DIRS := include $(LIBULTRA)/include

# Files
C_FILES   := $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.c))
S_FILES   := $(foreach dir,$(ASM_DIRS),$(wildcard $(dir)/*.s))
O_FILES   := $(addprefix $(BUILD_DIR)/,$(C_FILES:.c=.o)) \
             $(addprefix $(BUILD_DIR)/,$(S_FILES:.s=.o))

# Rules
default: all

all: $(BUILD_DIR)/$(TARGET).z64

# Compile C files using IDO
$(BUILD_DIR)/src/%.o: src/%.c
	@mkdir -p $(@D)
	$(CC) -c $(CFLAGS) $(foreach dir,$(INC_DIRS),-I$(dir)) -o $@ $<

# Assemble ASM files
$(BUILD_DIR)/asm/%.o: asm/%.s
	@mkdir -p $(@D)
	$(AS) $(ASFLAGS) -o $@ $<

# Link the ROM
$(BUILD_DIR)/$(TARGET).elf: $(O_FILES)
	$(LD) $(LDFLAGS) -o $@

# Convert ELF to Z64 (N64 ROM)
$(BUILD_DIR)/$(TARGET).z64: $(BUILD_DIR)/$(TARGET).elf
	$(OBJCOPY) $< $@ -O binary
	@echo "Build Successful: $@"

clean:
	rm -rf $(BUILD_DIR)

