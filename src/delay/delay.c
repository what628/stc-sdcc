void delayms(int count)  // /* X1ms */
{
    int i,j;
    for(i=0;i<count;i++){
        for(j=0;j<1000;j++);
    }
}
