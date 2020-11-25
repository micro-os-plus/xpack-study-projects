/*
 * Memory Spaces Definitions for the STM32F4DISCOVERY board.
 *
 *   FLASH.ORIGIN: starting address of flash
 *   FLASH.LENGTH: length of flash
 *   RAM.ORIGIN: starting address of RAM bank 0
 *   RAM.LENGTH: length of RAM bank 0
 *
 * The values below can be addressed in further linker scripts
 * using functions like 'ORIGIN(RAM)' or 'LENGTH(RAM)'.
 */

MEMORY
{
  FLASH (rx) : ORIGIN = 0x08000000, LENGTH = 1024K
  RAM (xrw) : ORIGIN = 0x20000000, LENGTH = 128K

  /*
   * Device specific sections; define the origin and length to match
   * the the specific requirements of your hardware. The zero
   * length prevents inadvertent allocation.
   */
  CCMRAM (xrw) : ORIGIN = 0x10000000, LENGTH = 64K
  MEMORY_ARRAY (xrw) : ORIGIN = 0x20020000, LENGTH = 32
}

