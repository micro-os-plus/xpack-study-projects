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

message(STATUS "Including platform-sifive-hifive1...")

# -----------------------------------------------------------------------------

# Preprocessor symbols.
set(xpack_platform_compile_definition "PLATFORM_SIFIVE_HIFIVE1")
set(xpack_device_compile_definition "SIFIVE_FE310")

# -----------------------------------------------------------------------------

function(target_sources_micro_os_plus_platform target)

  get_filename_component(xpack_root_folder ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  target_sources(
    ${target}

    PRIVATE
      ${xpack_root_folder}/src/initialize-hardware.cpp
      ${xpack_root_folder}/src/interrupts-handlers.cpp
      ${xpack_root_folder}/src/led.cpp      
  )

  target_sources_xpack_sifive_platform_hifive1(${target})

endfunction()

# -----------------------------------------------------------------------------

function(target_include_directories_micro_os_plus_platform target)

  get_filename_component(xpack_root_folder ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  target_include_directories(
    ${target}

    PRIVATE
      ${xpack_root_folder}/include
  )

  target_include_directories_xpack_sifive_platform_hifive1(${target})

endfunction()

# -----------------------------------------------------------------------------

function(target_compile_definitions_micro_os_plus_platform target)

  get_filename_component(xpack_root_folder ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  target_compile_definitions(
    ${target}

    PRIVATE
      ${xpack_platform_compile_definition}
      ${xpack_device_compile_definition}
      
      OS_USE_SEMIHOSTING_SYSCALLS
      OS_USE_CPP_INTERRUPTS

      $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:OS_USE_TRACE_SEMIHOSTING_DEBUG>
  )

endfunction()

# -----------------------------------------------------------------------------

function(target_options_micro_os_plus_platform target)

  get_filename_component(xpack_root_folder ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  set(platform_cpu_option 

    -march=rv32imac
    -mabi=ilp32 
    -mcmodel=medany 
    -msmall-data-limit=8 
    -mno-save-restore
  )

  set(platform_common_options

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

  target_compile_options(
    ${target}

    PRIVATE
      ${platform_cpu_option}
      ${platform_common_options}
  )

  target_link_options(
    ${target}

    PRIVATE
      ${platform_cpu_option}
      ${platform_common_options}

      -nostartfiles
      -specs=nano.specs
      -Xlinker --gc-sections
      -Wl,-Map,${CMAKE_PROJECT_NAME}.map

      # Use absolute paths, otherwise set -L.
      -T${xpack_root_folder}/linker-scripts/mem.ld

      # Including files from other packages is not very nice, but functional.
      -T${PROJECT_SOURCE_DIR}/xpacks/micro-os-plus-architecture-riscv/linker-scripts/sections.ld
  )

endfunction()

# -----------------------------------------------------------------------------

function(target_sources_micro_os_plus_device target)

  target_sources_xpack_sifive_devices(${target})

endfunction()

# -----------------------------------------------------------------------------

function(target_include_directories_micro_os_plus_device target)

  target_include_directories_xpack_sifive_devices(${target})

endfunction()

# -----------------------------------------------------------------------------
