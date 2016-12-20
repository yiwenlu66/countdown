`timescale 1ns / 1ps

module tb_logic;

reg clk_1s = 0, keydown_start = 0, keydown_num = 0, keydown_confirm = 0, keydown_clear = 0;
reg [3:0] num = 0;
wire display;
wire [4:0] input_val;
wire [5:0] remaining;

logic l (
    .clk_1s(clk_1s),
    .keydown_start(keydown_start),
    .keydown_clear(keydown_clear),
    .keydown_confirm(keydown_confirm),
    .keydown_num(keydown_num),
    .num(num),
    .display(display),
    .input_val(input_val),
    .remaining(remaining)
    );

parameter half_clk_period = 100;

initial begin
    forever #half_clk_period clk_1s = !clk_1s;
end

initial begin

    // start
    #10 keydown_start = 1;
    #60 keydown_start = 0;

    // input >20
    #10 keydown_num = 1; num = 3;
    #60 keydown_num = 0;
    #10 keydown_num = 1; num = 6;
    #60 keydown_num = 0;

    // clear
    #10 keydown_clear = 1;
    #60 keydown_clear = 0;

    // input 15
    #10 keydown_num = 1; num = 1;
    #60 keydown_num = 0;
    #10 keydown_num = 1; num = 5;
    #60 keydown_num = 0;

    // clear
    #10 keydown_clear = 1;
    #60 keydown_clear = 0;

    // input 3
    #10 keydown_num = 1; num = 3;
    #60 keydown_num = 0;

    // confirm
    #10 keydown_confirm = 1;
    #60 keydown_confirm = 0;

    // restart
    #3500 keydown_start = 1;
    #60 keydown_start = 0;

end

endmodule
