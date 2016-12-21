/*
 * Scan through the numbers with the given clock;
 * output a number with its index at a time.
 */

module scan_display(
    input scan_clk,          // recommended: ~250Hz
    input [3:0] num_in_0, num_in_1, num_in_2, num_in_3,
    output reg [3:0] num_out,
    output reg [1:0] index = 0
    );

always @ (posedge scan_clk) begin
    index = index + 1;
    case (index)
        0: num_out = num_in_0;
        1: num_out = num_in_1;
        2: num_out = num_in_2;
        3: num_out = num_in_3;
    endcase
end

endmodule