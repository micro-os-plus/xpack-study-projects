# blinky-no-rtos

A multi-platform blinky project that runs without an RTOS.

It has separate build configurations for:

- STM32F4DISCOVERY (Cortex-M4)
- STM32F0DISCOVERY (Cortex-M0)
- SiFive HiFive1 (RISC-V)

The project exercises multi-platform and multi-architecture builds.

There are separate debug/release Eclipse build configurations for each
platform.

The STM32F4DISCOVERY is also functional and runs fine on QEMU.

The other two need more work.

## How to test

```sh
set -e

# Be sure you use the most recent xpm.
npm install -g xpm

mkdir -p "${HOME}/Work/xpacks"
cd "${HOME}/Work/xpacks"

# In normal use cases, the dependencies are in package.json and are
# automatically satisfied, but remain read only. For development, clone
# the original repos and link them to the central packages repo.
for p in \
"libs-c-xpack" \
"libs-cpp-xpack" \
"diag-trace-xpack" \
"semihosting-xpack" \
"startup-xpack" \
"devices-stm32f0-xpack" \
"devices-stm32f4-xpack" \
"architecture-cortexm-xpack" \
"architecture-riscv-xpack" \
"sifive-devices-xpack"
do
  git clone --branch develop https://github.com/micro-os-plus/${p}.git ${p}
  xpm link -C ${p}
done


cd "${HOME}/Work"
git clone https://github.com/micro-os-plus/xpack-study-projects.git xpack-study-projects.git

# Install the binary packages.
xpm install -C "${HOME}/Work/xpack-study-projects.git/blinky-no-rtos"

# Link to writable packages.
xpm link -C "${HOME}/Work/xpack-study-projects.git/blinky-no-rtos" \
"@micro-os-plus/libs-c" \
"@micro-os-plus/libs-cpp" \
"@micro-os-plus/diag-trace" \
"@micro-os-plus/semihosting" \
"@micro-os-plus/startup" \
"@micro-os-plus/devices-stm32f0" \
"@micro-os-plus/devices-stm32f4" \
"@micro-os-plus/architecture-cortexm" \
"@micro-os-plus/architecture-riscv" \
"@sifive/devices" \


```

Download a new Eclipse from:

- https://projects.eclipse.org/projects/iot.embed-cdt/downloads/

Start Eclipse with a fresh workspace in a temporary folder.

- Import > General > Existing Projects
- Next >
- Select root directory: Browse... ${HOME}/Work/xpack-study-projects.git/blinky-no-rtos
- Projects: blinky-no-rtos
- disable: Copy projects
- Finish

Select the project, right click, Build Configurations > Build all...

To run a debug session:

- menu Run > Debug configurations > GDB QEMU > select blinky-no-rtos-stm32f4discovery-qemu

