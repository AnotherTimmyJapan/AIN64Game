#include <stdio.h>
#include <libdragon.h>

int main(void) {
    /* Initialize N64 systems */
    display_init(RESOLUTION_320x240, DEPTH_16_BPP, 2, GAMMA_NONE, ANTIALIAS_RESAMPLE);
    console_init();
    
    /* Main Game Loop */
    while(1) {
        /* Clear screen */
        console_clear();
        
        /* Print to screen */
        printf("Hello, b6259!\n");
        printf("N64 Game Powered by AI.\n");
        
        /* Update display */
        console_render();
    }
}

