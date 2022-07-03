#include  "stc12.h"
#include "uart_proc.h"

void uart_init(void)
{
    SCON = 0x50;       //REN=1允许串行接受状态，串口工作模式2     	   
    TMOD|= 0x20;      //定时器工作方式2       8位 自动重装载定时器  实现波特率                
    PCON|= 0x00;     //波特率不变                                                    

    TH1 = 0xFd;			//  设置波特率为9600
    TL1 = 0xFd;        //公式 为  TH1=256-(晶振值(11.0592M)/32/12/预设置波特率(9600))
                                //   TH1=256-(11059200/32/12/9600)=256-3=253  0XFD
                            // 如有不明白请查 STC12手册上有详细说明 

    TR1  = 1;        //开启定时器1                                                      
    ES   = 1;        //开串口中断                  
    EA   = 1;        // 开总中断 
}

int putchar (int c) 
{
    while (!TI) /* assumes UART is initialized */
    ;
    TI = 0;
    SBUF = c;
    return c;
}

int uart_txStr(char *s)
{
    int ret = 0;
    char *ps = s;
    unsigned int i = 0;
    while(ps[i] != '\0') {
        ret = putchar(ps[i]);
        i++;
    }

    return ret;
}