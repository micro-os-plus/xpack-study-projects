# xPack based µOS++ experimental projects

These projects are used to evaluate various solutions for the new
µOS++ modular structure, based on xPacks.

For now there are two projects, one intended to run without an RTOS,
and one using the RTOS.

- https://github.com/micro-os-plus/xpack-study-projects

## How to test

### Prerequisites

If you don't have the xPack tools on your machine, follow the steps in the
[prerequisites](https://xpack.github.io/install/) page.

For the moment building and running the native build configurations
is possible only on macOS and GNU/Linux.

Building the embedded Arm and RISC-V build configurations should be possible
on all platforms, since the xPack toolchains are cross-platform, but
CMake has a problem starting ninja on Windows, so for the moment only
macOS and GNU/Linux are available.

Running the STM32F4DISCOVERY under QEMU should also be possible on all
platforms, but QEMU has some issues starting under xpm, and will be fixed
in the next release.

The projects were tested on:

- macOS 10.15 / clang 12  (GitHub Actions)
- Ubuntu 20 / gcc 9.3 (GitHub Actions)
- Ubuntu 18 / gcc 7.5 (GitHub Actions)
- Raspberry Pi OS 64-bit (Debian 10 buster) / gcc 8

### Update xpm

If you already have xpm installed, be sure you use the most recent version.

```sh
npm install -g xpm@latest
```

It must be 0.8.1 or later.

### Start with a clean slate

Remove any previous local copy of the project:

```sh
rm -rf "${HOME}/Work/xpack-study-projects.git"
```

Please note that this will also remove the local repositories clones
possibly installed in a previous run;
if you contributed code to these local repos,
be sure you first submit Pull Requests, and
do not delete them yet.

### Clone the GitHub repo

```sh
mkdir -p "${HOME}/Work"

git clone https://github.com/micro-os-plus/xpack-study-projects.git \
  "${HOME}/Work/xpack-study-projects.git"
```

For development purposes, use the `develop` branch:

```sh
git clone --branch develop https://github.com/micro-os-plus/xpack-study-projects.git \
  "${HOME}/Work/xpack-study-projects.git"
```

### Proceed with the tests

Go to the [blinky-rtos/README](blinky-rtos/README.md) and follow the
instructions there.

Same for [blinky-no-rtos/README](blinky-no-rtos/README.md).

## Install writable source dependencies for development

The dependencies installed by `xpm install` are read only.

For development use cases, when the content must be writable, clone
the original repos and link via the central packages repo.

```sh
curl -L "https://raw.githubusercontent.com/micro-os-plus/build-helper-xpack/xpack/scripts/clone-and-link-all-git-repos.sh" | bash
```

This script will clone the `xpack-develop` branches from all µOS++
source Git repos
in `${HOME}/Work/micro-os-plus-xpack-repos/`.

If needed, the script can be executed separately, with an
optional argument, the destination folder, which can be
anywhere in the home folder.

The script also executes the `xpm install` command in each folder,
to create a link from the central xPacks repository
(in users's home folder) to the writable repo clone.

The next step is to replace the links from projects to the
read-only folders in the central xPacks repo with links to the writable
folders.

To simplify things, each project has a named script, that can be
invoked with `xpm run link-deps`.

## Eclipse

The default way to build these project is via command line commands,
as presented before.

For those who prefer graphical tools, it is also possible to use
Eclipse.

Download a new **Eclipse IDE for Embedded C/C++ Developers** from:

- https://www.eclipse.org/downloads/packages/

Start Eclipse with a fresh workspace in a temporary folder. **DO NOT** use
an existing workspace, to have a clean slate.

Import the projects & build

- Import > General > Existing Projects into Workspace
- Next >
- Select root directory: Browse... `${HOME}/Work/xpack-study-projects.git/blinky-rtos`
- Projects: `blinky-rtos` & `blinky-no-rtos`
- disable: Copy projects
- Finish

Note: the Eclipse configurations might occasionally not be up-to-date.

## Feedback

Any feedback is highly appreciated.

Please use the project
[forum](https://www.tapatalk.com/groups/xpack/xpack-based-os-experimental-projects-t116.html)
instead of private messages, such that the
discussions to be public and be seen by more people.
