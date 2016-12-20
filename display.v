module display(
    input scan_clk,
    input [3:0] digit_3,
    input [3:0] digit_2,
    input [3:0] digit_1,
    input [3:0] digit_0,
    input enable_3, enable_2, enable_1, enable_0,
    output a, b, c, d, e, f, g,
    output an_3, an_2, an_1, an_0
    );

wire [3:0] num_out;
wire [1:0] index;

scan_display scan (
    .scan_clk(scan_clk),
    .num_in_3(digit_3),
    .num_in_2(digit_2),
    .num_in_1(digit_1),
    .num_in_0(digit_0),
    .num_out(num_out),
    .index(index)
    );

wire [3:0] enable;
assign enable = {enable_3, enable_2, enable_1, enable_0};

two_four_decoder decoder (
    .in(index),
    .out_0(an_0), .out_1(an_1), .out_2(an_2), .out_3(an_3)
    );

seven_seg seven_seg_decoder (
    .enable(enable[index]),
    .num(num_out),
    .a(a), .b(b), .c(c), .d(d), .e(e), .f(f), .g(g)
    );

endmodule
