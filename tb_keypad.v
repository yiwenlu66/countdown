`timescale 10ns / 1ps

module tb_keypad;

/* naming rule: key_row_column_name */
reg key_0_0_1 = 0, key_0_1_2 = 0, key_0_2_3 = 0, key_0_3_A = 0;
reg key_1_0_4 = 0, key_1_1_5 = 0, key_1_2_6 = 0, key_1_3_B = 0;
reg key_2_0_7 = 0, key_2_1_8 = 0, key_2_2_9 = 0, key_2_3_C = 0;
reg key_3_0_0 = 0, key_3_1_F = 0, key_3_2_E = 0, key_3_3_D = 0;

reg clk = 0;
reg row_0, row_1, row_2, row_3;
wire col_0, col_1, col_2, col_3;
wire keydown_start, keydown_confirm, keydown_clear, keydown_num;
wire [3:0] num;

keypad keypad1 (
    .clk(clk),
    .row_1(row_0), .row_2(row_1), .row_3(row_2), .row_4(row_3),
    .col_1(col_0), .col_2(col_1), .col_3(col_2), .col_4(col_3),
    .keydown_start(keydown_start), .keydown_clear(keydown_clear),
    .keydown_confirm(keydown_confirm), .keydown_num(keydown_num),
    .num(num)
    );

always @ (col_0, col_1, col_2, col_3) begin
    if (!col_0) begin
        row_0 = !key_0_0_1;
        row_1 = !key_1_0_4;
        row_2 = !key_2_0_7;
        row_3 = !key_3_0_0;
    end else if (!col_1) begin
        row_0 = !key_0_1_2;
        row_1 = !key_1_1_5;
        row_2 = !key_2_1_8;
        row_3 = !key_3_1_F;
    end else if (!col_2) begin
        row_0 = !key_0_2_3;
        row_1 = !key_1_2_6;
        row_2 = !key_2_2_9;
        row_3 = !key_3_2_E;
    end else begin
        row_0 = !key_0_3_A;
        row_1 = !key_1_3_B;
        row_2 = !key_2_3_C;
        row_3 = !key_3_3_D;
    end
end

initial begin
    forever #50 clk = !clk;
end

initial begin

    // click key '6'
    #120 key_1_2_6 = 1;
    #1000 key_1_2_6 = 0;

    // click key '8', with bouncing
    #500 key_2_1_8 = 1;
    #1 key_2_1_8 = 0;
    #1 key_2_1_8 = 1;
    #1 key_2_1_8 = 0;
    #1 key_2_1_8 = 1;
    #1 key_2_1_8 = 0;
    #1 key_2_1_8 = 1;
    #1 key_2_1_8 = 0;
    #1 key_2_1_8 = 1;
    #1000 key_2_1_8 = 0;
    #1 key_2_1_8 = 1;
    #1 key_2_1_8 = 0;
    #1 key_2_1_8 = 1;
    #1 key_2_1_8 = 0;
    #1 key_2_1_8 = 1;
    #1 key_2_1_8 = 0;

    // long press key 'F' (start)
    #500 key_3_1_F = 1;
    #5000 key_3_1_F = 0;

end

endmodule
