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

message(STATUS "Including platform-synthetic-posix...")

# -----------------------------------------------------------------------------

# Preprocessor symbols.
set(xpack_platform_compile_definition "PLATFORM_SYNTHETIC_POSIX")

# -----------------------------------------------------------------------------

function(target_sources_micro_os_plus_platform target)

  get_filename_component(xpack_root_folder ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  target_sources(
    ${target}

    PRIVATE
      ${xpack_root_folder}/src/led.cpp      
  )

endfunction()

# -----------------------------------------------------------------------------

function(target_include_directories_micro_os_plus_platform target)

  get_filename_component(xpack_root_folder ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  target_include_directories(
    ${target}

    PRIVATE
      ${xpack_root_folder}/include
  )

endfunction()

# -----------------------------------------------------------------------------

function(target_compile_definitions_micro_os_plus_platform target)

  get_filename_component(xpack_root_folder ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  target_compile_definitions(
    ${target}

    PRIVATE
      ${xpack_platform_compile_definition}

      _XOPEN_SOURCE=700
      $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:OS_USE_TRACE_POSIX_STDOUT>
  )

endfunction()

# -----------------------------------------------------------------------------

function(target_options_micro_os_plus_platform target)

  get_filename_component(xpack_root_folder ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  set(platform_cpu_option
  
    # None
  )

  set(platform_common_options

    -fmessage-length=0
    -fsigned-char
    -ffunction-sections
    -fdata-sections

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

      # GCC specific
      # -Xlinker --gc-sections

      # -Map not supported by clang
      # -Wl,-Map,${CMAKE_PROJECT_NAME}.map
  )

endfunction()

# -----------------------------------------------------------------------------

function(target_sources_micro_os_plus_device target)

  # None

endfunction()

# -----------------------------------------------------------------------------

function(target_include_directories_micro_os_plus_device target)

  # None

endfunction()

# -----------------------------------------------------------------------------
# Forward architecture to architecture-cortexm.

function(target_sources_micro_os_plus_architecture target)

  target_sources_micro_os_plus_architecture_synthetic_posix(${target})

endfunction()


function(target_include_directories_micro_os_plus_architecture target)

  target_include_directories_micro_os_plus_architecture_synthetic_posix(${target})

endfunction()


function(target_compile_definitions_micro_os_plus_architecture target)

  target_compile_definitions_micro_os_plus_architecture_synthetic_posix(${target})

endfunction()

# -----------------------------------------------------------------------------
