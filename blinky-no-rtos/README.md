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
# Create a sub-shell, to see the errors.
bash

# Stop on errors.
set -e

# Be sure you use the most recent xpm.
npm install -g xpm@latest

mkdir -p "${HOME}/Work/xpacks"
cd "${HOME}/Work/xpacks"

# In normal use cases, the dependencies are in package.json and are
# automatically resolved by `xpm install`, but the installed content
# is remain read only.
#
# For development use cases, when content must be writable, clone
# the original repos and link them to the central packages repo.

function xpm-install-git()
{
  git clone --branch develop https://github.com/micro-os-plus/$1.git $1.git
  (cd $1.git; git checkout -b work $2)
  xpm link -C $1.git
}

xpm-install-git "libs-c-xpack" "8bc7439"
xpm-install-git "libs-cpp-xpack" "17f64a2"
xpm-install-git "diag-trace-xpack" "596d7c9"
xpm-install-git "semihosting-xpack" "0db6262"
xpm-install-git "startup-xpack" "19de852"
xpm-install-git "devices-stm32f0-xpack" "4d725cf"
xpm-install-git "devices-stm32f4-xpack" "cd74d33"
xpm-install-git "architecture-cortexm-xpack" "a31d322"
xpm-install-git "architecture-riscv-xpack" "ca59650"
xpm-install-git "devices-sifive-xpack" "2732c22"


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

Start Eclipse with a fresh workspace in a temporary folder. **DO NOT** use
an existing workspace, to have a clean slate.

- Import > General > Existing Projects into Workspace
- Next >
- Select root directory: Browse... ${HOME}/Work/xpack-study-projects.git/blinky-no-rtos
- Projects: blinky-no-rtos
- disable: Copy projects
- Finish

Select the project, right click, Build Configurations > Build all...

To run a debug session:

- menu Run > Debug configurations > GDB QEMU > select blinky-no-rtos-stm32f4discovery-qemu

The result is a set of folders prefixed with `build-`

