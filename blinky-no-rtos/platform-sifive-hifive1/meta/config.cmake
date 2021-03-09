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
# - the micro-os-plus::device library
# - the micro-os-plus::platform library

message(STATUS "Including platform-sifive-hifive1...")

# -----------------------------------------------------------------------------
# Preprocessor symbols. Before dependencies.

# TODO: migrate them to CMake options.
set(xpack_device_compile_definition "SIFIVE_FE310")

# -----------------------------------------------------------------------------

include("${CMAKE_CURRENT_LIST_DIR}/globals.cmake")

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

  target_compile_options(
    platform-sifive-hifive1-interface

    INTERFACE
      # ...
  )

  target_link_libraries(
    platform-sifive-hifive1-interface
    
    INTERFACE
      sifive::platform-hifive1
      micro-os-plus::diag-trace
      micro-os-plus::startup
  )

  # ---------------------------------------------------------------------------
  # Aliases
  
  add_library(micro-os-plus::platform ALIAS platform-sifive-hifive1-interface)
  message(STATUS "=> micro-os-plus::platform")

endif()

# -----------------------------------------------------------------------------
