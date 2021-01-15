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

#if defined(__APPLE__) || defined(__linux__) || defined(__unix__)

// ----------------------------------------------------------------------------

#include "led.h"
#include <micro-os-plus/platform.h>

#include <stdio.h>

// ----------------------------------------------------------------------------

#define BLINK_GPIOx(_N) \
  ((GPIO_TypeDef*)(GPIOA_BASE + (GPIOB_BASE - GPIOA_BASE) * (_N)))
#define BLINK_PIN_MASK(_N) (1 << (_N))
#define BLINK_RCC_MASKx(_N) (RCC_AHB1ENR_GPIOAEN << (_N))

// ----------------------------------------------------------------------------

led::led (const char* colour)
{
  colour_ = colour;
  is_on_ = false;
}

void
led::power_up ()
{
  is_on_ = false;
  // Start with led turned off
  turn_off ();
}

void
led::turn_on ()
{
  is_on_ = true;
  printf ("[led:%s on]\n", colour_);
}

void
led::turn_off ()
{
  is_on_ = false;
  printf ("[led:%s off]\n", colour_);
}

void
led::toggle ()
{
  is_on_ = !is_on_;
  printf ("[led:%s %s]\n", colour_, is_on_ ? "on" : "off");
}

bool
led::is_on ()
{
  return is_on_;
}

// ----------------------------------------------------------------------------

#endif // Unix

// ----------------------------------------------------------------------------
