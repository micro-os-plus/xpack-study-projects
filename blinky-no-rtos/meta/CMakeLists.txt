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

message(STATUS "CMake version: ${CMAKE_VERSION}")

if(CMAKE_BINARY_DIR STREQUAL CMAKE_SOURCE_DIR)
  message(FATAL_ERROR "In-source builds are not supported. Please use separate folder for build.")
endif()

# -----------------------------------------------------------------------------

enable_language(C)
enable_language(CXX)
enable_language(ASM)

# Specify the C/C++ standards.
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS ON)

message(STATUS "Compiler: ${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION}")

# Not effecitve, no idea why.
set(CMAKE_C_OUTPUT_EXTENSION ".o")
set(CMAKE_CXX_OUTPUT_EXTENSION ".o")

# Generate the compile_commands.json file to feed the indexer.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Enable this to see the dependency graph.
# set_property(GLOBAL PROPERTY GLOBAL_DEPENDS_DEBUG_MODE 1)

# -----------------------------------------------------------------------------

get_filename_component(xpack_project_folder ${CMAKE_SOURCE_DIR} DIRECTORY)

include("${xpack_project_folder}/xpacks/micro-os-plus-build-helper/cmake/xpack-helper.cmake")

list(APPEND CMAKE_PREFIX_PATH "${xpack_project_folder}/meta")
xpack_append_cmake_prefix_path("${xpack_project_folder}/xpacks")

# -----------------------------------------------------------------------------

message(STATUS "Platform name: ${PLATFORM_NAME}")
# CMAKE_BUILD_TYPE: Debug, Release, RelWithDebInfo, MinSizeRel
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "Project path: ${xpack_project_folder}")
message(STATUS "Prefix path: ${CMAKE_PREFIX_PATH}")

# -----------------------------------------------------------------------------

project(
	blinky
	DESCRIPTION "A blinky not using the µOS++ RTOS"
)

# -----------------------------------------------------------------------------

# Common to all platforms.
add_compile_definitions(
  # NDEBUG provided by the toolchain definitions on release.
  $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:DEBUG>
  $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:TRACE>
)

# -----------------------------------------------------------------------------

# Bare-metal executables have the .elf extension, and use --whole-archive.
if(CMAKE_SYSTEM_NAME STREQUAL "Generic")
  set(CMAKE_EXECUTABLE_SUFFIX ".elf")
endif()

# -----------------------------------------------------------------------------
# Include the platform dependent scripts.
# This also defines the global options, and must be performed
# before defining any target.

if(PLATFORM_NAME STREQUAL "stm32f4discovery")
  include("${xpack_project_folder}/platform-stm32f4discovery/meta/config.cmake")
elseif(PLATFORM_NAME STREQUAL "stm32f0discovery")
  include("${xpack_project_folder}/platform-stm32f0discovery/meta/config.cmake")
elseif(PLATFORM_NAME STREQUAL "sifive-hifive1")
  include("${xpack_project_folder}/platform-sifive-hifive1/meta/config.cmake")
elseif(PLATFORM_NAME STREQUAL "synthetic-posix")
  include("${xpack_project_folder}/platform-synthetic-posix/meta/config.cmake")
else()
  message(FATAL_ERROR, "Unsupported PLATFORM_NAME=${PLATFORM_NAME}")
endif()

# -----------------------------------------------------------------------------
# Create the application.

add_executable(application)
message(STATUS "==> application")

set_target_properties(
  application

  PROPERTIES
    OUTPUT_NAME "${CMAKE_PROJECT_NAME}"
)

# Application sources.
target_sources(
  application

  PRIVATE
    ${xpack_project_folder}/src/main.cpp
    ${xpack_project_folder}/src/_write.c
    ${xpack_project_folder}/sysclock/src/sysclock.cpp
)

# Application includes.
target_include_directories(
  application

  PRIVATE
    # ${xpack_project_folder}/include
    ${xpack_project_folder}/sysclock/include
)

# Application definitions.
target_compile_definitions(
  application

  PRIVATE
    # None so far, see the global definitions.
)

# -----------------------------------------------------------------------------
# Add the platform libraries.

target_link_libraries(
  application

  PRIVATE
    # Should bring device & architecture too. 
    micro-os-plus::platform
)

# -----------------------------------------------------------------------------

if(CMAKE_SYSTEM_NAME STREQUAL "Generic")

  # ---------------------------------------------------------------------------
  # Add more portable libraries.

  find_package(micro-os-plus-libs-c REQUIRED)
  find_package(micro-os-plus-libs-cpp REQUIRED)
  find_package(micro-os-plus-semihosting REQUIRED)
  find_package(micro-os-plus-startup REQUIRED)

  target_link_libraries(
    application

    PRIVATE 
      micro-os-plus::libs-c
      micro-os-plus::libs-cpp
      micro-os-plus::semihosting
      micro-os-plus::startup
  )

  # ---------------------------------------------------------------------------
  # For embedded targets, generate map and display sizes.

  target_link_options(
    application

    PRIVATE
      -Wl,-Map,${CMAKE_PROJECT_NAME}-map.txt
  )

  add_custom_command(
    TARGET application POST_BUILD
    COMMAND ${CMAKE_SIZE} --format=berkeley "$<TARGET_FILE:application>"
  )

endif()

# -----------------------------------------------------------------------------

message(STATUS "")

# -----------------------------------------------------------------------------
