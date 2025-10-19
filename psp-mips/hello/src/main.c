#include <pspkernel.h>
#include <pspdebug.h>
#include <pspctrl.h>

PSP_MODULE_INFO("BennuGD2 Homebrew", 0, 1, 0);

int main(void) {
    pspDebugScreenInit();
    pspDebugScreenPrintf("Hello from Docker PSP Homebrew!\n");

    SceCtrlData pad;
    while (1) {
        sceCtrlReadBufferPositive(&pad, 1);
        if (pad.Buttons & PSP_CTRL_START) break;
    }

    sceKernelExitGame();
    return 0;
}
