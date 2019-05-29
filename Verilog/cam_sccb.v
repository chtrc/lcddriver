`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/09/22 14:24:10
// Design Name: 
// Module Name: cam_sccb
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


module cam_sccb(
    input wire clk,
    input wire reset,
    output reg cam_rst,
    output reg  sioc,
    output wire siod
    );
    wire clk10k;
    clk_div clk_div_3(
        .clk_in(clk),
        .clk_out(clk10k),
        .div(500)
    );
    reg [31:0] init_delay;
    reg rst_done;
    always @(posedge clk10k)
    begin
        if(reset)
        begin
            init_delay <= 0;
            rst_done <= 0;
        end
        else
        begin
            if(init_delay < 10000)
                init_delay <= init_delay + 1;
            if(init_delay < 1000)
                cam_rst <= 0;
            else if(init_delay < 2000)
                cam_rst <= 1;
            else
                rst_done <= 1; 
        end
    end
    wire [123:0] SCL = 124'b11111110_0001000100010001_0001000100010001_0001000100010001_0001000100010001_0001000100010001_0001000100010001_000100010001_01111111;
    

    wire [15:0] cam_reg_date_0 [0:194] = {16'hff01,16'h1280,16'hff00,16'h2cff,16'h2edf,
                                           16'hff01,16'h3c32,16'h1101,16'h900,16'h428,
                                           16'h13e5,16'h1448,16'h2c0c,16'h3378,16'h3a33,
                                           16'h3bfb,16'h3e00,16'h4311,16'h1610,16'h3992,
                                           16'h35da,16'h221a,16'h37c3,16'h2300,16'h34c0,
                                           16'h361a,16'h688,16'h7c0,16'hd87,16'he41,
                                           16'h4c00,16'h4a81,16'h2199,16'h2440,16'h2538,
                                           16'h2682,16'h5c00,16'h6300,16'h4622,16'hc3c,
                                           16'h5d55,16'h5e7d,16'h5f7d,16'h6055,16'h6170,
                                           16'h6280,16'h7c05,16'h2080,16'h2830,16'h6c00,
                                           16'h6d80,16'h6e00,16'h7002,16'h7194,16'h73c1,
    16'h1240,16'h1711,16'h1843,16'h1900,16'h1a4b,16'h3209,16'h37c0,16'h4fca,16'h50a8,16'h6d00,16'h3d38,16'hff00,16'he57f,16'hf9c0,16'h4124,16'h4406,16'he014,16'h76ff,16'h33a0,16'h4220,16'h4318,16'h4c00,16'h87d0,16'h883f,16'hd703,16'hd910,16'hd382,16'hc808,16'hc980,16'h7c00,16'h7d00,16'h7c03,16'h7d48,16'h7d48,16'h7c08,16'h7d20,16'h7d10,16'h7d0e,16'h9000,16'h910e,16'h911a,16'h9131,16'h915a,16'h9169,16'h9175,16'h917e,16'h9188,16'h918f,16'h9196,16'h91a3,16'h91af,16'h91c4,16'h91d7,16'h91e8,16'h9120,16'h9200,16'h9306,16'h93e3,16'h9303,16'h9303,16'h9300,16'h9302,16'h9300,16'h9300,16'h9300,16'h9300,16'h9300,16'h9300,16'h9300,16'h9600,16'h9708,16'h9719,16'h9702,16'h970c,16'h9724,16'h9730,16'h9728,16'h9726,16'h9702,16'h9798,16'h9780,16'h9700,16'h9700,16'ha400,16'ha800,16'hc511,16'hc651,16'hbf80,16'hc710,16'hb666,16'hb8a5,16'hb764,16'hb97c,16'hb3af,16'hb497,16'hb5ff,16'hb0c5,16'hb194,16'hb20f,16'hc45c,16'ha600,16'ha720,16'ha7d8,16'ha71b,16'ha731,16'ha700,16'ha718,16'ha720,16'ha7d8,16'ha719,16'ha731,16'ha700,16'ha718,16'ha720,16'ha7d8,16'ha719,16'ha731,16'ha700,16'ha718,16'hc064,16'hc14b,16'h861d,16'h5000,16'h51c8,16'h5296,16'h5300,16'h5400,16'h5500,16'h5700,16'h5ac8,16'h5b96,16'h5c00,16'hc3ef,16'h7f00,16'hda01,16'he51f,16'he167,16'he000,16'hdd7f,16'h500};


wire [15:0] cam_reg_date_1 [0:(186)] = {16'hff01,16'h1280,16'hff00,16'h2cff,16'h2edf,
                                         16'hff01,16'h3c32,16'h1101,16'h900,16'h428,
                                         16'h13e5,16'h1448,16'h2c0c,16'h3378,16'h3a33,
                                         16'h3bfb,16'h3e00,16'h4311,16'h1610,16'h3982,
                                         16'h3588,16'h220a,16'h3740,16'h2300,16'h34a0,
                                         16'h361a,16'h602,16'h7c0,16'hdb7,16'he01,
                                         16'h4c00,16'h4a81,16'h2199,16'h2440,16'h2538,
                                         16'h2682,16'h5c00,16'h6300,16'h463f,16'hc3c,
                                         16'h5d55,16'h5e7d,16'h5f7d,16'h6055,16'h6170,
                                         16'h6280,16'h7c05,16'h2080,16'h2830,16'h6c00,
                                         16'h6d80,16'h6e00,16'h7002,16'h7194,16'h73c1,
                                         16'h3d34,16'h5a57,16'h4fbb,16'h509c,16'hff00,
                                         16'he57f,16'hf9c0,16'h4124,16'h4406,16'he014,
                                         16'h76ff,16'h33a0,16'h4220,16'h4318,16'h4c00,
                                         16'h87d0,16'hd703,16'hd910,16'hd382,16'hc808,
                                         16'hc980,16'h7c00,16'h7d00,16'h7c03,16'h7d48,
                                         16'h7d48,16'h7c08,16'h7d20,16'h7d10,16'h7d0e,
                                         16'h9000,16'h910e,16'h911a,16'h9131,16'h915a,
                                         16'h9169,16'h9175,16'h917e,16'h9188,16'h918f,
                                         16'h9196,16'h91a3,16'h91af,16'h91c4,16'h91d7,
                                         16'h91e8,16'h9120,16'h9200,16'h9306,16'h93e3,
                                         16'h9303,16'h9303,16'h9300,16'h9302,16'h9300,
                                         16'h9300,16'h9300,16'h9300,16'h9300,16'h9300,
                                         16'h9300,16'h9600,16'h9708,16'h9719,16'h9702,
                                         16'h970c,16'h9724,16'h9730,16'h9728,16'h9726,
                                         16'h9702,16'h9798,16'h9780,16'h9700,16'h9700,
                                         16'ha400,16'ha800,16'hc511,16'hc651,16'hbf80,
                                         16'hc710,16'hb666,16'hb8a5,16'hb764,16'hb97c,
                                         16'hb3af,16'hb497,16'hb5ff,16'hb0c5,16'hb194,
                                         16'hb20f,16'hc45c,16'ha600,16'ha720,16'ha7d8,
                                         16'ha71b,16'ha731,16'ha700,16'ha718,16'ha720,
                                         16'ha7d8,16'ha719,16'ha731,16'ha700,16'ha718,
                                         16'ha720,16'ha7d8,16'ha719,16'ha731,16'ha700,  
                                         16'ha718,16'hc0c8,16'hc196,16'h863d,16'h5000,
                                         16'h51f0,16'h5290,16'h5350,16'h5450,16'h5511,
                                         16'h5700,16'h5af0,16'h5b90,16'h5c00,16'hc3ef,
                                         16'h7f00,16'hda09,16'he51f,16'he167,16'he000,
                                         16'hdd7f,16'h500
                                     }; 
/*

    wire [15:0] cam_reg_date [0:186] = {16'hff01,16'h1280,16'hff00,16'h2cff,16'h2edf,
                                     16'hff01,16'h3c32,16'h1101,16'h900,16'h428,
                                     16'h13e5,16'h1448,16'h2c0c,16'h3378,16'h3a33,
                                     16'h3bfb,16'h3e00,16'h4311,16'h1610,16'h3982,
                                     16'h3588,16'h220a,16'h3740,16'h2300,16'h34a0,
                                     16'h361a,16'h602,16'h7c0,16'hdb7,16'he01,
                                     16'h4c00,16'h4a81,16'h2199,16'h2440,16'h2538,
                                     16'h2682,16'h5c00,16'h6300,16'h463f,16'hc3c,
                                     16'h5d55,16'h5e7d,16'h5f7d,16'h6055,16'h6170,
                                     16'h6280,16'h7c05,16'h2080,16'h2830,16'h6c00,
                                     16'h6d80,16'h6e00,16'h7002,16'h7194,16'h73c1,
                                     16'h3d34,16'h5a57,16'h4fbb,16'h509c,16'hff00,
                                     16'he57f,16'hf9c0,16'h4124,16'h4406,16'he014,
                                     16'h76ff,16'h33a0,16'h4220,16'h4318,16'h4c00,
                                     16'h87d0,16'hd703,16'hd910,16'hd382,16'hc808,
                                     16'hc980,16'h7c00,16'h7d00,16'h7c03,16'h7d48,
                                     16'h7d48,16'h7c08,16'h7d20,16'h7d10,16'h7d0e,
                                     16'h9000,16'h910e,16'h911a,16'h9131,16'h915a,
                                     16'h9169,16'h9175,16'h917e,16'h9188,16'h918f,
                                     16'h9196,16'h91a3,16'h91af,16'h91c4,16'h91d7,
                                     16'h91e8,16'h9120,16'h9200,16'h9306,16'h93e3,
                                     16'h9303,16'h9303,16'h9300,16'h9302,16'h9300,
                                     16'h9300,16'h9300,16'h9300,16'h9300,16'h9300,
                                     16'h9300,16'h9600,16'h9708,16'h9719,16'h9702,
                                     16'h970c,16'h9724,16'h9730,16'h9728,16'h9726,
                                     16'h9702,16'h9798,16'h9780,16'h9700,16'h9700,
                                     16'ha400,16'ha800,16'hc511,16'hc651,16'hbf80,
                                     16'hc710,16'hb666,16'hb8a5,16'hb764,16'hb97c,
                                     16'hb3af,16'hb497,16'hb5ff,16'hb0c5,16'hb194,
                                     16'hb20f,16'hc45c,16'ha600,16'ha720,16'ha7d8,
                                     16'ha71b,16'ha731,16'ha700,16'ha718,16'ha720,
                                     16'ha7d8,16'ha719,16'ha731,16'ha700,16'ha718,
                                     16'ha720,16'ha7d8,16'ha719,16'ha731,16'ha700,
                                     16'ha718,16'hc0c8,16'hc196,16'h863d,16'h5000,
                                     16'h5190,16'h52e0,16'h5300,16'h5498,16'h5502,
                                     16'h5700,16'h5a90,16'h5be0,16'h5c00,16'hc3ef,
                                     16'h7f00,16'hda09,16'he51f,16'he167,16'he000,
                                     16'hdd7f,16'h500
                                         //16'hff01, 16'h030f, 16'h1901, 16'h1a3d, 16'h3236, 16'h1711, 16'h1849,   //896*480
                                         //16'hff00, 16'he004, 16'hc070, 16'hc13c, 16'h8c00, 16'he000, //896*480
                                         //16'he004, 16'h51e0, 16'h5278, 16'h5300 ,16'h5400, 16'h5500, 16'h5700,16'he000, //896*480
                                         //16'he004, 16'h5ae0, 16'h5b78, 16'h5c00, 16'he000   //896*480
                                         };*/
                                        
                                       
    reg [30:0] SDA;
    reg [7:0]cmd_count;
    wire [7:0] sccb_id = 8'h60;
    reg start_sccb;
    reg [7:0] sccb_count;
    reg [15:0] delay;
    reg siod_tmp;
    reg siod_flag;
    reg soid_finish;
    always @(posedge clk10k)
    begin
        if(reset)
        begin
            sioc <= 1;
            siod_tmp <= 1;
            cmd_count <= 0;
            start_sccb <= 0;
            delay <= 0;
            siod_flag <= 0;
            soid_finish <= 0;
        end
        else if(rst_done)
        begin
            if(start_sccb == 0)
            begin
                if(cmd_count == 1 && delay <1000 )
                begin
                    delay <= delay + 1;
                end 
                else 
                begin
                    /*if(select == 0 && cmd_count < 195 && soid_finish == 0)
                    begin
                        SDA = {2'b10, sccb_id, 1'b0, cam_reg_date_0[cmd_count][15:8], 1'b0, cam_reg_date_0[cmd_count][7:0],1'b0,2'b01};
                        cmd_count <= cmd_count + 1;
                        sccb_count <= 0;
                        start_sccb <= 1;
                    end
                    else */
                    if(/*select == 1 && */cmd_count < (187) && soid_finish == 0)
                    begin
                        SDA = {2'b10, sccb_id, 1'b0, cam_reg_date_1[cmd_count][15:8], 1'b0, cam_reg_date_1[cmd_count][7:0],1'b0,2'b01};
                        cmd_count <= cmd_count + 1;
                        sccb_count <= 0;
                        start_sccb <= 1;
                    end
                    else soid_finish <= 1;                    
                end

            end
            else
            begin
                if(sccb_count == 123)
                    start_sccb <= 0;
                sioc <= SCL[123-sccb_count];
                if(sccb_count[1:0] == 1)
                begin 
                    if(sccb_count[7:2] == 10 || sccb_count[7:2] == 19 || sccb_count[7:2] == 28)
                        siod_flag <= 1;
                    else
                    begin
                        siod_flag <= 0;
                        siod_tmp <= SDA[30-sccb_count[7:2]];
                    end
                end
                sccb_count <= sccb_count + 1;
            end
        end
    end
    assign siod = siod_flag ? 1'bz : siod_tmp;
endmodule
