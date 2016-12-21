/*
 * Keypad layout: name[function](id)
 * 0         (12)   7(8)    4(4)    1(0)
 * F[start]  (13)   8(9)    5(5)    2(1)
 * E[clear]  (14)   9(10)   6(6)    3(2)
 * D[confirm](15)   C(11)   B(7)    A(3)
 */

module keypad_adapter(
    input clk,
    input keydown,
    input [3:0] key_id,
    output reg keydown_start, keydown_confirm, keydown_clear, keydown_num,
    output reg [3:0] num
    );

always @(posedge clk) begin

    case (key_id)
        0: num = 1;
        1: num = 2;
        2: num = 3;
        4: num = 4;
        5: num = 5;
        6: num = 6;
        8: num = 7;
        9: num = 8;
        10: num = 9;
        12: num = 0;
        default: num = 10;  // invalid
    endcase

    keydown_start <= (keydown && key_id == 13);
    keydown_confirm <= (keydown && key_id == 15);
    keydown_clear <= (keydown && key_id == 14);
    keydown_num <= (keydown && num != 10);
    
end

endmodule
