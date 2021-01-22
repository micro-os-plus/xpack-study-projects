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

The STM32F4DISCOVERY is functional and runs fine on QEMU.

The STM32F0DISCOVERY is also functional and runs fine on the physical board
(QEMU has a bug and hangs).

The Synthetic POSIX runs on macOS, and possibly on Linux.

The RISC-V port of the scheduler is not yet functional, it is only an
empty framework, to be implemented later. It is provided only as a build
test for RISC-V platforms.

## How to test

For the prerequisites, follow the steps in the ../README.md file.

### Build in a terminal

To build binaries for all platforms with CMake, run:

```sh
xpm install -C "${HOME}/Work/xpack-study-projects.git/blinky-rtos"
xpm run all-cmake -C "${HOME}/Work/xpack-study-projects.git/blinky-rtos"
```

The result is a set of folders below `build/`.

To run the native binary on macOS/Linux:

```sh
${HOME}/Work/xpack-study-projects.git/blinky-rtos/build/synthetic-posix-release-cmake/blinky-rtos
```

### Build with Eclipse

There are also Eclipse build configurations for allplatforms.

#### Import projects & build

- Import > General > Existing Projects into Workspace
- Next >
- Select root directory: Browse... `${HOME}/Work/xpack-study-projects.git/blinky-rtos`
- Projects: `blinky-rtos`
- disable: Copy projects
- Finish

Select the project, right click, Build Configurations > Build all...

The result is a set of folders prefixed with `build-`

#### Run a debug session

To run a debug session:

- menu Run > Debug configurations > GDB QEMU > select `blinky-rtos-stm32f4discovery-qemu`
