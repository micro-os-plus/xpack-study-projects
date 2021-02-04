# blinky-rtos

A multi-platform blinky project that runs with an RTOS.

It has separate build configurations for:

- **STM32F4DISCOVERY** (Cortex-M4)
- **STM32F0DISCOVERY** (Cortex-M0)
- **SiFive HiFive1** (RISC-V)
- **Synthetic POSIX** (macOS/Linux)

The project exercises multi-platform and multi-architecture builds.

There are separate debug/release Eclipse build configurations for each
platform; all build are successful.

The STM32F4DISCOVERY and STM32F0DISCOVERY run fine on QEMU.

The Synthetic POSIX runs on macOS and Linux.

The RISC-V port of the scheduler is not yet functional, it is only an
empty framework, to be implemented later. It is provided only as a build
test for RISC-V platforms.

## How to test

For the prerequisites, follow the steps in the parent
[README](../README.md) file.

### Build in a terminal

To build binaries for all platforms with CMake, run:

```sh
xpm install --force -C "${HOME}/Work/xpack-study-projects.git/blinky-rtos"
xpm run build-all-cmake -C "${HOME}/Work/xpack-study-projects.git/blinky-rtos"
```

The result is a set of folders below `build/`.

### Run the tests

The native binaries run on macOS/Linux, and the Arm binaries run via QEMU
in non-graphical mode:

```sh
xpm run run-all-cmake -C "${HOME}/Work/xpack-study-projects.git/blinky-rtos"
```

To run the QEMU tests in graphical mode, use:

```sh
xpm run run-qemu-gui-stm32f4discovery-debug-cmake -C "${HOME}/Work/xpack-study-projects.git/blinky-rtos"
xpm run run-qemu-gui-stm32f0discovery-debug-cmake -C "${HOME}/Work/xpack-study-projects.git/blinky-rtos"

```

### Build with Eclipse

Select the project, right click, Build Configurations > Build all...

The result is a set of folders prefixed with `build-`

### Test with Eclipse

To run a debug session:

- menu Run > Debug configurations > GDB QEMU > select `blinky-rtos-stm32f4discovery-qemu`
