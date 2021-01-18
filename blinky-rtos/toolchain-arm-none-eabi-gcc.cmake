#
# This file is part of the µOS++ project (https://github.com/micro-os-plus)
# and is distributed under the terms of the MIT license.
# Copyright (c) 2021 Liviu Ionescu
#
# -----------------------------------------------------------------------------

# Cross compiling.
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")

set(CMAKE_C_COMPILER   "arm-none-eabi-gcc")
set(CMAKE_CXX_COMPILER "arm-none-eabi-g++")

# Must be explicit, not set by CMake.
set(CMAKE_SIZE "arm-none-eabi-size")

