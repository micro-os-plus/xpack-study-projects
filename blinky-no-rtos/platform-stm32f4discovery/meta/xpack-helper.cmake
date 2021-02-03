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

message(STATUS "Including platform-stm32f4discovery...")

# Preprocessor symbols.
set(xpack_platform_compile_definition "PLATFORM_STM32F4DISCOVERY")
set(xpack_device_compile_definition "STM32F407xx")
set(xpack_device_family_compile_definition "STM32F4")

function(target_sources_micro_os_plus_platform target)

  get_filename_component(xpack_root_folder ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  target_sources(
    ${target}

    PRIVATE
      ${xpack_root_folder}/src/initialize-hardware.cpp
      ${xpack_root_folder}/src/interrupts-handlers.cpp
      ${xpack_root_folder}/src/led.cpp
      
      ${xpack_root_folder}/stm32cubemx/Core/Src/gpio.c
      ${xpack_root_folder}/stm32cubemx/Core/Src/main.c
      ${xpack_root_folder}/stm32cubemx/Core/Src/stm32f4xx_hal_msp.c
      ${xpack_root_folder}/stm32cubemx/Core/Src/stm32f4xx_it.c
      ${xpack_root_folder}/stm32cubemx/Core/Src/system_stm32f4xx.c

      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma_ex.c
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma.c
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_exti.c
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ex.c
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ramfunc.c
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash.c
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr_ex.c
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr.c
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc_ex.c
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim_ex.c
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim.c
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c
  )

endfunction()

function(target_include_directories_micro_os_plus_platform target)

  get_filename_component(xpack_root_folder ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  target_include_directories(
    ${target}

    PRIVATE
      ${xpack_root_folder}/include
      ${xpack_root_folder}/stm32cubemx/Core/Inc
      ${xpack_root_folder}/stm32cubemx/Drivers/CMSIS/Device/ST/STM32F4xx/Include
      ${xpack_root_folder}/stm32cubemx/Drivers/CMSIS/Include
      ${xpack_root_folder}/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Inc
  )

endfunction()

function(target_compile_definitions_micro_os_plus_platform target)

  get_filename_component(xpack_root_folder ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  target_compile_definitions(
    ${target}

    PRIVATE
      ${xpack_platform_compile_definition}
      ${xpack_device_compile_definition}
      ${xpack_device_family_compile_definition}
      
      USE_HAL_DRIVER
      OS_USE_SEMIHOSTING_SYSCALLS

      $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:OS_USE_TRACE_SEMIHOSTING_DEBUG>
  )

endfunction()

function(target_options_micro_os_plus_platform target)

  get_filename_component(xpack_root_folder ${CMAKE_CURRENT_FUNCTION_LIST_DIR} DIRECTORY)

  set(platform_cpu_option 

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

      -nostartfiles
      -specs=nano.specs
      -Xlinker --gc-sections
      -Wl,-Map,${CMAKE_PROJECT_NAME}.map

      # Use absolute paths, otherwise set -L.
      -T${xpack_root_folder}/linker-scripts/mem.ld

      # Including files from other packages is not very nice, but functional.
      -T${PROJECT_SOURCE_DIR}/xpacks/micro-os-plus-architecture-cortexm/linker-scripts/sections.ld
  )

endfunction()

# -----------------------------------------------------------------------------
# Forward device to devices-stm32f4.

function(target_sources_micro_os_plus_device target)

  target_sources_micro_os_plus_devices_stm32f4(${target})

endfunction()


function(target_include_directories_micro_os_plus_device target)

  target_include_directories_micro_os_plus_devices_stm32f4(${target})

endfunction()

# -----------------------------------------------------------------------------
# Forward architecture to architecture-cortexm.

function(target_sources_micro_os_plus_architecture target)

  target_sources_micro_os_plus_architecture_cortexm(${target})

endfunction()


function(target_include_directories_micro_os_plus_architecture target)

  target_include_directories_micro_os_plus_architecture_cortexm(${target})

endfunction()


function(target_compile_definitions_micro_os_plus_architecture target)

  target_compile_definitions_micro_os_plus_architecture_cortexm(${target})

endfunction()

# -----------------------------------------------------------------------------

