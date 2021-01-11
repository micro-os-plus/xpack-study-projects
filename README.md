# xPack based µOS++ experimental projects

These projects are used to evaluate various solutions for the new
µOS++ modular structure, based on xPacks.

For now there are two projects, one intended to run without an RTOS,
and one using the RTOS.

- https://github.com/micro-os-plus/xpack-study-projects

## How to test

### Update xpm

Be sure you use the most recent xpm.

```sh
npm install -g xpm@latest
```

It must be 0.7.1 or later.

### Start with a clean slate

Please note that this will also remove all local repositories clones;
if you contributed code to them, be sure you submit Pull Request, and
do not deleate them yet.

```sh
rm -rf "${HOME}/Work/xpack-study-projects.git"
```

### Clone the GitHub repo

```sh
mkdir -p "${HOME}/Work"

git clone https://github.com/micro-os-plus/xpack-study-projects.git \
  "${HOME}/Work/xpack-study-projects.git"
```

### Install writable source dependencies

In most common use cases, the dependencies are in `package.json` and are
automatically resolved by `xpm install`, but the installed content
is read only.

For development use cases, when the content must be writable, clone
the original repos and link via the central packages repo.

```sh
bash "${HOME}/Work/xpack-study-projects.git/scripts/xpm-install-git.sh"
```

### Download Eclipse

Download a new Eclipse from:

- https://www.eclipse.org/downloads/packages/

Start Eclipse with a fresh workspace in a temporary folder. **DO NOT** use
an existing workspace, to have a clean slate.

### Import projects & build

Follow the steps in the README available in each folder.

## Feedback

Any feedback is highly appreciated.

Please use the project
[forum](https://www.tapatalk.com/groups/xpack/xpack-based-os-experimental-projects-t116.html)
instead of private messages, such that the
discussions to be public and be seen by more people.
