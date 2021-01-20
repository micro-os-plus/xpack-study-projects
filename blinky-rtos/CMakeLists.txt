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

message(STATUS "Build configuration: ${BUILD_CONFIG}")
message(STATUS "Project path: ${PROJECT_SOURCE_DIR}")

add_executable(xpack-target)

set_target_properties(
  xpack-target
  PROPERTIES
    SUFFIX ".elf"
    OUTPUT_NAME "${CMAKE_PROJECT_NAME}"
)

if(BUILD_CONFIG STREQUAL "stm32f4discovery-debug-cmake")
  set(CMAKE_BUILD_TYPE Debug)
  include("platform-stm32f4discovery/meta/xpack-target.cmake")
elseif(BUILD_CONFIG STREQUAL "stm32f4discovery-release-cmake")
  set(CMAKE_BUILD_TYPE Release)
  include("platform-stm32f4discovery/meta/xpack-target.cmake")
elseif(BUILD_CONFIG STREQUAL "stm32f0discovery-debug-cmake")
  set(CMAKE_BUILD_TYPE Debug)
  include("platform-stm32f0discovery/meta/xpack-target.cmake")
elseif(BUILD_CONFIG STREQUAL "stm32f0discovery-release-cmake")
  set(CMAKE_BUILD_TYPE Release)
  include("platform-stm32f0discovery/meta/xpack-target.cmake")
else()
  message(FATAL_ERROR, "Unsupported BUILD_CONFIG")
endif()

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")

include("xpacks/micro-os-plus-architecture-cortexm/meta/xpack-helper.cmake")
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

target_sources(
  xpack-target
  PRIVATE

    src/main.cpp
    src/_write.c
)

target_sources_platform_stm32f4discovery(xpack-target)
target_sources_micro_os_plus_architecture_cortexm(xpack-target)
target_sources_micro_os_plus_cmsis_os(xpack-target)
target_sources_micro_os_plus_diag_trace(xpack-target)
target_sources_micro_os_plus_libs_c(xpack-target)
target_sources_micro_os_plus_libs_cpp(xpack-target)
target_sources_micro_os_plus_libs_cpp_estd(xpack-target)
target_sources_micro_os_plus_memory_allocators(xpack-target)
target_sources_micro_os_plus_posix_io(xpack-target)
target_sources_micro_os_plus_rtos(xpack-target)
target_sources_micro_os_plus_semihosting(xpack-target)
target_sources_micro_os_plus_startup(xpack-target)
target_sources_micro_os_plus_utils_lists(xpack-target)

# -----------------------------------------------------------------------------

target_include_directories(
  xpack-target
  PRIVATE
  
    include
)

target_include_directories_platform_stm32f4discovery(xpack-target)
target_include_directories_micro_os_plus_architecture_cortexm(xpack-target)
target_include_directories_micro_os_plus_cmsis_os(xpack-target)
target_include_directories_micro_os_plus_diag_trace(xpack-target)
target_include_directories_micro_os_plus_libs_c(xpack-target)
target_include_directories_micro_os_plus_libs_cpp(xpack-target)
target_include_directories_micro_os_plus_libs_cpp_estd(xpack-target)
target_include_directories_micro_os_plus_memory_allocators(xpack-target)
target_include_directories_micro_os_plus_posix_io(xpack-target)
target_include_directories_micro_os_plus_rtos(xpack-target)
target_include_directories_micro_os_plus_semihosting(xpack-target)
target_include_directories_micro_os_plus_startup(xpack-target)
target_include_directories_micro_os_plus_utils_lists(xpack-target)
target_include_directories_micro_os_plus_version(xpack-target)

# -----------------------------------------------------------------------------

set(project_compile_definitions 
  HAVE_MICRO_OS_PLUS_CONFIG_H

  $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:DEBUG>
  $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:TRACE>

  $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Release">:NDEBUG>
)

target_compile_definitions(
  xpack-target
  PRIVATE
  
    ${project_compile_definitions}
)

# -----------------------------------------------------------------------------

set(project_common_options
    $<$<COMPILE_LANGUAGE:C>:-std=c11>
    # cxx_std_17 will generate -std=gnu++17
    $<$<COMPILE_LANGUAGE:CXX>:-std=c++17>

    $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:-O0>
    $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:-g3>

    $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Release">:-Os>
)

# -----------------------------------------------------------------------------

target_compile_options(
  xpack-target
  PRIVATE
  
    ${project_common_options}
)

# -----------------------------------------------------------------------------

target_link_options(
  xpack-target
  PRIVATE
  
    ${project_common_options}
)

# -----------------------------------------------------------------------------
