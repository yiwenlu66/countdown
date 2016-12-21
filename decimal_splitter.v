/*
 * Split a 2-digit decimal number into digits.
 */

module decimal_splitter(
    input [6:0] dec,
    output reg [3:0] tens, units
    );

always @ * begin
    tens = dec / 10;
    units = dec % 10;
end

endmodule
