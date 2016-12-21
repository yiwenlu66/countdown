`timescale 1ns / 1ps

module tb_decimal_splitter;

reg [6:0] dec;
wire [3:0] tens, units;

decimal_splitter d (
    .dec(dec),
    .tens(tens),
    .units(units)
    );

initial begin
    dec = 25;
    #100 dec = 56;
    #100 dec = 83;
end

endmodule
