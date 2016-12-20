module clock_divider(
    input clk_in,
    input [26:0] size,
    output reg clk_out = 0
    );

reg [26:0] counter = 0;

always @ (posedge clk_in) begin
    counter = counter + 1;
    if (counter >= size >> 1) begin
        clk_out = !clk_out;
        counter = 0;
    end
end

endmodule
