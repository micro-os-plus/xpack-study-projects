# blinky-rtos

A multi-platform blinky project that runs with an RTOS.

It has separate build configurations for:

- **STM32F4DISCOVERY** (Cortex-M4)

The project exercises multi-platform and multi-architecture builds.

There are separate debug/release Eclipse build configurations for each
platform.

The STM32F4DISCOVERY is also functional and runs fine on QEMU.

## How to test

Follow the steps in the ../README.md file.

### Import projects & build

- Import > General > Existing Projects into Workspace
- Next >
- Select root directory: Browse... `${HOME}/Work/xpack-study-projects.git/blinky-rtos`
- Projects: `blinky-rtos`
- disable: Copy projects
- Finish

Select the project, right click, Build Configurations > Build all...

The result is a set of folders prefixed with `build-`

### Run a debug session

To run a debug session:

- menu Run > Debug configurations > GDB QEMU > select `blinky-rtos-stm32f4discovery-qemu`
