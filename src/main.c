#include <ultra64.h>
#include "main.h"

OSThread bootThread;
STACK(bootStack, 0x1000);

void boot(void *arg) {
    osInitialize();
    // Initialize PI, Scheduler, and create the Idle thread
    osCreateThread(&idleThread, 1, idle, NULL, idleStack + 0x1000, 10);
    osStartThread(&idleThread);
}

