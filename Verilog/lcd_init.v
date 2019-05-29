`timescale 1ns / 1ps

module lcd_init(
    output reg [15:0] lcd_data,
    output reg cs,
    output reg rs,
    output reg wr,
    output reg  rst,
    input  wire clk,
    input  wire reset,
    output reg  lcd_init_done
);

    wire clk_use;
    clk_div clk_div_1(
        .clk_in(clk),
        .clk_out(clk_use),
        .div(20)
    );
    reg [31:0] init_delay;
    reg rst_done;
    always @(posedge clk_use)
    begin
        if(reset)
        begin
            init_delay <= 0;
            rst <= 1;
            rst_done <= 0;
        end
        else 
        begin
            if(init_delay>100)
                rst <= 0;
            if(init_delay<25000)
                init_delay <= init_delay + 1;
            else
            begin
                rst <= 1;
                if(init_delay < 50000)
                    init_delay <= init_delay + 1;
                else rst_done <= 1;
            end
        end
    end
    wire [267:0] RS_INI = 268'b00111111_0011_00111111111111111111111111111111111111111111_00111111111111111100111111111111111111001100111111001111110011001111111111110011001111110011001111110011111100111111110011111111001111111111111111111111111111111100111111111111111111111111111111110011001100110000;
    wire [7:0] LCD_CMD_INI [0:133] =
    {
    wire [7:0] LCD_CMD_INI [0:133] = {
        8'hff, 8'hff, 8'h98, 8'h6, 8'hba, 8'he0, 8'hbc, 8'h3, 8'hf, 8'h63, 8'h69, 8'h1, 8'h1, 8'h1b, 8'h11, 8'h70, 8'h73, 8'hff, 8'hff, 8'h8, 
        8'h9, 8'h5, 8'h0, 8'hee, 8'he2, 8'h1, 8'h0, 8'hc1, 8'hbd, 8'h1, 8'h23, 8'h45, 8'h67, 8'h1, 8'h23, 8'h45, 8'h67, 8'hbe, 8'h0, 8'h22, 
        8'h27, 8'h6a, 8'hbc, 8'hd8, 8'h92, 8'h22, 8'h22, 8'hc7, 8'h1e, 8'hed,  8'h7f, 8'hf, 8'h0, 8'hc0, 8'he3, 8'hb, 8'h0, 8'hfc, 8'h8, 8'hdf,
        8'h0, 8'h0, 8'h0, 8'h0, 8'h0, 8'h2, 8'hf3, 8'h74, 8'hb4, 8'h0, 8'h0, 8'h0, 8'hf7, 8'h81, 8'hb1, 8'h0, 8'h10, 8'h14, 8'hf1, 8'h29, 8'h8a, 
        8'h7, 8'hf2, 8'h40, 8'hd2, 8'h50, 8'h28, 8'hc1, 8'h17, 8'h85, 8'h85, 8'h20,  8'he0, 8'h0, 8'hc, 8'h15, 8'hd, 8'hf, 8'hc, 8'h7, 8'h5, 8'h7, 
        8'hb, 8'h10, 8'h10, 8'hd, 8'h17, 8'hf, 8'h0, 8'he1, 8'h0, 8'hd, 8'h15, 8'he, 8'h10, 8'hd, 8'h8, 8'h6, 8'h7, 8'hc, 8'h11, 8'h11, 8'he, 8'h17,
        8'hf, 8'h0, 8'h35, 8'h0, 8'h36, 8'h60, 8'h3a, 8'h55, 8'h11, 8'h29
    };

    reg [9:0] cmd_count;

    always @(posedge clk_use)
    begin
        if(reset)
        begin
            lcd_init_done <= 0;
            cs <= 1;
            rs <= 1;
            wr <= 1;         
            cmd_count <= 0;
            lcd_data <= 0;
        end
        else if(lcd_init_done == 0 && rst_done)
        begin
            if(cmd_count==268)
                lcd_init_done <= 1;
            else
            begin
                rs <= RS_INI[267-cmd_count];
                cs <= 0;
                wr <= !wr;
                lcd_data <= LCD_CMD_INI[cmd_count[9:1]];
                cmd_count <= cmd_count + 1;
            end
        end
    end
    
endmodule
