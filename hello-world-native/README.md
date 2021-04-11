# hello-world-native

A simple Hello World program running on the native development platform.

## How to test

For the prerequisites, follow the steps in the parent
[README](../README.md) file.

On Windows, to get the compiler, install
[Build Tools for Visual Studio 2019](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2019)

The compiler is installed in a specific location which is not added to
the system path, so it is recommended to start the Developer Command Prompt:

```
C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools>where cl
C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\VC\Tools\MSVC\14.28.29910\bin\Hostx86\x86\cl.exe
```

### Build in a terminal

To build binaries for all platforms with CMake, run:

```sh
cd "${HOME}/Work/xpack-study-projects.git/hello-world-native"

xpm install
xpm run test
```
