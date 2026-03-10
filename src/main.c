#include <ultra64.h>

/* These variables are required by the N64 boot process */
OSThread bootThread;
u64 bootStack[0x1000 / 8];

void mainproc(void *arg);

void boot(void *arg) {
    osInitialize();
    mainproc(NULL);
}

void mainproc(void *arg) {
    /* Game loop starts here */
    while (1) {
        // IDLE
    }
}
