#
# This file is part of the µOS++ project (https://github.com/micro-os-plus)
# and is distributed under the terms of the MIT license.
# Copyright (c) 2021 Liviu Ionescu
#
# -----------------------------------------------------------------------------

message(STATUS "Including platform-stm32f4discovery...")

set(XPACK_PLATFORM_NAME "PLATFORM_STM32F4DISCOVERY")
set(XPACK_DEVICE_NAME "STM32F407xx")
set(XPACK_DEVICE_FAMILY_NAME "STM32F4")

target_sources(
  xpack-target
  PRIVATE

    platform-stm32f4discovery/src/initialize-hardware.cpp
    platform-stm32f4discovery/src/interrupts-handlers.cpp
    platform-stm32f4discovery/src/led.cpp
    
    platform-stm32f4discovery/stm32cubemx/Core/Src/gpio.c
    platform-stm32f4discovery/stm32cubemx/Core/Src/main.c
    platform-stm32f4discovery/stm32cubemx/Core/Src/stm32f4xx_hal_msp.c
    platform-stm32f4discovery/stm32cubemx/Core/Src/stm32f4xx_it.c
    platform-stm32f4discovery/stm32cubemx/Core/Src/system_stm32f4xx.c

    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma_ex.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_exti.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ex.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ramfunc.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr_ex.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc_ex.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim_ex.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c
)

target_include_directories(
  xpack-target
  PRIVATE
  
    platform-stm32f4discovery/include
    platform-stm32f4discovery/stm32cubemx/Core/Inc
    platform-stm32f4discovery/stm32cubemx/Drivers/CMSIS/Device/ST/STM32F4xx/Include
    platform-stm32f4discovery/stm32cubemx/Drivers/CMSIS/Include
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Inc
    
    xpacks/micro-os-plus-devices-stm32f4/include
)

target_compile_definitions(
  xpack-target
  PRIVATE
  
    ${XPACK_PLATFORM_NAME}
    STM32F407xx
    STM32F4
    
    USE_HAL_DRIVER
    OS_USE_SEMIHOSTING_SYSCALLS
)

if (CMAKE_BUILD_TYPE STREQUAL "Debug")
target_compile_definitions(
  xpack-target
  PRIVATE
  
    OS_USE_TRACE_SEMIHOSTING_DEBUG
)
endif()

set(platform_cpu 

  -mcpu=cortex-m4
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
  xpack-target
  PRIVATE
  
    ${platform_cpu}
    ${platform_common_options}
)

target_link_options(
  xpack-target
  PRIVATE
  
    ${platform_cpu}
    ${platform_common_options}

    -nostartfiles
    -specs=nano.specs
    -Xlinker --gc-sections
    -Wl,-Map,${CMAKE_PROJECT_NAME}.map

    # Use absolute paths, otherwise set -L.
    -T${PROJECT_SOURCE_DIR}/platform-stm32f4discovery/linker-scripts/mem.ld
    -T${PROJECT_SOURCE_DIR}/xpacks/micro-os-plus-architecture-cortexm/linker-scripts/sections.ld
)

# -----------------------------------------------------------------------------

