#include  "stc12.h"
#include "led.h"

#ifndef LED_RED
#define LED_RED             (P4_6)
#define IO_SW               (P4SW)
#define LED_IO_SW           (0x70)
#endif

void led_init(void)
{
    IO_SW = LED_IO_SW;
}

unsigned char led_OnOff(unsigned char on)
{

    LED_RED = on? 1 : 0;

    return LED_RED;
}