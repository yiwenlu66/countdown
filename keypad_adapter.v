/*
 * Keypad layout: name[function](id)
 * 0(13)            7(9)    4(5)    1(1)
 * F[start](14)     8(10)   5(6)    2(2)
 * E[clear](15)     9(11)   6(7)    3(3)
 * D[confirm](12)   C(8)    B(4)    A(0)
 */

module keypad_adapter(
    input keydown,
    input [3:0] key_id,
    output reg keydown_start, keydown_confirm, keydown_clear, keydown_num,
    output reg [3:0] num
    );

always @ * begin

    case (key_id)
        1: num = 1;
        2: num = 2;
        3: num = 3;
        5: num = 4;
        6: num = 5;
        7: num = 6;
        9: num = 7;
        10: num = 8;
        11: num = 9;
        13: num = 0;
        default: num = 10;  // invalid
    endcase

    keydown_start = (keydown && key_id == 14);
    keydown_confirm = (keydown && key_id == 12);
    keydown_clear = (keydown && key_id == 15);
    keydown_num = (keydown && num != 10);
    
end

endmodule
