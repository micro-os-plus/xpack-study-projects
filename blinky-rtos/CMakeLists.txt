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

cmake_minimum_required(VERSION 3.18)

project(
	blinky-rtos
	DESCRIPTION "A blinky using the µOS++ RTOS"
)

enable_language(C)
enable_language(CXX)
enable_language(ASM)

message(STATUS "Build configuration: ${BUILD_CONFIG}")
message(STATUS "Project path: ${PROJECT_SOURCE_DIR}")

add_executable(monolithic-app)

set_target_properties(
  monolithic-app

  PROPERTIES
    SUFFIX ".elf"
    OUTPUT_NAME "${CMAKE_PROJECT_NAME}"
)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# -----------------------------------------------------------------------------
# Include the platform dependent scripts.
# CMAKE_BUILD_TYPE: Debug, Release, RelWithDebInfo, MinSizeRel

if(BUILD_CONFIG STREQUAL "stm32f4discovery-debug-cmake")
  set(CMAKE_BUILD_TYPE Debug)
  include("platform-stm32f4discovery/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-devices-stm32f4/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-architecture-cortexm/meta/xpack-helper.cmake")
elseif(BUILD_CONFIG STREQUAL "stm32f4discovery-release-cmake")
  set(CMAKE_BUILD_TYPE MinSizeRel)
  include("platform-stm32f4discovery/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-devices-stm32f4/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-architecture-cortexm/meta/xpack-helper.cmake")
elseif(BUILD_CONFIG STREQUAL "stm32f0discovery-debug-cmake")
  set(CMAKE_BUILD_TYPE Debug)
  include("platform-stm32f0discovery/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-devices-stm32f0/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-architecture-cortexm/meta/xpack-helper.cmake")
elseif(BUILD_CONFIG STREQUAL "stm32f0discovery-release-cmake")
  set(CMAKE_BUILD_TYPE MinSizeRel)
  include("platform-stm32f0discovery/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-devices-stm32f0/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-architecture-cortexm/meta/xpack-helper.cmake")
elseif(BUILD_CONFIG STREQUAL "sifive-hifive1-debug-cmake")
  set(CMAKE_BUILD_TYPE Debug)
  include("platform-sifive-hifive1/meta/xpack-helper.cmake")
  include("xpacks/xpack-sifive-platform-hifive1/meta/xpack-helper.cmake")
  include("xpacks/xpack-sifive-devices/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-architecture-riscv/meta/xpack-helper.cmake")
elseif(BUILD_CONFIG STREQUAL "sifive-hifive1-release-cmake")
  set(CMAKE_BUILD_TYPE MinSizeRel)
  include("platform-sifive-hifive1/meta/xpack-helper.cmake")
  include("xpacks/xpack-sifive-platform-hifive1/meta/xpack-helper.cmake")
  include("xpacks/xpack-sifive-devices/meta/xpack-helper.cmake")
  include("xpacks/micro-os-plus-architecture-riscv/meta/xpack-helper.cmake")
else()
  message(FATAL_ERROR, "Unsupported BUILD_CONFIG")
endif()

# -----------------------------------------------------------------------------
# Include the portable scripts.

include("xpacks/micro-os-plus-cmsis-os/meta/xpack-helper.cmake")
include("xpacks/micro-os-plus-diag-trace/meta/xpack-helper.cmake")
include("xpacks/micro-os-plus-libs-c/meta/xpack-helper.cmake")
include("xpacks/micro-os-plus-libs-cpp/meta/xpack-helper.cmake")
include("xpacks/micro-os-plus-libs-cpp-estd/meta/xpack-helper.cmake")
include("xpacks/micro-os-plus-memory-allocators/meta/xpack-helper.cmake")
include("xpacks/micro-os-plus-posix-io/meta/xpack-helper.cmake")
include("xpacks/micro-os-plus-rtos/meta/xpack-helper.cmake")
include("xpacks/micro-os-plus-semihosting/meta/xpack-helper.cmake")
include("xpacks/micro-os-plus-startup/meta/xpack-helper.cmake")
include("xpacks/micro-os-plus-utils-lists/meta/xpack-helper.cmake")
include("xpacks/micro-os-plus-version/meta/xpack-helper.cmake")

# -----------------------------------------------------------------------------
# Collect all sources.

# Application sources.
target_sources(
  monolithic-app

  PRIVATE
    src/main.cpp
    src/_write.c
)

# Platform specific sources.
target_sources_micro_os_plus_platform(monolithic-app)
target_sources_micro_os_plus_device(monolithic-app)
target_sources_micro_os_plus_architecture(monolithic-app)

# Portable sources.
target_sources_micro_os_plus_cmsis_os(monolithic-app)
target_sources_micro_os_plus_diag_trace(monolithic-app)
target_sources_micro_os_plus_libs_c(monolithic-app)
target_sources_micro_os_plus_libs_cpp(monolithic-app)
target_sources_micro_os_plus_libs_cpp_estd(monolithic-app)
target_sources_micro_os_plus_memory_allocators(monolithic-app)
target_sources_micro_os_plus_posix_io(monolithic-app)
target_sources_micro_os_plus_rtos(monolithic-app)
target_sources_micro_os_plus_semihosting(monolithic-app)
target_sources_micro_os_plus_startup(monolithic-app)
target_sources_micro_os_plus_utils_lists(monolithic-app)

# -----------------------------------------------------------------------------
# Collect all include folders.

# Application includes.
target_include_directories(
  monolithic-app

  PRIVATE
    include
)

# Platform specific includes.
target_include_directories_micro_os_plus_platform(monolithic-app)
target_include_directories_micro_os_plus_device(monolithic-app)
target_include_directories_micro_os_plus_architecture(monolithic-app)

# Portable includes.
target_include_directories_micro_os_plus_cmsis_os(monolithic-app)
target_include_directories_micro_os_plus_diag_trace(monolithic-app)
target_include_directories_micro_os_plus_libs_c(monolithic-app)
target_include_directories_micro_os_plus_libs_cpp(monolithic-app)
target_include_directories_micro_os_plus_libs_cpp_estd(monolithic-app)
target_include_directories_micro_os_plus_memory_allocators(monolithic-app)
target_include_directories_micro_os_plus_posix_io(monolithic-app)
target_include_directories_micro_os_plus_rtos(monolithic-app)
target_include_directories_micro_os_plus_semihosting(monolithic-app)
target_include_directories_micro_os_plus_startup(monolithic-app)
target_include_directories_micro_os_plus_utils_lists(monolithic-app)
target_include_directories_micro_os_plus_version(monolithic-app)

# -----------------------------------------------------------------------------

target_compile_definitions_micro_os_plus_platform(monolithic-app)

# TODO: consider packages that may also contribute preprocessor definitions.

# -----------------------------------------------------------------------------

target_compile_definitions(
  monolithic-app

  PRIVATE
    HAVE_MICRO_OS_PLUS_CONFIG_H

    # NDEBUG provided by the toolchain definitions on release.
    $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:DEBUG>
    $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:TRACE>
)

# -----------------------------------------------------------------------------

set(project_common_options

    $<$<COMPILE_LANGUAGE:C>:-std=c11>
    # cxx_std_17 will generate -std=gnu++17
    $<$<COMPILE_LANGUAGE:CXX>:-std=c++17>
)

# -----------------------------------------------------------------------------

target_compile_options(
  monolithic-app

  PRIVATE
    ${project_common_options}
)

# -----------------------------------------------------------------------------

target_link_options(
  monolithic-app

  PRIVATE
    ${project_common_options}
)

# -----------------------------------------------------------------------------

target_options_micro_os_plus_platform(monolithic-app)

# -----------------------------------------------------------------------------

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "")

# -----------------------------------------------------------------------------
