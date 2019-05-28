//---------------------------------------------------------------------------------
//
// IMPORTANT: This document is for use only in the <Embedded System Design>
//
// College of Electrical Engineering, Zhejiang University
//
// zhangpy@vlsi.zju.edu.cn
//
//---------------------------------------------------------------------------------

module sccb(clk,
				reset,
				soic,
				soid,
				xclk,
				rstsccb
           );
    
	input  clk;
    input  reset;
    output soic;
    output soid;
	output rstsccb;
	output xclk;
	 
    
    parameter SCCBID = 8'h60;
    parameter ACK = 1'b0;
    parameter SOICHEAD = 4'b1110;
    parameter SOIDHEAD = 4'b1100;
    parameter SOICEND = 4'b1111;
    parameter SOIDEND = 4'b0111;
    parameter SOICMID = 27'd0;
	 
    wire [15:0] INS[0:191];

	assign INS[0] = 16'hff01;
	assign INS[1] = 16'h1280;
	assign INS[2] = 16'hff00;
	assign INS[3] = 16'h2cff;
	assign INS[4] = 16'h2edf;
	assign INS[5] = 16'hff01;
	assign INS[6] = 16'h3c32;
	assign INS[7] = 16'h1100;
	assign INS[8] = 16'h0902;
	assign INS[9] = 16'h0428;
	assign INS[10] = 16'h13e5;
	assign INS[11] = 16'h1448;
	assign INS[12] = 16'h2c0c;
	assign INS[13] = 16'h3378;
	assign INS[14] = 16'h3a33;
	assign INS[15] = 16'h3bfB;
	assign INS[16] = 16'h3e00;
	assign INS[17] = 16'h4311;
	assign INS[18] = 16'h1610;
	assign INS[19] = 16'h3992;
	assign INS[20] = 16'h35da;
	assign INS[21] = 16'h221a;
	assign INS[22] = 16'h37c3;
	assign INS[23] = 16'h2300;
	assign INS[24] = 16'h34c0;
	assign INS[25] = 16'h361a;
	assign INS[26] = 16'h0688;
	assign INS[27] = 16'h07c0;
	assign INS[28]= 16'h0d87;
	assign INS[29] = 16'h0e41;
	assign INS[30] = 16'h4c00;
	assign INS[31] = 16'h4800;
	assign INS[32] = 16'h5B00;
	assign INS[33] = 16'h4203;
	assign INS[34] = 16'h4a81;
	assign INS[35] = 16'h2199;
	assign INS[36] = 16'h2440;
	assign INS[37] = 16'h2538;
	assign INS[38] = 16'h2682;
	assign INS[39] = 16'h5c00;
	assign INS[40] = 16'h6300;
	assign INS[41] = 16'h4622;
	assign INS[42] = 16'h0c3c;
	assign INS[43] = 16'h6170;
	assign INS[44] = 16'h6280;
	assign INS[45] = 16'h7c05;
	assign INS[46] = 16'h2080;
	assign INS[47] = 16'h2830;
	assign INS[48] = 16'h6c00;
	assign INS[49] = 16'h6d80;
	assign INS[50] = 16'h6e00;
	assign INS[51] = 16'h7002;
	assign INS[52] = 16'h7194;
	assign INS[53] = 16'h73c1;
	assign INS[54] = 16'h1240;
	assign INS[55] = 16'h1711;
	assign INS[56] = 16'h1843;
	assign INS[57] = 16'h1900;
	assign INS[58] = 16'h1a4b;
	assign INS[59] = 16'h3209;
	assign INS[60] = 16'h37c0;
	assign INS[61] = 16'h4fca;
	assign INS[62] = 16'h50a8;
	assign INS[63] = 16'h5a23;
	assign INS[64] = 16'h6d00;
	assign INS[65] = 16'h3d38;
	assign INS[66] = 16'hff00;
	assign INS[67] = 16'he57f;
	assign INS[68] = 16'hf9c0;
	assign INS[69] = 16'h4124;
	assign INS[70] = 16'he014;
	assign INS[71] = 16'h76ff;
	assign INS[72] = 16'h33a0;
	assign INS[73] = 16'h4220;
	assign INS[74] = 16'h4318;
	assign INS[75] = 16'h4c00;
	assign INS[76] = 16'h87d5;
	assign INS[77] = 16'h883f;
	assign INS[78] = 16'hd703;
	assign INS[79] = 16'hd910;
	assign INS[80] = 16'hd38f;/////////////////////////////////////////82
	assign INS[81] = 16'hc808;
	assign INS[82] = 16'hc980;
	assign INS[83] = 16'h7c00;
	assign INS[84] = 16'h7d00;
	assign INS[85] = 16'h7c03;
	assign INS[86] = 16'h7d48;
	assign INS[87] = 16'h7d48;
	assign INS[88] = 16'h7c08;
	assign INS[89] = 16'h7d20;
	assign INS[90] = 16'h7d10;
	assign INS[91] = 16'h7d0e;
	assign INS[92] = 16'h9000;
	assign INS[93] = 16'h910e;
	assign INS[94] = 16'h911a;
	assign INS[95] = 16'h9131;
	assign INS[96] = 16'h915a;
	assign INS[97] = 16'h9169;
	assign INS[98] = 16'h9175;
	assign INS[99] = 16'h917e;
	assign INS[100] = 16'h9188;
	assign INS[101] = 16'h918f;
	assign INS[102] = 16'h9196;
	assign INS[103] = 16'h91a3;
	assign INS[104] = 16'h91af;
	assign INS[105] = 16'h91c4;
	assign INS[106] = 16'h91d7;
	assign INS[107] = 16'h91e8;
	assign INS[108] = 16'h9120;
	assign INS[109] = 16'h9200;
	assign INS[110] = 16'h9306;
	assign INS[111] = 16'h93e3;
	assign INS[112] = 16'h9305;
	assign INS[113] = 16'h9305;
	assign INS[114] = 16'h9300;
	assign INS[115] = 16'h9304;
	assign INS[116] = 16'h9300;
	assign INS[117] = 16'h9300;
	assign INS[118] = 16'h9300;
	assign INS[119] = 16'h9300;
	assign INS[120] = 16'h9300;
	assign INS[121] = 16'h9300;
	assign INS[122] = 16'h9300;
	assign INS[123] = 16'h9600;
	assign INS[124] = 16'h9708;
	assign INS[125] = 16'h9719;
	assign INS[126] = 16'h9702;
	assign INS[127] = 16'h970c;
	assign INS[128] = 16'h9724;
	assign INS[129] = 16'h9730;
	assign INS[130] = 16'h9728;
	assign INS[131] = 16'h9726;
	assign INS[132] = 16'h9702;
	assign INS[133] = 16'h9798;
	assign INS[134] = 16'h9780;
	assign INS[135] = 16'h9700;
	assign INS[136] = 16'h9700;
	assign INS[137] = 16'hc3ed;
	assign INS[138] = 16'ha400;
	assign INS[139] = 16'ha800;
	assign INS[140] = 16'hc511;
	assign INS[141] = 16'hc651;
	assign INS[142] = 16'hbf80;
	assign INS[143] = 16'hc710;
	assign INS[144] = 16'hb666;
	assign INS[145] = 16'hb8A5;
	assign INS[146] = 16'hb764;
	assign INS[147] = 16'hb97C;
	assign INS[148] = 16'hb3af;
	assign INS[149] = 16'hb497;
	assign INS[150] = 16'hb5FF;
	assign INS[151] = 16'hb0C5;
	assign INS[152] = 16'hb194;
	assign INS[153] = 16'hb20f;
	assign INS[154] = 16'hc45c;
	assign INS[155] = 16'hc04b;//64
	assign INS[156] = 16'hc14b;//4b
	assign INS[157] = 16'h8c00;//00
	assign INS[158] = 16'h863D;
	assign INS[159] = 16'h5000;//00
	assign INS[160] = 16'h5196;//c8
	assign INS[161] = 16'h5296;//96
	assign INS[162] = 16'h5300;//00
	assign INS[163] = 16'h5400;//00
	assign INS[164] = 16'h5500;//00
	assign INS[165] = 16'h5a96;//c8
	assign INS[166] = 16'h5b96;//96
	assign INS[167] = 16'h5c00;//00
	assign INS[168] = 16'hd38f;/////////////////////////////////////////
	assign INS[169] = 16'hc3ed;
	assign INS[170] = 16'h7f00;
	assign INS[171] = 16'hda08;
	assign INS[172] = 16'he51f;
	assign INS[173] = 16'he167;
	assign INS[174] = 16'he000;
	assign INS[175] = 16'hdd7f;
	assign INS[176] = 16'h0500;
	
	assign INS[177] = 16'hff00;
	
	assign INS[178] = 16'hff00;
	assign INS[179] = 16'hda09;
	assign INS[180] = 16'hd703;
	assign INS[181] = 16'hdf02;
	assign INS[182] = 16'h33a0;
	assign INS[183] = 16'h3c00;
	assign INS[184] = 16'he167;
	assign INS[185] = 16'hff01;
	assign INS[186] = 16'he000;
	assign INS[187] = 16'he100;
	assign INS[188] = 16'he500;
	assign INS[189] = 16'hd700;
	assign INS[190] = 16'hda00;
	assign INS[191] = 16'he000;
 
 /* Your code */
 
 endmodule
