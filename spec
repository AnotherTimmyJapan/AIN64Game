beginseg
    name "code"
    flags BOOT OBJECT
    entry boot
    stack bootStack + 0x1000
    include "$(BUILD_DIR)/src/main.o"
    include "$(LIBULTRA)/libultra_rom.a"
endseg

beginseg
    name "static"
    flags OBJECT
    number 1
    include "$(BUILD_DIR)/assets/gfx.o"
endseg
