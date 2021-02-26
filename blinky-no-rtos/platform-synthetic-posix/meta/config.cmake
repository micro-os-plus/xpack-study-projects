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
# - preprocessor symbols
# - the global settings
# - dependencies
# - the micro-os-plus::platform library

# Note: the micro-os-plus::device library is defined in the
# architecture-synthetic-posix package.

message(STATUS "Including platform-synthetic-posix...")

# -----------------------------------------------------------------------------
# Preprocessor symbols.

set(xpack_platform_compile_definition "PLATFORM_SYNTHETIC_POSIX")

# -----------------------------------------------------------------------------

include("${CMAKE_CURRENT_LIST_DIR}/globals.cmake")

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
