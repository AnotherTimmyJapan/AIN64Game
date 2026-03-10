#include <ultra64.h>

/* Setup for the boot thread */
OSThread bootThread;
u64 bootStack[0x1000/8];

void boot(void *arg);

void mainproc(void *arg) {
    /* Main Game Loop would go here */
    while (1) {
        // Just spinning for now
    }
}

void boot(void *arg) {
    osInitialize();
    // In a real game, you'd create an idle thread and a main thread here
    mainproc(NULL);
}
