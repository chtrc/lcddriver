//============================================================================
// Name        : lcd_t.c
// Author      : fhx
// Version     :
// Copyright   : Your copyright notice
// Description : Simple function in C, Ansi-style
//============================================================================
//#include "ff.h"
#include "xil_assert.h"
#include "xil_types.h"
#include "xil_printf.h"

#define C_RED     0xF800F800
#define C_YELLOW  0xFFE0FFE0
#define C_BLUE    0x001F001F
#define C_MAGENTA 0xF81FF81F
#define C_GREEN   0x07E007E0
#define C_CYAN    0xB4DFB4DF
#define C_BLACK   0x00000000
#define C_BURLY   0xFEF5FEF5


#define  IMAGE_X 896
#define  IMAGE_Y 480

#define u32 unsigned long

int main() {
	// TODO

     u32 i=0,j=0;
	 int x_loc,y_loc;

	 u32 *r;
	 for(r=0x82500000;r<=0x82500000+896*480;r++)
     {
       *r = 0x00000000;
       }

	 u32 *p;
     for (p=0x82000000;p<=0x82000000+896*480*4;p++)
		     {
		       x_loc = i%IMAGE_X;
		       y_loc = i/IMAGE_X;
		       i++;
               if (y_loc < 40)
		        	*p=C_RED;
               else if (y_loc < 80)
               	    *p=C_YELLOW;
               else if (y_loc < 120)
                    *p=C_GREEN;
		       else if (y_loc < 160)
	        	    *p=C_CYAN;
		       else if (y_loc < 200)
		       	    *p=C_MAGENTA;
		       else if (y_loc < 240)
		       	    *p=C_BURLY;
	           else
		            *p=C_BLACK;
		       }

/* 	while(1){
			  if(j<=0xFF0000)
				  j++;
			  else
				  j=0;
			  for(i=0;i<896*480;i++){
				  x_loc = i%IMAGE_X;
				  y_loc = i/IMAGE_X;
				  *(p+i)=C_RED+x_loc+y_loc+j;

			  }
		  }*/

	return 0;
}
