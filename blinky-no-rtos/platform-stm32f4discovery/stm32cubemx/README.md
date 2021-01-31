# STM32CubeMX content

Although not critical, for a better error reporting, some small changes
were performed to the `stm32cubemx/Core/Src/main.c` file.

Being braced by the special comments, these changes survive regenerations
with CubeMX.

## Include trace header

```c
/* USER CODE BEGIN Includes */

#include <micro-os-plus/diag/trace.h>

/* USER CODE END Includes */
```

## Implement Error_Handler()

```c
  /* USER CODE BEGIN Error_Handler_Debug */
  /* User can add his own implementation to report the HAL error return state */

  trace_printf("Error_Handler()\r\n");
  while(1) {}

  /* USER CODE END Error_Handler_Debug */
```

## Implement assert_failed()

```
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
     tex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */

    trace_printf("Wrong parameters value: file %s on line %d\r\n", file, line);
    while(1) {}

  /* USER CODE END 6 */
```

