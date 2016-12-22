`timescale 1ns / 1ps

module tb_clock_divider;

reg clk_in = 0;
wire clk_out;
reg [31:0] size = 2;

clock_divider tb_clock_divider__clock_divider (
    .clk_in(clk_in),
    .clk_out(clk_out),
    .size(size)
    );

initial begin
    forever #10 clk_in = !clk_in;
end

endmodule
