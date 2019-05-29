`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/09/22 14:17:38 
// Design Name: 
// Module Name: camera
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


module camera(
    input wire clk,
    input wire reset,
    output wire cam_rst,
    output wire sioc,
    output wire siod,
    output wire xclk

    );
    /*
   clk_div_3 clk_div_4(.clk_in(clk),
                     .clk_out(xclk),
                     .reset(reset));*/
       clk_div clk_div_4(
                         .clk_in(clk),
                         .clk_out(xclk),
                         .div(1)
                     );
    cam_sccb cam_sccb_1(
        .clk(clk),
        .reset(reset),
        .cam_rst(cam_rst),
        .sioc(sioc),
        .siod(siod)
    );
    
endmodule
