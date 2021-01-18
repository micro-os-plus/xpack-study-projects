cmake_minimum_required(VERSION 3.18)

project(
	blinky-rtos
	VERSION 1.2.3
	DESCRIPTION "A blinky using the µOS++ RTOS"
	LANGUAGES C CXX
)

add_executable(xpack-target)

set_target_properties(
  xpack-target
  PROPERTIES
    SUFFIX ".elf"
    OUTPUT_NAME "blinky-rtos"
)

# -----------------------------------------------------------------------------

target_sources(
  xpack-target
  PRIVATE

    src/main.cpp
    src/_write.c

    platform-stm32f4discovery/src/initialize-hardware.cpp
    platform-stm32f4discovery/src/interrupts-handlers.cpp
    platform-stm32f4discovery/src/led.cpp

    platform-stm32f4discovery/stm32cubemx/Core/Src/main.c
    platform-stm32f4discovery/stm32cubemx/Core/Src/gpio.c
    platform-stm32f4discovery/stm32cubemx/Core/Src/stm32f4xx_it.c
    platform-stm32f4discovery/stm32cubemx/Core/Src/stm32f4xx_hal_msp.c
    platform-stm32f4discovery/stm32cubemx/Core/Src/main.c
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

    xpacks/micro-os-plus-architecture-cortexm/src/diag/trace-itm.cpp
    xpacks/micro-os-plus-architecture-cortexm/src/diag/trace-segger-rtt.cpp
    xpacks/micro-os-plus-architecture-cortexm/src/rtos/port/os-core.cpp
    xpacks/micro-os-plus-architecture-cortexm/src/startup/initialize-hardware-early.c
    xpacks/micro-os-plus-architecture-cortexm/src/startup/initialize-hardware.c
    xpacks/micro-os-plus-architecture-cortexm/src/exception-handlers.cpp
    xpacks/micro-os-plus-architecture-cortexm/src/terminate.cpp

    xpacks/micro-os-plus-cmsis-os/src/cmsis-os-c-wrapper.cpp
    
    xpacks/micro-os-plus-devices-stm32f4/src/vectors/vectors_stm32f407xx.c

    xpacks/micro-os-plus-diag-trace/src/trace.cpp

    xpacks/micro-os-plus-libs-c/src/stdlib/init-fini.c
    xpacks/micro-os-plus-libs-c/src/stdlib/assert.c
    xpacks/micro-os-plus-libs-c/src/stdlib/atexit.cpp
    xpacks/micro-os-plus-libs-c/src/stdlib/timegm.c
    xpacks/micro-os-plus-libs-c/src/stdlib/exit.c
    xpacks/micro-os-plus-libs-c/src/_sbrk.c
    xpacks/micro-os-plus-libs-c/src/c-syscalls-empty.cpp

    xpacks/micro-os-plus-libs-cpp-estd/src/chrono.cpp
    xpacks/micro-os-plus-libs-cpp-estd/src/condition-variable.cpp
    xpacks/micro-os-plus-libs-cpp-estd/src/memory-resource.cpp
    xpacks/micro-os-plus-libs-cpp-estd/src/mutex.cpp
    xpacks/micro-os-plus-libs-cpp-estd/src/new.cpp
    xpacks/micro-os-plus-libs-cpp-estd/src/thread.cpp
    
    xpacks/micro-os-plus-libs-cpp/src/cxx.cpp
    xpacks/micro-os-plus-libs-cpp/src/system-error.cpp

    xpacks/micro-os-plus-memory-allocators/src/block-pool.cpp
    xpacks/micro-os-plus-memory-allocators/src/first-fit-top.cpp
    xpacks/micro-os-plus-memory-allocators/src/lifo.cpp

    xpacks/micro-os-plus-posix-io/src/newlib/c-newlib-reent.cpp
    xpacks/micro-os-plus-posix-io/src/block-device.cpp
    xpacks/micro-os-plus-posix-io/src/block-device-partition.cpp
    xpacks/micro-os-plus-posix-io/src/char-device.cpp
    xpacks/micro-os-plus-posix-io/src/c-syscalls-posix.cpp
    xpacks/micro-os-plus-posix-io/src/device.cpp
    xpacks/micro-os-plus-posix-io/src/directory.cpp
    xpacks/micro-os-plus-posix-io/src/file.cpp
    xpacks/micro-os-plus-posix-io/src/file-descriptors-manager.cpp
    xpacks/micro-os-plus-posix-io/src/file-system.cpp
    xpacks/micro-os-plus-posix-io/src/io.cpp
    xpacks/micro-os-plus-posix-io/src/net-stack.cpp
    xpacks/micro-os-plus-posix-io/src/socket.cpp
    xpacks/micro-os-plus-posix-io/src/tty.cpp

    xpacks/micro-os-plus-rtos/src/libc/stdlib/malloc.cpp
    xpacks/micro-os-plus-rtos/src/rtos/internal/os-flags.cpp
    xpacks/micro-os-plus-rtos/src/rtos/internal/os-lists.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-clocks.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-condvar.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-core.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-c-wrapper.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-evflags.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-idle.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-main.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-memory.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-mempool.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-mqueue.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-mutex.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-semaphore.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-terminate.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-thread.cpp
    xpacks/micro-os-plus-rtos/src/rtos/os-timer.cpp
    xpacks/micro-os-plus-rtos/src/startup/initialise-free-store.cpp
    xpacks/micro-os-plus-rtos/src/startup/initialise-interrupts-stack.cpp

    xpacks/micro-os-plus-semihosting/src/syscalls-semihosting.cpp
    xpacks/micro-os-plus-semihosting/src/trace-semihosting.cpp

    xpacks/micro-os-plus-startup/src/startup.cpp

    xpacks/micro-os-plus-utils-lists/src/lists.cpp
)

# -----------------------------------------------------------------------------

target_include_directories(
  xpack-target
  PRIVATE
  
    include

    platform-stm32f4discovery/include
    platform-stm32f4discovery/stm32cubemx/Core/Inc
    platform-stm32f0discovery/stm32cubemx/Drivers/CMSIS/Include
    platform-stm32f4discovery/stm32cubemx/Drivers/CMSIS/Device/ST/STM32F4xx/Include
    platform-stm32f4discovery/stm32cubemx/Drivers/STM32F4xx_HAL_Driver/Inc

    xpacks/micro-os-plus-architecture-cortexm/include

    xpacks/micro-os-plus-cmsis-os/include

    xpacks/micro-os-plus-devices-stm32f4/include

    xpacks/micro-os-plus-diag-trace/include

    xpacks/micro-os-plus-libs-c/include

    xpacks/micro-os-plus-libs-cpp/include

    xpacks/micro-os-plus-libs-cpp-estd/include

    xpacks/micro-os-plus-memory-allocators/include

    xpacks/micro-os-plus-posix-io/include

    xpacks/micro-os-plus-rtos/include

    xpacks/micro-os-plus-semihosting/include

    xpacks/micro-os-plus-startup/include

    xpacks/micro-os-plus-utils-lists/include

    xpacks/micro-os-plus-version/include/

)

# -----------------------------------------------------------------------------

target_compile_options(
  xpack-target
  PRIVATE
  
    -mcpu=cortex-m4
    -mthumb
    -mfloat-abi=soft
)

target_compile_options(
  xpack-target
  PRIVATE
  
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
  
    -g3
    -O0
    
    -fmessage-length=0
    -fsigned-char
    -ffunction-sections
    -fdata-sections
    -fno-move-loop-invariants

    $<$<COMPILE_LANGUAGE:C>:-std=c11>
    $<$<COMPILE_LANGUAGE:CXX>:-std=c++17>
    
    $<$<COMPILE_LANGUAGE:CXX>:-fabi-version=0>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-exceptions>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-rtti>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-use-cxa-atexit>
    $<$<COMPILE_LANGUAGE:CXX>:-fno-threadsafe-statics>
)

target_compile_definitions(
  xpack-target
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

# -----------------------------------------------------------------------------

target_link_options(
  xpack-target
  PRIVATE
  
    -mcpu=cortex-m4
    -mthumb
    -mfloat-abi=soft
)

target_link_options(
  xpack-target
  PRIVATE
  
    -nostartfiles
    -specs=nano.specs
    -Xlinker --gc-sections
    -Wl,-Map,blinky-no-rtos.map
)

target_link_directories(
  xpack-target
  PRIVATE
  
    .
)

target_link_options(
  xpack-target
  PRIVATE
  
    -Tplatform-stm32f4discovery/linker-scripts/mem.ld
    -Txpacks/micro-os-plus-architecture-cortexm/linker-scripts/sections.ld
)

# -----------------------------------------------------------------------------

