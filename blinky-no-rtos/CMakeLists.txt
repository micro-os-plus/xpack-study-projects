cmake_minimum_required(VERSION 3.18)

project(blinky-no-rtos)

add_executable(firmware)

set_target_properties(
  firmware
  PROPERTIES
    SUFFIX ".elf"
)

target_compile_options(
  firmware
  PRIVATE
    -Wunused
    -Wuninitialized
    -Wall
    -Wextra
    -Wconversion
    -Wpointer-arith
    -Wshadow
    -Wlogical-op
    -Wfloat-equal

    $<$<COMPILE_LANGUAGE:CXX>:-Wctor-dtor-privacy>
    $<$<COMPILE_LANGUAGE:CXX>:-Wnoexcept>
    $<$<COMPILE_LANGUAGE:CXX>:-Wnon-virtual-dtor>
    $<$<COMPILE_LANGUAGE:CXX>:-Wstrict-null-sentinel>
    $<$<COMPILE_LANGUAGE:CXX>:-Wsign-promo>
)

target_compile_options(
  firmware
  PRIVATE
    -g3
    -O0
    -fmessage-length=0
    -fsigned-char
    -ffunction-sections
    -fdata-sections
    -fno-move-loop-invariants

    $<$<COMPILE_LANGUAGE:CXX>:-std=gnu++11>
    $<$<COMPILE_LANGUAGE:CXX>:-fabi-version=0>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-use-cxa-atexit>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>
)

target_compile_definitions(
  firmware
  PRIVATE
    DEBUG
    TRACE
    STM32F407xx
    USE_HAL_DRIVER
    PLATFORM_STM32F4DISCOVERY
    STM32F4
    OS_USE_TRACE_SEMIHOSTING_DEBUG
    OS_USE_SEMIHOSTING_SYSCALLS
)

target_compile_options(
  firmware
  PRIVATE
    -mcpu=cortex-m4
    -mthumb
    -mfloat-abi=soft
)

target_link_options(
  firmware
  PRIVATE
    -mcpu=cortex-m4
    -mthumb
    -mfloat-abi=soft
)

target_link_options(
  firmware
  PRIVATE
    -nostartfiles
    -specs=nano.specs
    -Xlinker --gc-sections
    -Wl,-Map,"blinky-no-rtos.map"
)

target_link_directories(
  firmware
  PRIVATE
    .
)

target_link_options(
  firmware
  PRIVATE
    -Tplatform-stm32f4discovery/linker-scripts/mem.ld
    -Txpacks/micro-os-plus-architecture-cortexm/linker-scripts/sections.ld
)

target_sources(
  firmware
  PRIVATE
    src/main.cpp
    src/_write.c
    src/sysclock.cpp

    platform-stm32f4discovery/src/initialize-hardware.cpp
    platform-stm32f4discovery/src/interrupts-handlers.cpp
    platform-stm32f4discovery/src/led.cpp

    xpacks/micro-os-plus-architecture-cortexm/src/exception-handlers.cpp
    #xpacks/micro-os-plus-architecture-cortexm/src/rtos/port/os-core.cpp
    #xpacks/micro-os-plus-architecture-cortexm/src/diag/trace-itm.cpp
    #xpacks/micro-os-plus-architecture-cortexm/src/diag/trace-segger-rtt.cpp
    #xpacks/micro-os-plus-architecture-cortexm/src/terminate.cpp
    xpacks/micro-os-plus-architecture-cortexm/src/startup/initialize-hardware-early.c
    xpacks/micro-os-plus-architecture-cortexm/src/startup/initialize-hardware.c

    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim_ex.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ramfunc.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma_ex.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_pwr_ex.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_flash_ex.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc_ex.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_gpio.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_cortex.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_tim.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_rcc.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_dma.c
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Src/stm32f4xx_hal_exti.c

    platform-stm32f4discovery/stm32cubemx/Core/Src/main.c

    platform-stm32f4discovery/stm32cubemx/Core/Src/gpio.c
    platform-stm32f4discovery/stm32cubemx/Core/Src/stm32f4xx_it.c
    platform-stm32f4discovery/stm32cubemx/Core/Src/stm32f4xx_hal_msp.c
    platform-stm32f4discovery/stm32cubemx/Core/Src/main.c
    platform-stm32f4discovery/stm32cubemx/Core/Src/system_stm32f4xx.c

    xpacks/micro-os-plus-diag-trace/src/trace.cpp

    xpacks/micro-os-plus-devices-stm32f4/src/vectors/vectors_stm32f407xx.c

    xpacks/micro-os-plus-startup/src/startup.cpp

    xpacks/micro-os-plus-semihosting/src/syscalls-semihosting.cpp
    xpacks/micro-os-plus-semihosting/src/trace-semihosting.cpp

    xpacks/micro-os-plus-libs-c/src/c-syscalls-empty.cpp
    xpacks/micro-os-plus-libs-c/src/_sbrk.c
    xpacks/micro-os-plus-libs-c/src/stdlib/init-fini.c
    xpacks/micro-os-plus-libs-c/src/stdlib/assert.c
    xpacks/micro-os-plus-libs-c/src/stdlib/atexit.cpp
    xpacks/micro-os-plus-libs-c/src/stdlib/timegm.c
    xpacks/micro-os-plus-libs-c/src/stdlib/exit.c
)

target_include_directories(
  firmware
  PRIVATE
    include

    platform-stm32f4discovery/include
    platform-stm32f4discovery/stm32cubemx/Drivers/CMSIS/Device/ST/STM32F4xx/Include
    platform-stm32f0discovery/stm32cubemx/Drivers/CMSIS/Include
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Inc
    platform-stm32f4discovery/stm32cubemx/Core/Inc

    ../xpacks/devices-stm32f4-xpack.git/include
    ../xpacks/architecture-cortexm-xpack.git/include/
    ../xpacks/version-xpack.git/include/
    xpacks/micro-os-plus-diag-trace/include
    xpacks/micro-os-plus-devices-stm32f4/include
    xpacks/micro-os-plus-startup/include
    xpacks/micro-os-plus-semihosting/include
    xpacks/micro-os-plus-libs-c/include
)
