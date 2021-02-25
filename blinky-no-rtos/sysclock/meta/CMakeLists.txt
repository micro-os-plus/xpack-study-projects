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

message(STATUS "Including sysclock...")

# -----------------------------------------------------------------------------

get_filename_component(xpack_current_folder ${CMAKE_CURRENT_SOURCE_DIR} DIRECTORY)

# -----------------------------------------------------------------------------

find_package(micro-os-plus-diag-trace REQUIRED)

add_library(sysclock-static STATIC EXCLUDE_FROM_ALL)

# -----------------------------------------------------------------------------
# Target settings.

target_sources(
  sysclock-static

  PRIVATE
    ${xpack_current_folder}/src/sysclock.cpp
)

target_include_directories(
  sysclock-static

  INTERFACE
    ${xpack_current_folder}/include
)

target_link_libraries(
  sysclock-static

  PUBLIC
    micro-os-plus::diag-trace-static
    micro-os-plus::platform
)


# -----------------------------------------------------------------------------
