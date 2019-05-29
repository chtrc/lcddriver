`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/09/21 16:37:32
// Design Name: 
// Module Name: clk_div
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_div(
    input  wire clk_in,
    output reg clk_out,
    input  wire [15:0] div
    );
    reg [15:0] count;
    initial
    begin
        clk_out = 0;
        count = 0;
    end
	always@(posedge clk_in)
	begin
       if(count == div) begin
           count <= 0;
           clk_out <= ~clk_out;
       end
       else begin
           count <= count + 1;
       end
    end
    
endmodule
