`timescale 1ns / 1ps

module tb_display;

reg clk = 0;
reg [3:0] d3, d2, d1, d0;
reg e3, e2, e1, e0;

display disp1 (
    .scan_clk(clk),
    .digit_3(d3), .digit_2(d2), .digit_1(d1), .digit_0(d0),
    .enable_3(e3), .enable_2(e2), .enable_1(e1), .enable_0(e0),
    .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g), .dp(dp),
    .an_3(an_3), .an_2(an_2), .an_1(an_1), .an_0(an_0)
    );

initial begin
    forever #1 clk = !clk;
end

initial begin
    d3 = 1; d2 = 2; d1 = 3; d0 = 4; e3 = 1; e2 = 1; e1 = 1; e0 = 1;
    #12;
    d3 = 5; d2 = 6; d1 = 7; d0 = 8; e3 = 1; e2 = 1; e1 = 1; e0 = 1;
    #12;
    d3 = 0; d2 = 0; d1 = 9; d0 = 0; e3 = 0; e2 = 0; e1 = 1; e0 = 1;
end

endmodule
