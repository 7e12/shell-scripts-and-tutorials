# Build the all-in-one working environment for STM32 MCU-MPU on Linux tutorial

`This tutorial shows how to build the all-in-one working environment (generate, edit, build, load and debug) to work with STM32 MCU-MPU on Linux`

## Install

STM32CubeMX

+ Download [here](https://www.st.com/en/development-tools/stm32cubemx.html)

+ Create bash alias to open STM32CubeMX easily everywhere

```bash
echo "alias STM32CubeMX='//usr/local/STMicroelectronics/STM32Cube/STM32CubeMX/STM32CubeMX'" >> ~/.bashrc
source ~/.bashrc
```

Visual Studio Code

+ Download [here](https://code.visualstudio.com/download)

J-Link Software

+ Download [here](https://www.segger.com/downloads/jlink/#J-LinkSoftwareAndDocumentationPack)

Toolchain

+ Install GNU Arm Embedded toolchain for cross-compiling

```bash
sudo apt install binutils-arm-none-eabi gcc-arm-none-eabi libnewlib-arm-none-eabi libstdc++-arm-none-eabi-newlib
```

## Generate - STM32CubeMX

When using STM32CubeMX to generate initial source code, select the Makefile option of the Toolchain / IDE dropdown in the Project Manager tab

## Edit - Visual Studio Code

The generated source code can be edited using Visual Studio Code

## Build and load - SEGGER J-Flash, Toolchain and Visual Studio Code

Perform the following steps

1. Create the jflash.jflash file to describe the hardware

+ Open SEGGER J-Flash

```bash
JFlashExe
```

+ Create new project > Start J-Flash > Choose target device > OK > OK > Save project with file name jflash.jflash in the working project base folder

2. Create a build task

+ Enter the shortcut Ctrl+Shift+B to create the tasks.json file in the MSBuild template

+ Edit the tasks.json file

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "j-link build",
            "type": "shell",
            "command": "make && JFlash -openprjjflash.jflash -openbuild/${workspaceFolderBasename}.hex -erasechip -auto -startapp -exit",
            "args": [],
            "group": "build",
            "presentation": {
                "reveal": "silent"
            },
            "options": {
                "cwd": "${workspaceFolder}"
            },
            "problemMatcher": "$gcc"
        }
    ]
}
```

From now on, enter Ctrl+Shift+B > choose "j-link build" to build the working project and load the built program (the hex file) into STM32 MCU-MTP

## Debug - SEGGER J-Link RTT Viewer

To debug the program by run-time logging using SEGGER J-Link RTT Viewer, perform the following steps

+ Add the following SEGGER_RTT library files to the source code

```bash
.
└── Core
    ├── Inc
    │   └── RTT
    │       ├── SEGGER_RTT_Conf.h
    │       └── SEGGER_RTT.h
    └── Src
        ├── RTT
        │   ├── SEGGER_RTT_ASM_ARMv7M.S
        │   ├── SEGGER_RTT.c
        │   └── SEGGER_RTT_printf.c
        └── Syscalls
            └── SEGGER_RTT_Syscalls_GCC.c
```

+ Add these lines to Makefile

```Makefile
C_SOURCES =  \
...
Core/Src/RTT/SEGGER_RTT.c \
Core/Src/RTT/SEGGER_RTT_printf.c \
Core/Src/Syscalls/SEGGER_RTT_Syscalls_GCC.c \
...
C_INCLUDES =  \
...
-ICore/Inc/RTT \
...
```

+ Include the library and define a macro

```C
#include "SEGGER_RTT.h"
#define print(...) SEGGER_RTT_printf(0, __VA_ARGS__)
```

+ Print debug log

```C
print("Hello World!");
```

+ Open SEGGER J-Link RTT Viewer to view run-time debug logging

```bash
JLinkRTTViewerExe
```

+ Specify target device and debug now
