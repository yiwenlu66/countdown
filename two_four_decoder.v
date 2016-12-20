/* ACTIVE LOW */

module two_four_decoder(
    input [1:0] in,
    output out_0, out_1, out_2, out_3
    );

reg [3:0] out;

always @ * begin
    case (in)
        0: out = 4'b1110;
        1: out = 4'b1101;
        2: out = 4'b1011;
        3: out = 4'b0111;
    endcase
end

assign {out_3, out_2, out_1, out_0} = out;

endmodule
