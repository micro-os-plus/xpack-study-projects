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

# This file defines (order is important):
# - preprocessor symbols
# - the global settings
# - dependencies
# - the micro-os-plus::device library
# - the micro-os-plus::platform library

message(STATUS "Including platform-sifive-hifive1...")

# -----------------------------------------------------------------------------
# Preprocessor symbols. Before dependencies.

# TODO: migrate them to CMake options.
set(xpack_device_compile_definition "SIFIVE_FE310")
message(STATUS "${xpack_device_compile_definition}")

# -----------------------------------------------------------------------------
# The current folder.

get_filename_component(xpack_current_folder ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)

# -----------------------------------------------------------------------------
# Global definitions. Before any libraries.

include_directories(

  # The platform defines the <micro-os-plus/config.h> header, to be
  # passed to all sources.
  ${xpack_current_folder}/include
)

add_compile_definitions(

  OS_USE_SEMIHOSTING_SYSCALLS
  HAVE_MICRO_OS_PLUS_CONFIG_H
  OS_USE_CPP_INTERRUPTS

  $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:OS_USE_TRACE_SEMIHOSTING_DEBUG>
)

set(common_cpu_options 

  -march=rv32imac
  -mabi=ilp32 
  -mcmodel=medany 
  -msmall-data-limit=8 
  -mno-save-restore
)

set(common_optimization_options

  -fmessage-length=0
  -fsigned-char
  -ffunction-sections
  -fdata-sections
  -fno-move-loop-invariants

  $<$<COMPILE_LANGUAGE:CXX>:-fabi-version=0>
  $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
  $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
  $<$<COMPILE_LANGUAGE:CXX>:-fno-use-cxa-atexit>
  $<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>

  # -Wunused
  # -Wuninitialized
  # -Wall
  # -Wextra
  # -Wconversion
  # -Wpointer-arith
  # -Wshadow
  # -Wlogical-op
  # -Wfloat-equal

  # $<$<COMPILE_LANGUAGE:CXX>:-Wctor-dtor-privacy>
  # $<$<COMPILE_LANGUAGE:CXX>:-Wnoexcept>
  # $<$<COMPILE_LANGUAGE:CXX>:-Wnon-virtual-dtor>
  # $<$<COMPILE_LANGUAGE:CXX>:-Wstrict-null-sentinel>
  # $<$<COMPILE_LANGUAGE:CXX>:-Wsign-promo>
)

add_compile_options(

    ${common_cpu_options}
    ${common_optimization_options}
)

add_link_options(

    ${common_cpu_options}
    ${common_optimization_options}
)

add_link_options(
  
    -nostartfiles
    # nano has no exceptions.
    -specs=nano.specs
    -Wl,--gc-sections

    # -Wl,--undefined,Reset_Handler

    # Including files from other packages is not very nice, but functional.
    # Use absolute paths, otherwise set -L.
    -T${xpack_current_folder}/linker-scripts/mem.ld
    -T${xpack_project_folder}/xpacks/micro-os-plus-architecture-riscv/linker-scripts/sections.ld
)

# -----------------------------------------------------------------------------
# Dependencies.

find_package(xpack-sifive-platform-hifive1 REQUIRED)
find_package(micro-os-plus-startup REQUIRED)
find_package(micro-os-plus-diag-trace REQUIRED)

# -----------------------------------------------------------------------------
# Recompute current path after find_package().

get_filename_component(xpack_current_folder ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)

# -----------------------------------------------------------------------------
# Device specific code.

if (NOT TARGET micro-os-plus::device)

  # ---------------------------------------------------------------------------
  # Aliases

  add_library(micro-os-plus::device ALIAS xpack-sifive-devices-interface)
  message(STATUS "micro-os-plus::device")

endif()

# -----------------------------------------------------------------------------

if(NOT TARGET platform-sifive-hifive1-interface)

  # It is not static, because it must compile in the application
  # context, otherwise some sources, like sysclock, bring circular
  # dependencies.
  add_library(platform-sifive-hifive1-interface INTERFACE EXCLUDE_FROM_ALL)

  # ---------------------------------------------------------------------------

  target_sources(
    platform-sifive-hifive1-interface

    INTERFACE
      ${xpack_current_folder}/src/initialize-hardware.cpp
      ${xpack_current_folder}/src/interrupts-handlers.cpp
      ${xpack_current_folder}/src/led.cpp      
  )

  target_include_directories(
    platform-sifive-hifive1-interface

    INTERFACE
      # Passed globally.
      # ${xpack_current_folder}/include
  )

  target_link_libraries(
    platform-sifive-hifive1-interface
    
    INTERFACE
      sifive::platform-hifive1
      micro-os-plus::diag-trace-static
      micro-os-plus::startup-static
  )

  # ---------------------------------------------------------------------------
  # Aliases
  
  add_library(micro-os-plus::platform ALIAS platform-sifive-hifive1-interface)
  message(STATUS "micro-os-plus::platform")

endif()

# -----------------------------------------------------------------------------
