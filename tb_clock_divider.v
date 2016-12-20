`timescale 1ns / 1ps

module tb_clock_divider;

reg clk_in = 0;
wire clk_out;
reg [26:0] size = 2;

clock_divider c (
    .clk_in(clk_in),
    .clk_out(clk_out),
    .size(size)
    );

initial begin
    forever #10 clk_in = !clk_in;
end

endmodule
