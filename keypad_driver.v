module keypad_driver(
    input scan_clk,
    input row_1, row_2, row_3, row_4,
    output col_1, col_2, col_3, col_4,
    output reg keydown,
    output reg [3:0] key
    );

reg [3:0] col = 0, row = 0;     // preserve enough bits for arithmetic operations
reg [3:0] active_row, active_col;

two_four_decoder decoder (
    .in(col),
    .out_0(col_1), .out_1(col_2), .out_2(col_3), .out_3(col_4)
    );

wire [3:0] rows;
assign rows = {row_4, row_3, row_2, row_1};

always @ (posedge scan_clk) begin

    if (!keydown) begin
        for (row = 0; row < 4; row = row + 1) begin
            if (!rows[row]) begin
                keydown = 1;
                active_row = row;
                active_col = col;
                key = (row << 2) + col;
            end
        end
    end

    else begin
        if (col == active_col && rows[active_row]) keydown = 0;
    end

    col = (col + 1) % 4;

end

endmodule
