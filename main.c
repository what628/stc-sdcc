#include "stc12.h"
#include "led.h"
#include "uart_proc.h"

void delayms(int count)  // /* X1ms */
{
    int i,j;
    for(i=0;i<count;i++){
        for(j=0;j<1000;j++);
    }
}


char __code  MESSAGE[]= "sdcc print...\r\n";
void ISP_Check(unsigned char tmp)
{
    unsigned char a;
    if(tmp==0x12) 
    {

        ES= 0;
        a=0;
        while(MESSAGE[a]!= '\0')
        {
            SBUF = MESSAGE[a];	        //SUBF接受/发送缓冲器(又叫串行通信特殊功能寄存器)
            while(!TI);                 // 等特数据传送	(TI发送中断标志)
            TI = 0;                     // 清除数据传送标志

            a++;                        // 下一个字符
        } 

        ES= 1;
    }
}

void Serial_int(void)  __interrupt 4 __using 1
{
    unsigned char tmp;

    if (RI) 
    {
        tmp = SBUF;
        ISP_Check(tmp); 

        RI = 0;
    }
}

main()
{
    unsigned char led_on = 1;
    led_init();
    uart_init();

    while(1)
    {
        led_OnOff((led_on = !led_on));
        delayms(LED_BLINK_DELAY);
    }
}
