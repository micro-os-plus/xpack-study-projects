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

# This file defines the following (the order is important):
# - the global settings
# - dependencies
# - the micro-os-plus::platform library

# Note: the micro-os-plus::device library is defined in the
# architecture-synthetic-posix package.

message(STATUS "Including platform-synthetic-posix...")

# -----------------------------------------------------------------------------
# The current folder.

get_filename_component(xpack_current_folder ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)

# -----------------------------------------------------------------------------
# Preprocessor symbols.

set(xpack_platform_compile_definition "PLATFORM_SYNTHETIC_POSIX")

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

  $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:OS_USE_TRACE_SEMIHOSTING_DEBUG>
)

set(common_cpu_options 

  # None
)

set(common_optimization_options

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

add_compile_options(

  ${common_cpu_options}
  ${common_optimization_options}
)

add_link_options(

  ${common_cpu_options}
  ${common_optimization_options}
)

add_link_options(
  
  # GCC specific
  # -Xlinker --gc-sections

  # -Map not supported by clang
  # -Wl,-Map,${CMAKE_PROJECT_NAME}.map
)

# -----------------------------------------------------------------------------
# Dependencies.

find_package(micro-os-plus-architecture-synthetic-posix REQUIRED)
find_package(micro-os-plus-diag-trace REQUIRED)

# -----------------------------------------------------------------------------

# Recompute current path after find_package().
get_filename_component(xpack_current_folder ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)

# -----------------------------------------------------------------------------

if(NOT TARGET platform-synthetic-posix-interface)

  add_library(platform-synthetic-posix-interface INTERFACE EXCLUDE_FROM_ALL)

  target_sources(
    platform-synthetic-posix-interface

    INTERFACE
      ${xpack_current_folder}/src/led.cpp      
  )

  target_include_directories(
    platform-synthetic-posix-interface

    INTERFACE
      ${xpack_current_folder}/include
  )

  target_compile_definitions(
    platform-synthetic-posix-interface

    INTERFACE
      ${xpack_platform_compile_definition}

      $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:OS_USE_TRACE_POSIX_STDOUT>
  )

  target_link_libraries(
    platform-synthetic-posix-interface
    
    INTERFACE
      micro-os-plus::architecture-synthetic-posix
      micro-os-plus::diag-trace-static
  )

  # ---------------------------------------------------------------------------
  # Aliases
  
  add_library(micro-os-plus::platform ALIAS platform-synthetic-posix-interface)
  message(STATUS "micro-os-plus::platform")

endif()

# -----------------------------------------------------------------------------
