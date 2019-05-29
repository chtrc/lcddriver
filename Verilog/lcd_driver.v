//---------------------------------------------------------------------------------
//
// IMPORTANT: This document is for use only in the <Embedded System Design>
//
// College of Electrical Engineering, Zhejiang University
//
// zhangpy@vlsi.zju.edu.cn
//
//---------------------------------------------------------------------------------

module lcd_driver(	        clk,
							reset,					
							data,
							lcd_data,
							rst,
							cs,
							rs,
							wr,
							rd,
                            lcd_ctrl
    );
	input clk;
	input reset;
	//input he;
	//input v_sync;
	input [15:0]data;

    input [1:0] lcd_ctrl;

	output [15:0]lcd_data;
	output rst;
	output cs;
	output rs;
	output wr;
	output rd;
	//output [9:0]addr;
	
	reg [9:0]addr;
	reg [15:0] lcd_data;
	reg rst;             //reset
	wire cs;               //dcx
    reg [1:0] c_d;      //
	reg rs;        //resx
	wire wr;       //wrx
	reg rd;        //rdx
    reg [31:0] lcd_ctrl;
		 
    wire nclk;
    assign nclk = ~clk;
    assign cs = 0;
    assign wr = (lcd_ctrl[0] | lcd_ctrl[1]) & nclk;

    always @(posedge clk or posedge reset) begin
        if (~reset) begin           
            rd <= 1;
            lcd_data <= 0;
            rst <= 0;
        end
        else begin
            if (lcd_ctrl[1:0] == 2'b01)begin //01表示控制命令
                rs <= 0;
            end
            else if(lcd_ctrl[1:0] == 2'b10) begin //10表示数据
                rs <= 1;
            end
            
            rst <= 1;
            lcd_data <= data;
            
        end
    end




endmodule
