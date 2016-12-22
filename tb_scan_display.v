`timescale 1ns / 1ps

module tb_scan_display;

reg scan_clk = 0;
wire [3:0] num_out;
wire [1:0] index;

scan_display tb_scan_display__scan_display (
    .scan_clk(scan_clk),
    .num_in_0(4),
    .num_in_1(5),
    .num_in_2(6),
    .num_in_3(7),
    .num_out(num_out),
    .index(index)
    );

initial begin
    forever #100 scan_clk = !scan_clk;
end

endmodule
