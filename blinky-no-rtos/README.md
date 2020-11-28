# blinky-no-rtos

A multi-platform blinky project that runs without an RTOS.

It has separate build configurations for:

- **STM32F4DISCOVERY** (Cortex-M4)
- **STM32F0DISCOVERY** (Cortex-M0)
- **SiFive HiFive1** (RISC-V)

The project exercises multi-platform and multi-architecture builds.

There are separate debug/release Eclipse build configurations for each
platform.

The STM32F4DISCOVERY is also functional and runs fine on QEMU.

The other two need more work.

## How to test

### Update xpm

Be sure you use the most recent xpm.

```sh
npm install -g xpm@latest
```

It must be 0.7.1 or later.

### Clone the GitHub repo

```sh
mkdir -p "${HOME}/Works"

git clone https://github.com/micro-os-plus/xpack-study-projects.git \
  "${HOME}/Work/xpack-study-projects.git"
```

### Install the binary packages

```sh
xpm install -C "${HOME}/Work/xpack-study-projects.git/blinky-no-rtos"
```

### Install writable source dependencies

In most common use cases, the dependencies are in `package.json` and are
automatically resolved by `xpm install`, but the installed content
is read only.

For development use cases, when the content must be writable, clone
the original repos and link via the central packages repo.

```sh
bash "${HOME}/Work/xpack-study-projects.git/blinky-no-rtos/scripts/xpm-install-git.sh"
```

### Build

Download a new Eclipse from:

- https://projects.eclipse.org/projects/iot.embed-cdt/downloads/

Start Eclipse with a fresh workspace in a temporary folder. **DO NOT** use
an existing workspace, to have a clean slate.

- Import > General > Existing Projects into Workspace
- Next >
- Select root directory: Browse... `${HOME}/Work/xpack-study-projects.git/blinky-no-rtos`
- Projects: `blinky-no-rtos`
- disable: Copy projects
- Finish

Select the project, right click, Build Configurations > Build all...

The result is a set of folders prefixed with `build-`

### Run a debug session

To run a debug session:

- menu Run > Debug configurations > GDB QEMU > select `blinky-no-rtos-stm32f4discovery-qemu`

## Feedback

Any feedback is highly appreciated.

Please use the project
[forum](https://www.tapatalk.com/groups/xpack/xpack-based-os-experimental-projects-t116.html)
instead of private messages, such that the
discussions to be public and be seen by more people.
