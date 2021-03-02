# blinky-no-rtos

A multi-platform blinky project that runs without an RTOS.

It has separate build configurations for:

- **STM32F4DISCOVERY** (Cortex-M4)
- **STM32F0DISCOVERY** (Cortex-M0)
- **SiFive HiFive1** (RISC-V)
- **Synthetic POSIX** (macOS/Linux)

The project exercises multi-platform and multi-architecture builds.

There are separate debug/release build configurations for each
platform.

The STM32F4DISCOVERY and STM32F0DISCOVERY are also functional and
run fine on QEMU.

The other two need more work, the synthetic POSIX requires a proper
implementation for the clock, and the empty RISC-V port needs the
implementation.

## How to test

For the prerequisites, follow the steps in the parent
[README](../README.md) file.

### Build and run in a terminal

To build binaries for all platforms with CMake, run:

```sh
xpm install --force -C "${HOME}/Work/xpack-study-projects.git/blinky-no-rtos"
xpm run test -C "${HOME}/Work/xpack-study-projects.git/blinky-no-rtos"
```

The result is a set of folders below `build/`.

The Arm binaries run via QEMU
in non-graphical mode.

To run the QEMU tests in graphical mode, use:

```sh
xpm run run-qemu-gui-stm32f4discovery-cmake-debug -C "${HOME}/Work/xpack-study-projects.git/blinky-no-rtos"
xpm run run-qemu-gui-stm32f0discovery-cmake-debug -C "${HOME}/Work/xpack-study-projects.git/blinky-no-rtos"

```

### Build with Eclipse

Select the project, right click, Build Configurations > Build all...

The result is a set of folders prefixed with `build-`

### Test with Eclipse

To run a debug session:

- menu Run > Debug configurations > GDB QEMU > select `blinky-no-rtos-stm32f4discovery-qemu`
