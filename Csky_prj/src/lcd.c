
#define LCD_AXIs_VIDEOMEM_ADDR     0 
#define LCD_AXIs_VIDEOMEM_LENGTH   1 

#define LCD_AXIs_LCDINITCMD_ADDR   2 
#define LCD_AXIs_LCDINITCMD_LENGTH 3 

#define LCD_AXIs_LCD_CTRL          4 
#define LCD_AXIs_LCD_STATUS        5 


unsigned int* LCD_AXI_MASTER_BASEADDR = (unsigned int*)0x8200_0000;
unsigned int* LCD_AXI_SLAVE_BASEADDR  = (unsigned int*)0x44A0_0000;

void delay(){
  short i,j = 0;
  for(i = 0;i < 100000;i++)
  {
    j++;
  }
}


void write_lcd(unsigned char ctl,unsigned char wdata){
  CTL = ctl;
  LCD_BASE_ADDR[...] = wdata;
}


int main() {
 unsigned int DBL[]={
                        0xff,0xff,0x98,0x06,
                        0x2a,0x00,0x00,0x03,0x20,
                        0x2b,0x00,0x00,0x01,0xe0,
                        0x2c
                     };
  short i,j;
  
  // initialize
  write_lcd(0b0110,DBL[0]);
  for(i=1;i<=3;i++){
    write_lcd(0b0111,DBL[i]);
  }


  // config window's size
  write_lcd(0b0110,DBL[4]);
  for(i=5;i<=8;i++){
    write_lcd(0b0111,DBL[i]);
  }
  
  write_lcd(0b0110,DBL[9]);
  for(i=10;i<=13;i++){
    write_lcd(0b0111,DBL[i]);
  }

  
  // write data
  for(i=0;i<160;i++){
    for(j=0;j<800;j++){
      // command
      write_lcd(0b0110,DBL[14]);
      // data
      write_lcd(0b0111,(unsigned int)0xff00);
    }
  }
  for(i=0;i<160;i++){
    for(j=0;j<800;j++){
      // command
      write_lcd(0b0110,DBL[14]);
      // data
      write_lcd(0b0111,(unsigned int)0x0ff0);
    }
  }
  for(i=0;i<160;i++){
    for(j=0;j<800;j++){
      // command
      write_lcd(0b0110,DBL[14]);
      // data
      write_lcd(0b0111,(unsigned int)0x00ff);
    }
  }


  return 0;
}
