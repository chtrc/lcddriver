#include "xil_assert.h"
#include "xil_types.h"
#include "xil_printf.h"

#define C_RED     0xF800F800
#define C_YELLOW  0xFFE0FFE0
#define C_BLUE    0x001F001F
#define C_GREEN   0x07E007E0

#define C_CYAN    0xB4DFB4DF
#define C_BLACK   0x00000000
#define C_BURLY   0xFEF5FEF5

#define  IMAGE_X 800
#define  IMAGE_Y 480

#define uint32 unsigned long

int main(){

	int i,j;

	// initialize memory
	uint32 *r = 0x82500000;
	for(i=0;i<IMAGE_X;i++){
		for(j=0;j<IMAGE_Y;j++){
      *r = 0x00000000;
      r++;
		}
	}

  // set color
	uint32 *p = 0x82000000;
  for(i=0;i<IMAGE_X;i++){
	  for(j=0;j<IMAGE_Y;j++){
      *p = C_RED;
      p++;
   	}
  }
  for(i=0;i<IMAGE_X;i++){
	  for(j=0;j<IMAGE_Y;j++){
      *p = C_YELLOW;
      p++;
   	}
  }
  for(i=0;i<IMAGE_X;i++){
	  for(j=0;j<IMAGE_Y;j++){
      *p = C_GREEN;
      p++;
   	}
  }
  for(i=0;i<IMAGE_X;i++){
	  for(j=0;j<IMAGE_Y;j++){
      *p = C_BLUE;
      p++;
   	}
  }
  
  
  return 0;
}
