/*
 * This file is part of the µOS++ distribution.
 *   (https://github.com/micro-os-plus)
 * Copyright (c) 2020 Liviu Ionescu.
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

#ifndef MICRO_OS_PLUS_PLATFORM_STM32F4DISCOVERY_DEFINES_H_
#define MICRO_OS_PLUS_PLATFORM_STM32F4DISCOVERY_DEFINES_H_

// ----------------------------------------------------------------------------

// ----- LED definitions ------------------------------------------------------

// On the STM32F0-Discovery board, the coloured LEDs are
// connected to PC8-PC9, active high.
#define BLINK_PORT_NUMBER (2)
#define BLINK_PIN_NUMBER_GREEN (9)
#define BLINK_PIN_NUMBER_BLUE (8)

// ----------------------------------------------------------------------------

#endif /* MICRO_OS_PLUS_PLATFORM_STM32F4DISCOVERY_DEFINES_H_ */

// ----------------------------------------------------------------------------
