#include "xil_assert.h"
#include "xil_types.h"
#include "xil_printf.h"

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
    // 1 + 133
    0xff, 0xff, 0x98, 0x6,  0xba, 0xe0, 0xbc, 0x3,  
    0xf,  0x63, 0x69, 0x1,  0x1,  0x1b, 0x11, 0x70, 
    0x73, 0xff, 0xff, 0x8,  0x9,  0x5,  0x0,  0xee, 
    0xe2, 0x1,  0x0,  0xc1, 0xbd, 0x1,  0x23, 0x45, 
    0x67, 0x1,  0x23, 0x45, 0x67, 0xbe, 0x0,  0x22, 
    0x27, 0x6a, 0xbc, 0xd8, 0x92, 0x22, 0x22, 0xc7, 
    0x1e, 0xed, 0x7f, 0xf,  0x0,  0xc0, 0xe3, 0xb,  
    0x0,  0xfc, 0x8,  0xdf, 0x0,  0x0,  0x0,  0x0,  
    0x0,  0x2,  0xf3, 0x74, 0xb4, 0x0,  0x0,  0x0,  
    0xf7, 0x81, 0xb1, 0x0,  0x10, 0x14, 0xf1, 0x29, 
    0x8a, 0x7,  0xf2, 0x40, 0xd2, 0x50, 0x28, 0xc1, 
    0x17, 0x85, 0x85, 0x20, 0xe0, 0x0,  0xc,  0x15, 
    0xd,  0xf,  0xc,  0x7,  0x5,  0x7,  0xb,  0x10, 
    0x10, 0xd,  0x17, 0xf,  0x0,  0xe1, 0x0,  0xd,  
    0x15, 0xe,  0x10, 0xd,  0x8,  0x6,  0x7,  0xc,  
    0x11, 0x11, 0xe, 0x17,  0xf,  0x0,  0x35, 0x0,  
    0x36, 0x60, 0x3a, 0x55, 0x11, 0x29,
    
    0x2a,0x00,0x00,0x03,0x20,//800
    0x2b,0x00,0x00,0x01,0xe0//480
  };
  
  // lcd data
  int data[] = {
    0x2c,
    0xff00,0xff00,0xff00,0xff00,
    0x0ff0,0x0ff0,0x0ff0,0x0ff0,
    0x00ff,0x00ff,0x00ff,0x00ff,
    0xf00f,0xf00f,0xf00f,0xf00f
  };
  
  // initialize 
  write_lcd(0b0111,cmd[0],134,INITIAL);
  
  // config window's size
  // 800
  write_lcd(0b0111,cmd[134],5,INITIAL);
  // 480
  write_lcd(0b0111,cmd[139],5,INITIAL);

  // write data
  short i,j;
  // 800*480/16=800*30
  for(i=0;i<30;i++){
    for(j=0;j<800;j++){
      write_lcd(0b0111,data,17,SEND_DATA);
    }
  }
  return 0;
}
