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

# This file defines the global settings that apply to all targets.

# -----------------------------------------------------------------------------
# The current folder.

get_filename_component(xpack_current_folder ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)

# -----------------------------------------------------------------------------
# Global settings. Must be called before defining any libraries.

include_directories(

  # The platform defines the <micro-os-plus/config.h> header, to be
  # passed to all sources.
  ${xpack_current_folder}/include
)

add_compile_definitions(

  MICRO_OS_PLUS_USE_SEMIHOSTING_SYSCALLS
  HAVE_MICRO_OS_PLUS_CONFIG_H
  MICRO_OS_PLUS_USE_CPP_INTERRUPTS

  $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:MICRO_OS_PLUS_USE_TRACE_SEMIHOSTING_DEBUG>
)

xpack_set_all_compiler_warnings(warnings)

set(common_options 

  -march=rv32imac
  -mabi=ilp32 
  -mcmodel=medany 
  -msmall-data-limit=8 
  -mno-save-restore

  -fmessage-length=0
  -fsigned-char

  -ffunction-sections
  -fdata-sections

  $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:-fno-move-loop-invariants>

  $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
  $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
  $<$<COMPILE_LANGUAGE:CXX>:-fno-use-cxa-atexit>
  $<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>

  ${warnings}

  -Werror
  -pedantic-errors
)

add_compile_options(

    ${common_options}
)

add_link_options(

    ${common_options}
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
