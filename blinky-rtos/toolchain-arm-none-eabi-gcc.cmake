set(TOOLCHAIN_BASE_DIR "${CMAKE_CURRENT_LIST_DIR}/xpacks/.bin")

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")

set(CMAKE_C_COMPILER   "${TOOLCHAIN_BASE_DIR}/arm-none-eabi-gcc")
set(CMAKE_CXX_COMPILER "${TOOLCHAIN_BASE_DIR}/arm-none-eabi-g++")
find_program(CMAKE_SIZE NAMES arm-none-eabi-size    HINTS ${TOOLCHAIN_BASE_DIR})
find_program(CMAKE_GDB  NAMES arm-none-eabi-gdb-py3 HINTS ${TOOLCHAIN_BASE_DIR})
