#define __xscen_storage_region_add(base, limit)\
  do{\
    asm("sradd %0,%1" :: "r"(base), "r"(limit));\
  }while(0)

/* example:
 * #include "xscen.h"
 * #include "pulpino.h"
 *
 * __xscen_storage_region_add(UART_BASE_ADDR, UART_BASE_ADDR+0x1000);
*/
