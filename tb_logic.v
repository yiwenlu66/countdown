`timescale 1ns / 1ps

module tb_logic;

reg clk = 0, tick = 0, keydown_start = 0, keydown_num = 0, keydown_confirm = 0, keydown_clear = 0;
reg [3:0] num = 0;
wire display;
wire [4:0] input_val;
wire [5:0] remaining;

logic tb_logic__logic (
    .clk(clk),
    .tick(tick),
    .keydown_start(keydown_start),
    .keydown_clear(keydown_clear),
    .keydown_confirm(keydown_confirm),
    .keydown_num(keydown_num),
    .num(num),
    .display(display),
    .input_val(input_val),
    .remaining(remaining)
    );

initial begin
    forever #10 clk = !clk;
end

initial begin
    forever #1000 tick = !tick;
end


initial begin

    // start
    #1050 keydown_start = 1;
    #600 keydown_start = 0;

    // input >20
    #100 keydown_num = 1; num = 3;
    #600 keydown_num = 0;
    #100 keydown_num = 1; num = 6;
    #600 keydown_num = 0;

    // clear
    #100 keydown_clear = 1;
    #600 keydown_clear = 0;

    // input 15
    #100 keydown_num = 1; num = 1;
    #600 keydown_num = 0;
    #100 keydown_num = 1; num = 5;
    #600 keydown_num = 0;

    // clear
    #100 keydown_clear = 1;
    #600 keydown_clear = 0;

    // input 3
    #100 keydown_num = 1; num = 3;
    #600 keydown_num = 0;

    // confirm
    #100 keydown_confirm = 1;
    #600 keydown_confirm = 0;

    // restart
    #35000 keydown_start = 1;
    #600 keydown_start = 0;

end

endmodule
