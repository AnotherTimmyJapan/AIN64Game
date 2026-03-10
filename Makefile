# --- Project Settings ---
TARGET := mygame
BUILD_DIR := build
SRC_DIR := src
ASM_DIR := asm
TOOLS_DIR := tools

# --- Paths ---
IDOPATH := $(TOOLS_DIR)/ido5.3
LIBULTRA_DIR := $(TOOLS_DIR)/libreultra

# --- Tools ---
CROSS_COMPILE := mips-linux-gnu-
AS      := $(CROSS_COMPILE)as
LD      := $(CROSS_COMPILE)ld
OBJCOPY := $(CROSS_COMPILE)objcopy
CC      := $(IDOPATH)/cc

# --- Flags ---
# -mips2 is the target ISA for IDO 5.3
# -O2 for optimized code, -g for debugging info
CFLAGS := -Wab,-mips2 -non_shared -G 0 -Xcpluscomm -fullwarn -O2
ASFLAGS := -march=vr4300 -mabi=32
LDFLAGS := -T $(TARGET).ld -Map $(BUILD_DIR)/$(TARGET).map --no-check-sections

# --- Includes ---
# Important: These tell 'cfe' (the IDO compiler) where ultra64.h lives
INC_DIRS := include include/PR $(LIBULTRA_DIR)/include $(LIBULTRA_DIR)/include/PR

# --- Files ---
C_FILES   := $(wildcard $(SRC_DIR)/*.c)
S_FILES   := $(wildcard $(ASM_DIR)/*.s)
O_FILES   := $(addprefix $(BUILD_DIR)/,$(C_FILES:.c=.o)) \
             $(addprefix $(BUILD_DIR)/,$(S_FILES:.s=.o))

# --- Build Rules ---
default: all

all: $(BUILD_DIR)/$(TARGET).z64

# Rule for C files
$(BUILD_DIR)/$(SRC_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(@D)
	$(CC) -c $(CFLAGS) $(foreach dir,$(INC_DIRS),-I$(dir)) -o $@ $<

# Rule for ASM files
$(BUILD_DIR)/$(ASM_DIR)/%.o: $(ASM_DIR)/%.s
	@mkdir -p $(@D)
	$(AS) $(ASFLAGS) -o $@ $<

# Link the ELF
$(BUILD_DIR)/$(TARGET).elf: $(O_FILES)
	$(LD) $(LDFLAGS) -o $@ $(O_FILES) -L$(LIBULTRA_DIR)/build -lultra

# Convert ELF to ROM
$(BUILD_DIR)/$(TARGET).z64: $(BUILD_DIR)/$(TARGET).elf
	$(OBJCOPY) $< $@ -O binary
	@echo "--------------------------------"
	@echo "Build Successful: $@"
	@echo "--------------------------------"

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean
