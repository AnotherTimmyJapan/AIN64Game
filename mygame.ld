OUTPUT_ARCH (mips)

SECTIONS
{
   /* Rom Header and Bootblock at the start */
   . = 0x80000400;

   .text : {
      build/src/main.o(.text);
      /* Add other engine files here */
   }

   .data : {
      build/src/main.o(.data);
   }

   .bss : {
      build/src/main.o(.bss);
   }
}
