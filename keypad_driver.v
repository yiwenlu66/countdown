module keypad_driver(
    input scan_clk,
    input row_1, row_2, row_3, row_4,
    output col_1, col_2, col_3, col_4,
    output reg keydown
    );

reg [1:0] col = 0;

two_four_decoder decoder (
    .in(col),
    .out_0(col_1), .out_1(col_2), .out_2(col_3), .out_3(col_4)
    );

always @ (posedge scan_clk) begin
    col = col + 1;
    if (!row_1 || !row_2 || !row_3 || !row_4) keydown = 1;
    else keydown = 0;
end

endmodule
