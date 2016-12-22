module keypad(
    input clk,
    input row_1, row_2, row_3, row_4,
    output col_1, col_2, col_3, col_4,
    output keydown_start, keydown_confirm, keydown_clear, keydown_num,
    output [3:0] num
    );

wire keydown;
wire [3:0] key_id;

keypad_driver keypad__keypad_driver (
    .scan_clk(clk),
    .row_1(row_1), .row_2(row_2), .row_3(row_3), .row_4(row_4),
    .col_1(col_1), .col_2(col_2), .col_3(col_3), .col_4(col_4),
    .keydown(keydown), .key(key_id)
    );

keypad_adapter keypad__keypad_adapter (
    .clk(clk),
    .keydown(keydown), .key_id(key_id),
    .keydown_start(keydown_start), .keydown_confirm(keydown_confirm),
    .keydown_clear(keydown_clear), .keydown_num(keydown_num),
    .num(num)
    );

endmodule
