OUTPUT_ARCH (mips)

SECTIONS
{
   /* The N64 entry point in RAM */
   . = 0x80000400;

   .text : {
      $(BUILD_DIR)/src/main.o(.text);
      *(.text)
   }

   .data : {
      *(.data)
   }

   .bss : {
      *(.bss)
      *(COMMON)
   }
}
