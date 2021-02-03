#
# This file is part of the µOS++ distribution.
#   (https://github.com/micro-os-plus)
# Copyright (c) 2021 Liviu Ionescu
#
# This Source Code Form is subject to the terms of the MIT License.
# If a copy of the license was not distributed with this file, it can
# be obtained from https://opensource.org/licenses/MIT/.
#
# -----------------------------------------------------------------------------

# https://cmake.org/cmake/help/v3.18/
cmake_minimum_required(VERSION 3.18)

project(
	blinky
	DESCRIPTION "A blinky not using the µOS++ RTOS"
)

enable_language(C)
enable_language(CXX)
enable_language(ASM)

# Specify the C/C++ standards.
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

message(STATUS "Platform name: ${PLATFORM_NAME}")
# CMAKE_BUILD_TYPE: Debug, Release, RelWithDebInfo, MinSizeRel
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

add_executable(monolithic-app)

set_target_properties(
  monolithic-app

  PROPERTIES
    OUTPUT_NAME "${CMAKE_PROJECT_NAME}"
    CXX_EXTENSIONS OFF
)

# Bare-metal executables have the .elf extension.
if(CMAKE_SYSTEM_NAME STREQUAL "Generic")
  set_target_properties(
    monolithic-app

    PROPERTIES
      SUFFIX ".elf"
  )
endif()

# Generate the compile_commands.json file to feed the indexer.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# -----------------------------------------------------------------------------
# Include the platform dependent scripts.

if(PLATFORM_NAME STREQUAL "stm32f4discovery")
  include("platform-stm32f4discovery/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-devices-stm32f4/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-architecture-cortexm/meta/xpack-helper.cmake")
elseif(PLATFORM_NAME STREQUAL "stm32f0discovery")
  include("platform-stm32f0discovery/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-devices-stm32f0/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-architecture-cortexm/meta/xpack-helper.cmake")
elseif(PLATFORM_NAME STREQUAL "sifive-hifive1")
  include("platform-sifive-hifive1/meta/xpack-helper.cmake")
  include("xpacks/xpack-sifive-platform-hifive1/meta/xpack-helper.cmake")
  include("xpacks/xpack-sifive-devices/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-architecture-riscv/meta/xpack-helper.cmake")
elseif(PLATFORM_NAME STREQUAL "synthetic-posix")
  include("platform-synthetic-posix/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-architecture-synthetic-posix/meta/xpack-helper.cmake")
else()
  message(FATAL_ERROR, "Unsupported PLATFORM_NAME")
endif()

# -----------------------------------------------------------------------------

# Platform specific settings.
target_sources_micro_os_plus_platform(monolithic-app)
target_include_directories_micro_os_plus_platform(monolithic-app)
target_compile_definitions_micro_os_plus_platform(monolithic-app)
# Many interesting things come from the platfrom specific definitions.
target_options_micro_os_plus_platform(monolithic-app)

# Device specific settings.
target_sources_micro_os_plus_device(monolithic-app)
target_include_directories_micro_os_plus_device(monolithic-app)

# Architecture specific settings.
target_sources_micro_os_plus_architecture(monolithic-app)
target_include_directories_micro_os_plus_architecture(monolithic-app)

# -----------------------------------------------------------------------------

# Application sources.
target_sources(
  monolithic-app

  PRIVATE
    src/main.cpp
    src/sysclock.cpp
    src/_write.c
)

# Application includes.
target_include_directories(
  monolithic-app

  PRIVATE
    include
)

# Application definitions.
target_compile_definitions(
  monolithic-app

  PRIVATE
    HAVE_MICRO_OS_PLUS_CONFIG_H

    # NDEBUG provided by the toolchain definitions on release.
    $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:DEBUG>
    $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:TRACE>
)

# -----------------------------------------------------------------------------

target_compile_options(
  monolithic-app

  PRIVATE
    ${project_common_options}
)

target_link_options(
  monolithic-app

  PRIVATE
    ${project_common_options}
)

# -----------------------------------------------------------------------------
# Collect sources and headers from the portable packages.

include("xpacks/micro-os-plus-diag-trace/meta/xpack-helper.cmake")
target_sources_micro_os_plus_diag_trace(monolithic-app)
target_include_directories_micro_os_plus_diag_trace(monolithic-app)

if(NOT UNIX) # For now only newlib benefits from this package.
include("xpacks/micro-os-plus-libs-c/meta/xpack-helper.cmake")
target_sources_micro_os_plus_libs_c(monolithic-app)
target_include_directories_micro_os_plus_libs_c(monolithic-app)
endif()

include("xpacks/micro-os-plus-libs-cpp/meta/xpack-helper.cmake")
target_sources_micro_os_plus_libs_cpp(monolithic-app)
target_include_directories_micro_os_plus_libs_cpp(monolithic-app)

if(NOT UNIX)
include("xpacks/micro-os-plus-semihosting/meta/xpack-helper.cmake")
target_sources_micro_os_plus_semihosting(monolithic-app)
target_include_directories_micro_os_plus_semihosting(monolithic-app)
endif()

if(NOT UNIX)
include("xpacks/micro-os-plus-startup/meta/xpack-helper.cmake")
target_sources_micro_os_plus_startup(monolithic-app)
target_include_directories_micro_os_plus_startup(monolithic-app)
endif()

include("xpacks/micro-os-plus-version/meta/xpack-helper.cmake")
# Header only, no sources.
target_include_directories_micro_os_plus_version(monolithic-app)

# -----------------------------------------------------------------------------

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "")

# -----------------------------------------------------------------------------
