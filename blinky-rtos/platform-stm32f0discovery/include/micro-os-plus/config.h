/*
 * This file is part of the µOS++ distribution.
 *   (https://github.com/micro-os-plus)
 * Copyright (c) 2016 Liviu Ionescu.
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom
 * the Software is furnished to do so, subject to the following
 * conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */

#ifndef MICRO_OS_PLUS_CONFIG_H_
#define MICRO_OS_PLUS_CONFIG_H_

// ----------------------------------------------------------------------------

#define MICRO_OS_PLUS_INCLUDE_RTOS

#define MICRO_OS_PLUS_INTEGER_SYSTICK_FREQUENCY_HZ (1000)

// With 4 bits NVIC, there are 16 levels, 0 = highest, 15 = lowest

// #define MICRO_OS_PLUS_INTEGER_RTOS_MAIN_STACK_SIZE_BYTES               (30000)

#define MICRO_OS_PLUS_INTEGER_RTOS_IDLE_STACK_SIZE_BYTES (1600)
#define MICRO_OS_PLUS_INTEGER_RTOS_DEFAULT_STACK_SIZE_BYTES (1600)

//#define MICRO_OS_PLUS_BOOL_RTOS_PORT_CONTEXT_CREATE_ZERO_LR

#if defined(MICRO_OS_PLUS_USE_TRACE_SEGGER_RTT)
#define MICRO_OS_PLUS_EXCLUDE_RTOS_IDLE_SLEEP (1)
#endif

#define MICRO_OS_PLUS_INCLUDE_RTOS_STATISTICS_THREAD_CONTEXT_SWITCHES (1)
#define MICRO_OS_PLUS_INCLUDE_RTOS_STATISTICS_THREAD_CPU_CYCLES (1)

//#define MICRO_OS_PLUS_INCLUDE_ATEXIT_STATIC

// ----------------------------------------------------------------------------

#if 1

#define MICRO_OS_PLUS_TRACE_POSIX_IO_DEVICE
#define MICRO_OS_PLUS_TRACE_POSIX_IO_CHAR_DEVICE
#define MICRO_OS_PLUS_TRACE_POSIX_IO_BLOCK_DEVICE
#define MICRO_OS_PLUS_TRACE_POSIX_IO_BLOCK_DEVICE_PARTITION
#define MICRO_OS_PLUS_TRACE_POSIX_IO_DIRECTORY
#define MICRO_OS_PLUS_TRACE_POSIX_IO_FILE
#define MICRO_OS_PLUS_TRACE_POSIX_IO_FILE_DESCRIPTORS_MANAGER
#define MICRO_OS_PLUS_TRACE_POSIX_IO_FILE_SYSTEM
#define MICRO_OS_PLUS_TRACE_POSIX_IO_IO
#define MICRO_OS_PLUS_TRACE_POSIX_IO_NET_INTERFACE
#define MICRO_OS_PLUS_TRACE_POSIX_IO_NET_STACK
#define MICRO_OS_PLUS_TRACE_POSIX_IO_SOCKET
#define MICRO_OS_PLUS_TRACE_POSIX_IO_TTY
#define MICRO_OS_PLUS_TRACE_POSIX_IO_CHAN_FATFS

#define MICRO_OS_PLUS_TRACE_UTILS_LISTS

// Available trace options.
#define MICRO_OS_PLUS_TRACE_RTOS_CLOCKS
#define MICRO_OS_PLUS_TRACE_RTOS_LISTS_CLOCKS
#define MICRO_OS_PLUS_TRACE_RTOS_CONDVAR
#define MICRO_OS_PLUS_TRACE_RTOS_EVFLAGS
#define MICRO_OS_PLUS_TRACE_RTOS_MEMPOOL
#define MICRO_OS_PLUS_TRACE_RTOS_MQUEUE
#define MICRO_OS_PLUS_TRACE_RTOS_MUTEX
#define MICRO_OS_PLUS_TRACE_RTOS_RTC_TICK
//#define MICRO_OS_PLUS_TRACE_RTOS_SCHEDULER
#define MICRO_OS_PLUS_TRACE_RTOS_SEMAPHORE
//#define MICRO_OS_PLUS_TRACE_RTOS_SYSCLOCK_TICK
#define MICRO_OS_PLUS_TRACE_RTOS_THREAD
//#define MICRO_OS_PLUS_TRACE_RTOS_THREAD_CONTEXT
#define MICRO_OS_PLUS_TRACE_RTOS_THREAD_FLAGS
#define MICRO_OS_PLUS_TRACE_RTOS_TIMER

// #define MICRO_OS_PLUS_TRACE_RTOS_LISTS

#define MICRO_OS_PLUS_TRACE_LIBC_MALLOC
#define MICRO_OS_PLUS_TRACE_LIBC_ATEXIT

#define MICRO_OS_PLUS_TRACE_LIBCPP_MEMORY_RESOURCE
#define MICRO_OS_PLUS_TRACE_LIBCPP_OPERATOR_NEW

#endif

// #define MICRO_OS_PLUS_INCLUDE_RTOS_DRTM

// ----------------------------------------------------------------------------

#endif /* MICRO_OS_PLUS_CONFIG_H_ */

// ----------------------------------------------------------------------------
