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

# CubeMX generates both device and platform specific code.
# Split it into separate libraries.

message(STATUS "Including platform-stm32f0discovery...")

# -----------------------------------------------------------------------------
# Preprocessor symbols. Before dependencies.

# TODO: migrate them to CMake options.
set(xpack_platform_compile_definition "PLATFORM_STM32F0DISCOVERY")
message(STATUS "${xpack_platform_compile_definition}")

set(xpack_device_compile_definition "STM32F051x8") # STM32F051R8"
message(STATUS "${xpack_device_compile_definition}")

# set(xpack_device_family_compile_definition "STM32F0")

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

  $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:OS_USE_TRACE_SEMIHOSTING_DEBUG>
)

set(common_cpu_options 

  -mcpu=cortex-m0
  -mthumb
  -mfloat-abi=soft
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
    -T${xpack_project_folder}/xpacks/micro-os-plus-architecture-cortexm/linker-scripts/sections.ld
)

# -----------------------------------------------------------------------------
# Dependencies.

find_package(micro-os-plus-devices-stm32f0-extras REQUIRED)
find_package(micro-os-plus-architecture-cortexm REQUIRED)
find_package(micro-os-plus-startup REQUIRED)
find_package(micro-os-plus-diag-trace REQUIRED)

# -----------------------------------------------------------------------------

# Recompute current path after find_package().
get_filename_component(xpack_current_folder ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)

# -----------------------------------------------------------------------------
# Device specific code.

if (NOT TARGET micro-os-plus-device-interface)

  # The device library includes the architecture device specific
  # code and the CubeMX generated code.
  add_library(micro-os-plus-device-interface INTERFACE EXCLUDE_FROM_ALL)

  # ---------------------------------------------------------------------------

  # Add the CubeMX device specific definitions.
  target_sources(
    micro-os-plus-device-interface

    INTERFACE
      ${xpack_current_folder}/stm32cubemx/Core/Src/system_stm32f0xx.c
  )

  target_include_directories(
    micro-os-plus-device-interface

    INTERFACE
      # For the CMSIS Core headers.
      ${xpack_current_folder}/stm32cubemx/Drivers/CMSIS/Include

      # For the CMSIS vendor files (stm32f4xx.h, system_stm32f4xx.h)
      ${xpack_current_folder}/stm32cubemx/Drivers/CMSIS/Device/ST/STM32F0xx/Include
  )

  target_compile_definitions(
    micro-os-plus-device-interface

    INTERFACE
      "${xpack_device_compile_definition}"
  )

  target_link_libraries(
    micro-os-plus-device-interface

    INTERFACE
      # Use the device specific definitions from the architecture (hack!).
      micro-os-plus::architecture-cortexm-device

      micro-os-plus::devices-stm32f0-extras
      micro-os-plus::startup-static
  )

  # ---------------------------------------------------------------------------
  # Aliases

  add_library(micro-os-plus::device ALIAS micro-os-plus-device-interface)
  message(STATUS "micro-os-plus::device")

endif()

# -----------------------------------------------------------------------------

if(NOT TARGET platform-stm32f0discovery-interface)

  # It is not static, because it must compile in the application
  # context, otherwise some sources, like sysclock, bring circular
  # dependencies.
  add_library(platform-stm32f0discovery-interface INTERFACE EXCLUDE_FROM_ALL)

  # ---------------------------------------------------------------------------

  target_sources(
    platform-stm32f0discovery-interface

    INTERFACE
      ${xpack_current_folder}/src/initialize-hardware.cpp
      ${xpack_current_folder}/src/interrupts-handlers.cpp
      ${xpack_current_folder}/src/led.cpp
      
      ${xpack_current_folder}/stm32cubemx/Core/Src/gpio.c
      ${xpack_current_folder}/stm32cubemx/Core/Src/main.c
      ${xpack_current_folder}/stm32cubemx/Core/Src/stm32f0xx_hal_msp.c
      ${xpack_current_folder}/stm32cubemx/Core/Src/stm32f0xx_it.c

      # system_stm32f0xx.c is not here but in the device library.

      # These are not in the device library because they include
      # stm32f0xx_hal_conf.h, which is part of the platform.
      ${xpack_current_folder}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_cortex.c
      ${xpack_current_folder}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_dma.c
      ${xpack_current_folder}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_exti.c
      ${xpack_current_folder}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_flash_ex.c
      ${xpack_current_folder}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_flash.c
      ${xpack_current_folder}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_gpio.c
      ${xpack_current_folder}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_pwr_ex.c
      ${xpack_current_folder}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_pwr.c
      ${xpack_current_folder}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_rcc_ex.c
      ${xpack_current_folder}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_rcc.c
      ${xpack_current_folder}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_tim_ex.c
      ${xpack_current_folder}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_tim.c
      ${xpack_current_folder}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal.c
  )

  target_include_directories(
    platform-stm32f0discovery-interface

    INTERFACE
      # Passed globally.
      # ${xpack_current_folder}/include

      # For the stm32f0xx_hal_conf.h, stm32f0xx_it.h, gpio.h, main.h
      ${xpack_current_folder}/stm32cubemx/Core/Inc

      # For the stm32f4xx_hal.h and stm32f4xx_hal_*.h
      ${xpack_current_folder}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Inc
  )

  target_compile_definitions(
    platform-stm32f0discovery-interface
    
    INTERFACE
      ${xpack_platform_compile_definition}
      
      USE_HAL_DRIVER
  )

  target_link_libraries(
    platform-stm32f0discovery-interface
    
    INTERFACE
      micro-os-plus::device
      micro-os-plus::diag-trace-static
      micro-os-plus::startup-static
  )

  # ---------------------------------------------------------------------------
  # Aliases
  
  add_library(micro-os-plus::platform ALIAS platform-stm32f0discovery-interface)
  message(STATUS "micro-os-plus::platform")

endif()

# -----------------------------------------------------------------------------
