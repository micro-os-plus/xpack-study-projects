# blinky-no-rtos

A multi-platform blinky project that runs without an RTOS.

It has separate build configurations for:

- **STM32F4DISCOVERY** (Cortex-M4)
- **STM32F0DISCOVERY** (Cortex-M0)
- **SiFive HiFive1** (RISC-V)
- **Synthetic POSIX** (macOS/Linux)

The project exercises multi-platform and multi-architecture builds.

There are separate debug/release Eclipse build configurations for each
platform.

The STM32F4DISCOVERY is also functional and runs fine on QEMU.

The STM32F0DISCOVERY is also functional and runs fine on the physical board
(QEMU has a bug and hangs).

The other two need more work.

## How to test

For the prerequisites, follow the steps in the ../README.md file.

### Build in a terminal

TBD

### Run the tests

TBD

### Build with Eclipse

Select the project, right click, Build Configurations > Build all...

The result is a set of folders prefixed with `build-`

### Test with Eclipse

To run a debug session:

- menu Run > Debug configurations > GDB QEMU > select `blinky-no-rtos-stm32f4discovery-qemu`
