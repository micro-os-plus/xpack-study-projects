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

message(STATUS "Including platform-stm32f0discovery...")

# Preprocessor symbols.
set(XPACK_PLATFORM_COMPILE_DEFINITION "PLATFORM_STM32F0DISCOVERY")
set(XPACK_DEVICE_COMPILE_DEFINITION "STM32F051x8") # STM32F051R8"
set(XPACK_DEVICE_FAMILY_COMPILE_DEFINITION "STM32F0")

function(target_sources_micro_os_plus_platform target)

  get_filename_component(PARENT_DIR ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  target_sources(
    ${target}

    PRIVATE
      ${PARENT_DIR}/src/initialize-hardware.cpp
      ${PARENT_DIR}/src/interrupts-handlers.cpp
      ${PARENT_DIR}/src/led.cpp
      
      ${PARENT_DIR}/stm32cubemx/Core/Src/gpio.c
      ${PARENT_DIR}/stm32cubemx/Core/Src/main.c
      ${PARENT_DIR}/stm32cubemx/Core/Src/stm32f0xx_hal_msp.c
      ${PARENT_DIR}/stm32cubemx/Core/Src/stm32f0xx_it.c
      ${PARENT_DIR}/stm32cubemx/Core/Src/system_stm32f0xx.c

      ${PARENT_DIR}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_cortex.c
      ${PARENT_DIR}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_dma.c
      ${PARENT_DIR}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_exti.c
      ${PARENT_DIR}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_flash_ex.c
      ${PARENT_DIR}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_flash.c
      ${PARENT_DIR}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_gpio.c
      ${PARENT_DIR}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_pwr_ex.c
      ${PARENT_DIR}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_pwr.c
      ${PARENT_DIR}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_rcc_ex.c
      ${PARENT_DIR}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_rcc.c
      ${PARENT_DIR}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_tim_ex.c
      ${PARENT_DIR}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal_tim.c
      ${PARENT_DIR}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Src/stm32f0xx_hal.c
  )
endfunction()

function(target_include_directories_micro_os_plus_platform target)

  get_filename_component(PARENT_DIR ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  target_include_directories(
    ${target}

    PRIVATE
      ${PARENT_DIR}/include
      ${PARENT_DIR}/stm32cubemx/Core/Inc
      ${PARENT_DIR}/stm32cubemx/Drivers/CMSIS/Device/ST/STM32F0xx/Include
      ${PARENT_DIR}/stm32cubemx/Drivers/CMSIS/Include
      ${PARENT_DIR}/stm32cubemx/Drivers/STM32F0xx_HAL_Driver/Inc
  )
endfunction()

function(target_compile_definitions_micro_os_plus_platform target)

  get_filename_component(PARENT_DIR ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  target_compile_definitions(
    ${target}
    
    PRIVATE
      ${XPACK_PLATFORM_COMPILE_DEFINITION}
      ${XPACK_DEVICE_COMPILE_DEFINITION}
      ${XPACK_DEVICE_FAMILY_COMPILE_DEFINITION}
      
      USE_HAL_DRIVER
      OS_USE_SEMIHOSTING_SYSCALLS

      $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:OS_USE_TRACE_SEMIHOSTING_DEBUG>
  )
endfunction()

function(target_options_micro_os_plus_platform target)

  get_filename_component(PARENT_DIR ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  set(platform_cpu 

    -mcpu=cortex-m0
    -mthumb
    -mfloat-abi=soft
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
      ${platform_cpu}
      ${platform_common_options}
  )

  target_link_options(
    ${target}

    PRIVATE
      ${platform_cpu}
      ${platform_common_options}

      -nostartfiles
      -specs=nano.specs
      -Xlinker --gc-sections
      -Wl,-Map,${CMAKE_PROJECT_NAME}.map

      # Use absolute paths, otherwise set -L.
      -T${PARENT_DIR}/linker-scripts/mem.ld

      # Including files from other packages is not very nice, but functional.
      -T${PROJECT_SOURCE_DIR}/xpacks/micro-os-plus-architecture-cortexm/linker-scripts/sections.ld
  )
endfunction()

# -----------------------------------------------------------------------------

