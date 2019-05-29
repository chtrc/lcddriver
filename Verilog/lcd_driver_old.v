module lcd_driver(	clk,
							reset,
							he,
							v_sync,
							data,
							lcd_data,
							rst,
							cs,
							rs,
							wr,
							rd,
							addr
    );
	input clk;
	input reset;
	input he;
	input v_sync;
	input [15:0]data;
	output [15:0]lcd_data;
	output rst;
	output cs;
	output rs;
	output wr;
	output rd;
	output [9:0]addr;
	
	reg [9:0]addr;
	reg [15:0] lcd_data;
	reg rst;
	reg cs;
	reg rs;
	reg wr;
	reg rd;
		 
    wire[15:0] LCD_CMD_INI[0:133];	
    wire[15:0] LCD_CMD_WIN[0:15];
    
    // DC
    wire [267:0] RS_INI = 268'b0011111100110011111111111111111111111111111111111111111100111111111111111100111111111111111111001100111111001111110011001111111111110011001111110011001111110011111100111111110011111111001111111111111111111111111111111100111111111111111111111111111111110011001100110000;
    wire [267:0] WR_INI = 268'b0101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101010101;
    wire [21:0] RS_WIN = 22'b0011111111001111111100; 
    wire [21:0] WR_WIN = 22'b0101010101010101010101;
    
    assign LCD_CMD_INI[0] = 16'hFF; // EXTC Command Set enable register 
    assign LCD_CMD_INI[1] = 16'hFF; 
    assign LCD_CMD_INI[2] = 16'h98; 
    assign LCD_CMD_INI[3] = 16'h06; 
    assign LCD_CMD_INI[4] = 16'hBA; // SPI Interface Setting 
    assign LCD_CMD_INI[5] = 16'hE0; 
    assign LCD_CMD_INI[6] = 16'hBC; // GIP 1 
    assign LCD_CMD_INI[7] = 16'h03; 
    assign LCD_CMD_INI[8] = 16'h0F; 
    assign LCD_CMD_INI[9] = 16'h63; 
    assign LCD_CMD_INI[10] = 16'h69; 
    assign LCD_CMD_INI[11] = 16'h01; 
    assign LCD_CMD_INI[12] = 16'h01; 
    assign LCD_CMD_INI[13] = 16'h1B; 
    assign LCD_CMD_INI[14] = 16'h11; 
    assign LCD_CMD_INI[15] = 16'h70; 
    assign LCD_CMD_INI[16] = 16'h73; 
    assign LCD_CMD_INI[17] = 16'hFF; 
    assign LCD_CMD_INI[18] = 16'hFF; 
    assign LCD_CMD_INI[19] = 16'h08; 
    assign LCD_CMD_INI[20] = 16'h09; 
    assign LCD_CMD_INI[21] = 16'h05; 
    assign LCD_CMD_INI[22] = 16'h00;
    assign LCD_CMD_INI[23] = 16'hEE; 
    assign LCD_CMD_INI[24] = 16'hE2; 
    assign LCD_CMD_INI[25] = 16'h01; 
    assign LCD_CMD_INI[26] = 16'h00;
    assign LCD_CMD_INI[27] = 16'hC1; 
    assign LCD_CMD_INI[28] = 16'hBD; // GIP 2 
    assign LCD_CMD_INI[29] = 16'h01; 
    assign LCD_CMD_INI[30] = 16'h23; 
    assign LCD_CMD_INI[31] = 16'h45; 
    assign LCD_CMD_INI[32] = 16'h67; 
    assign LCD_CMD_INI[33] = 16'h01; 
    assign LCD_CMD_INI[34] = 16'h23; 
    assign LCD_CMD_INI[35] = 16'h45; 
    assign LCD_CMD_INI[36] = 16'h67; 
    assign LCD_CMD_INI[37] = 16'hBE; // GIP 3 
    assign LCD_CMD_INI[38] = 16'h00; 
    assign LCD_CMD_INI[39] = 16'h22; 
    assign LCD_CMD_INI[40] = 16'h27; 
    assign LCD_CMD_INI[41] = 16'h6A; 
    assign LCD_CMD_INI[42] = 16'hBC; 
    assign LCD_CMD_INI[43] = 16'hD8; 
    assign LCD_CMD_INI[44] = 16'h92; 
    assign LCD_CMD_INI[45] = 16'h22; 
    assign LCD_CMD_INI[46] = 16'h22; 
    assign LCD_CMD_INI[47] = 16'hC7; // Vcom 
    assign LCD_CMD_INI[48] = 16'h1E;
    assign LCD_CMD_INI[49] = 16'hED; // EN_volt_reg 
    assign LCD_CMD_INI[50] = 16'h7F; 
    assign LCD_CMD_INI[51] = 16'h0F; 
    assign LCD_CMD_INI[52] = 16'h00; 
    assign LCD_CMD_INI[53] = 16'hC0; // Power Control 1
    assign LCD_CMD_INI[54] = 16'hE3; 
    assign LCD_CMD_INI[55] = 16'h0B; 
    assign LCD_CMD_INI[56] = 16'h00;
    assign LCD_CMD_INI[57] = 16'hFC;
    assign LCD_CMD_INI[58] = 16'h08; 
    assign LCD_CMD_INI[59] = 16'hDF; // Engineering Setting 
    assign LCD_CMD_INI[60] = 16'h00; 
    assign LCD_CMD_INI[61] = 16'h00; 
    assign LCD_CMD_INI[62] = 16'h00; 
    assign LCD_CMD_INI[63] = 16'h00; 
    assign LCD_CMD_INI[64] = 16'h00; 
    assign LCD_CMD_INI[65] = 16'h02; 
    assign LCD_CMD_INI[66] = 16'hF3; // DVDD Voltage Setting 
    assign LCD_CMD_INI[67] = 16'h74; 
    assign LCD_CMD_INI[68] = 16'hB4; // Display Inversion Control 
    assign LCD_CMD_INI[69] = 16'h00; 
    assign LCD_CMD_INI[70] = 16'h00; 
    assign LCD_CMD_INI[71] = 16'h00; 
    assign LCD_CMD_INI[72] = 16'hF7; // 4816'h854
    assign LCD_CMD_INI[73] = 16'h81; 
    assign LCD_CMD_INI[74] = 16'hB1; // Frame Rate 
    assign LCD_CMD_INI[75] = 16'h00; 
    assign LCD_CMD_INI[76] = 16'h10; 
    assign LCD_CMD_INI[77] = 16'h14; 
    assign LCD_CMD_INI[78] = 16'hF1; // Panel Timing Control 
    assign LCD_CMD_INI[79] = 16'h29; 
    assign LCD_CMD_INI[80] = 16'h8A; 
    assign LCD_CMD_INI[81] = 16'h07; 
    assign LCD_CMD_INI[82] = 16'hF2; //Panel Timing Control 
    assign LCD_CMD_INI[83] = 16'h40; 
    assign LCD_CMD_INI[84] = 16'hD2; 
    assign LCD_CMD_INI[85] = 16'h50; 
    assign LCD_CMD_INI[86] = 16'h28; 
    assign LCD_CMD_INI[87] = 16'hC1; // Power Control 2 
    assign LCD_CMD_INI[88] = 16'h17;
    assign LCD_CMD_INI[89] = 16'h85; 
    assign LCD_CMD_INI[90] = 16'h85; 
    assign LCD_CMD_INI[91] = 16'h20; 
    assign LCD_CMD_INI[92] = 16'hE0; 
    assign LCD_CMD_INI[93] = 16'h00; //P1 
    assign LCD_CMD_INI[94] = 16'h0C; //P2 
    assign LCD_CMD_INI[95] = 16'h15; //P3 
    assign LCD_CMD_INI[96] = 16'h0D; //P4 
    assign LCD_CMD_INI[97] = 16'h0F; //P5 
    assign LCD_CMD_INI[98] = 16'h0C; //P6 
    assign LCD_CMD_INI[99] = 16'h07; //P7 
    assign LCD_CMD_INI[100] = 16'h05; //P8 
    assign LCD_CMD_INI[101] = 16'h07; //P9 
    assign LCD_CMD_INI[102] = 16'h0B; //P10 
    assign LCD_CMD_INI[103] = 16'h10; //P11 
    assign LCD_CMD_INI[104] = 16'h10; //P12 
    assign LCD_CMD_INI[105] = 16'h0D; //P13 
    assign LCD_CMD_INI[106] = 16'h17; //P14 
    assign LCD_CMD_INI[107] = 16'h0F; //P15 
    assign LCD_CMD_INI[108] = 16'h00; //P16 
    assign LCD_CMD_INI[109] = 16'hE1; 
    assign LCD_CMD_INI[110] = 16'h00; //P1 
    assign LCD_CMD_INI[111] = 16'h0D; //P2 
    assign LCD_CMD_INI[112] = 16'h15; //P3 
    assign LCD_CMD_INI[113] = 16'h0E; //P4 
    assign LCD_CMD_INI[114] = 16'h10; //P5 
    assign LCD_CMD_INI[115] = 16'h0D; //P6 
    assign LCD_CMD_INI[116] = 16'h08; //P7 
    assign LCD_CMD_INI[117] = 16'h06; //P8 
    assign LCD_CMD_INI[118] = 16'h07; //P9 
    assign LCD_CMD_INI[119] = 16'h0C; //P10 
    assign LCD_CMD_INI[120] = 16'h11; //P11 
    assign LCD_CMD_INI[121] = 16'h11; //P12 
    assign LCD_CMD_INI[122] = 16'h0E; //P13 
    assign LCD_CMD_INI[123] = 16'h17; //P14 
    assign LCD_CMD_INI[124] = 16'h0F; //P15 
    assign LCD_CMD_INI[125] = 16'h00; //P16
    assign LCD_CMD_INI[126] = 16'h35; //Tearing Effect ON 
    assign LCD_CMD_INI[127] = 16'h00; 
    assign LCD_CMD_INI[128] = 16'h36; 
    assign LCD_CMD_INI[129] = 16'h60; 
    assign LCD_CMD_INI[130] = 16'h3A; 
    assign LCD_CMD_INI[131] = 16'h55; 
    assign LCD_CMD_INI[132] = 16'h11; //Exit Sleep 
    assign LCD_CMD_INI[133] = 16'h29; // Display On 
    
    //设置窗口分辨率  480*480 854*480
    assign LCD_CMD_WIN[0] = 16'h2a; //设置横向分辨率
    assign LCD_CMD_WIN[1] = 16'h00; //00
    assign LCD_CMD_WIN[2] = 16'h00; //00
    assign LCD_CMD_WIN[3] = 16'h03; //03  0x0355h 853 
    assign LCD_CMD_WIN[4] = 16'h55; //20       
    assign LCD_CMD_WIN[5] = 16'h2b; //设置纵向分辨率
    assign LCD_CMD_WIN[6] = 16'h00; //00
    assign LCD_CMD_WIN[7] = 16'h00; //00
    assign LCD_CMD_WIN[8] = 16'h01; //01   0x01dfh 479 
    assign LCD_CMD_WIN[9] = 16'hdf; //e0
        
    assign LCD_CMD_WIN[10] = 16'h2c;    

	
				

TODO... ...



endmodule
