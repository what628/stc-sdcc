#ifndef __UART_PROC_H__
#define __UART_PROC_H__

void uart_init(void);
int putchar (int c);
int uart_txStr(char *s);

#endif
