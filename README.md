# stc-sdcc
A demo of the stc mcu that used the complier of sdcc.

编译命令：
    make all
    make allclean
    make TARGET=led_blink LED_BLINK_DELAY=1000 all

新建源代码目录方法：
    1、新建目录--如，newDir/；
    2、复制原先src/目录下的makefile文件，到newDir/；
    3、如果在newDir/下存在子目录subDir/，再复制原先src/目录下的makefile文件，到subDir/即可；以此类推。

遗留项：
    1、未删除编译生成的中间件。如，*.asm，*.lst，*.rel，*.rst和*.sym

优势：
    1、不像常规方法，只在顶层Makefile添加编译所需的依赖文件，摆脱工程越大，顶层Makefile越臃肿的现象；
    2、统一了新建源代码目录时所需的makefile文件。开发者只需关系源代码的编写。
