#define CPU_CLK 100000000
unsigned int *UART_BASE_ADDR=(unsigned int *)0x44A00000;

#define RX_FIFO  0
#define TX_FIFO  1
#define STAT_REG 2
#define CTRL_REG 3

void set_rate(int rate)
{
  unsigned int div = CPU_CLK / 2 / rate;
  UART_BASE_ADDR[CTRL_REG]=div;
}

void print_uart(char *s)
{
  while((*s) != '\0'){
    UART_BASE_ADDR[TX_FIFO]=(*s);
    s++;
  }
}

void scanf_uart(char *s)
{
  int i=0,j;
  while(UART_BASE_ADDR[STAT_REG] == 1)
    {
      for(j=0;j<1000;j++);
      s[i]=UART_BASE_ADDR[RX_FIFO]&0xff;
      for(j=0;j<1000;j++);
      i++;
    }
}

int main() {

  set_rate(9600);
  char s[200];
  while(1)
    {
      int i=0;
      for(i=0;i<200;i++)
        s[i]=0;
      
      while(UART_BASE_ADDR[STAT_REG] == 0)
      {
        int j;
        for(j=0;j<1000;j++);
      }
      
      scanf_uart(s);
      print_uart(s);
    }
  return 0;
}
