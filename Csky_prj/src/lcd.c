#define LCD_AXIs_VIDEOMEM_ADDR     0 
#define LCD_AXIs_VIDEOMEM_LENGTH   1 

#define LCD_AXIs_LCDINITCMD_ADDR   2 
#define LCD_AXIs_LCDINITCMD_LENGTH 3 

//[0]=0 send data; [0]=1, initial; 
#define LCD_AXIs_LCD_CTRL          4

#define LCD_AXIs_LCD_STATUS        5 

#define INITIAL   0
#define SEND_DATA 1

unsigned int* LCD_AXI_MASTER_BASEADDR = (unsigned int*)0x8200_0000;
unsigned int* LCD_AXI_SLAVE_BASEADDR  = (unsigned int*)0x44A0_0000;


// 64 bytes, 32 bits/per
// 64*8/32 = 16 integers per time
void write_lcd(int ctl, int *wdata, int length, int type){
  switch(type){
    case INITIAL:
      LCD_AXI_SLAVE_BASEADDR[LCD_AXIs_LCD_CTRL] = ctl;
      LCD_AXI_SLAVE_BASEADDR[LCD_AXIs_LCDINITCMD_ADDR] = wdata;
      LCD_AXI_SLAVE_BASEADDR[LCD_AXIs_LCDINITCMD_LENGTH] = length;
      break;
    case SEND_DATA:
      LCD_AXI_SLAVE_BASEADDR[LCD_AXIs_LCD_CTRL] = ctl;
      LCD_AXI_SLAVE_BASEADDR[LCD_AXIs_VIDEOMEM_ADDR] = wdata;
      LCD_AXI_SLAVE_BASEADDR[LCD_AXIs_VIDEOMEM_LENGTH] = length;
      break;
  }
}

int main() {
  // command
  int cmd[] = {
    0xff,0xff,0x98,0x06,
    0x2a,0x00,0x00,0x03,0x20,
    0x2b,0x00,0x00,0x01,0xe0,
    0x2c
  };
  
  // lcd data
  int data[] = {
    0xff00,0xff00,0xff00,0xff00,
    0x0ff0,0x0ff0,0x0ff0,0x0ff0,
    0x00ff,0x00ff,0x00ff,0x00ff,
    0xf00f,0xf00f,0xf00f,0xf00f
  };
  
  // initialize
  write_lcd(0b0110,cmd[0],1,INITIAL);  
  write_lcd(0b0111,cmd[1],3,INITIAL);
  
  // config window's size
  // 800
  write_lcd(0b0110,cmd[4],1,INITIAL);
  write_lcd(0b0111,cmd[5],4,INITIAL);
  // 480
  write_lcd(0b0110,cmd[9], 1,INITIAL);
  write_lcd(0b0111,cmd[10],4,INITIAL);

  // write data
  short i,j;
  // 800*480/16=800*30
  for(i=0;i<30;i++){
    for(j=0;j<800;j++){
      write_lcd(0b0110,cmd[14],1 ,SEND_DATA);
      write_lcd(0b0111,data,   16,SEND_DATA);
    }
  }
  return 0;
}
