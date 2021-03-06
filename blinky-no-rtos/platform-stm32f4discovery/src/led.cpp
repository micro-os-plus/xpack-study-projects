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

#if defined(__ARM_EABI__)

// ----------------------------------------------------------------------------

#include <micro-os-plus/platform.h>
#include "led.h"

// ----------------------------------------------------------------------------

#define BLINK_GPIOx(_N) \
  (reinterpret_cast<GPIO_TypeDef*>(GPIOA_BASE + (GPIOB_BASE - GPIOA_BASE) * (_N)))
#define BLINK_PIN_MASK(_N) (1 << (_N))
#define BLINK_RCC_MASKx(_N) (RCC_AHB1ENR_GPIOAEN << (_N))

// ----------------------------------------------------------------------------

#pragma GCC diagnostic push

#pragma GCC diagnostic ignored "-Wold-style-cast"

led::led (unsigned int port, unsigned int bit, bool active_low)
{
  port_number_ = static_cast<uint16_t>(port);
  bit_number_ = static_cast<uint16_t>(bit);
  bit_mask_ = static_cast<uint16_t>(BLINK_PIN_MASK (bit));
  is_active_low_ = active_low;

  gpio_ptr_ = BLINK_GPIOx (port_number_);
}

void
led::power_up ()
{
  // Explicit bitwise or, to avoid C++20 
  // compound assignment with 'volatile'-qualified left operand is deprecated [-Werror=volatile]
  RCC->AHB1ENR = RCC->AHB1ENR | BLINK_RCC_MASKx (port_number_);

  GPIO_InitTypeDef GPIO_InitStruct;
  GPIO_InitStruct.Pin = bit_mask_;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Speed = GPIO_SPEED_FAST;
  GPIO_InitStruct.Pull = GPIO_PULLUP;

  HAL_GPIO_Init (BLINK_GPIOx (port_number_), &GPIO_InitStruct);

  // Start with led turned off
  turn_off ();
}

#pragma GCC diagnostic pop

// GPIO_PIN_RESET, GPIO_PIN_SET

void
led::turn_on ()
{
  HAL_GPIO_WritePin (gpio_ptr_, bit_mask_,
                     is_active_low_ ? GPIO_PIN_RESET : GPIO_PIN_SET);
}

void
led::turn_off ()
{
  HAL_GPIO_WritePin (gpio_ptr_, bit_mask_,
                     is_active_low_ ? GPIO_PIN_SET : GPIO_PIN_RESET);
}

void
led::toggle ()
{
  HAL_GPIO_TogglePin (gpio_ptr_, bit_mask_);
}

bool
led::is_on ()
{
  GPIO_PinState state = HAL_GPIO_ReadPin (gpio_ptr_, bit_mask_);
  if (is_active_low_)
    {
      return state == GPIO_PIN_RESET;
    }
  else
    {
      return state == GPIO_PIN_SET;
    }
}

// ----------------------------------------------------------------------------

#endif /* defined(__ARM_EABI__) */

// ----------------------------------------------------------------------------
