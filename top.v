module top(
    input clk,  // 100MHz
    input keypad_row_1, keypad_row_2, keypad_row_3, keypad_row_4,
    output keypad_col_1, keypad_col_2, keypad_col_3, keypad_col_4,
    output display_a, display_b, display_c, display_d, display_e, display_f, display_g,
    output display_an_0, display_an_1, display_an_2, display_an_3,
    output keydown_start, keydown_confirm, keydown_clear, keydown_num
    );

wire clk_display, clk_keypad, clk_logic, clk_tick;
wire [3:0] num;
wire enable_display;
wire [6:0] amount;
wire [6:0] remaining;
wire [3:0] amount_tens;
wire [3:0] amount_units;
wire [3:0] remaining_tens;
wire [3:0] remaining_units;

clock_divider divider_display (
    .clk_in(clk),
    .size(400000),
    .clk_out(clk_display)
    );

clock_divider divider_keypad (
    .clk_in(clk),
    .size(100000),
    .clk_out(clk_keypad)
    );

clock_divider divider_logic (
    .clk_in(clk),
    .size(100),
    .clk_out(clk_logic)
    );

clock_divider divider_tick (
    .clk_in(clk),
    .size(100000000),
    .clk_out(clk_tick)
    );


keypad k (
    .clk(clk_keypad),
    .row_1(keypad_row_1), .row_2(keypad_row_2), .row_3(keypad_row_3), .row_4(keypad_row_4),
    .col_1(keypad_col_1), .col_2(keypad_col_2), .col_3(keypad_col_3), .col_4(keypad_col_4),
    .keydown_start(keydown_start), .keydown_confirm(keydown_confirm),
    .keydown_clear(keydown_clear), .keydown_num(keydown_num),
    .num(num)
    );

logic l (
    .clk(clk_logic),
    .tick(clk_tick),
    .keydown_num(keydown_num), .keydown_start(keydown_start),
    .keydown_clear(keydown_clear), .keydown_confirm(keydown_confirm),
    .num(num),
    .display(enable_display),
    .input_val(amount), .remaining(remaining)
    );

decimal_splitter splitter_amount (
    .dec(amount),
    .tens(amount_tens),
    .units(amount_units)
    );

decimal_splitter splitter_remaining (
    .dec(remaining),
    .tens(remaining_tens),
    .units(remaining_units)
    );

display disp (
    .scan_clk(clk_display),
    .digit_3(amount_tens), .digit_2(amount_units),
    .digit_1(remaining_tens), .digit_0(remaining_units),
    .enable_3(enable_display), .enable_2(enable_display), .enable_1(enable_display), .enable_0(enable_display),
    .a(display_a), .b(display_b), .c(display_c), .d(display_d), .e(display_e), .f(display_f), .g(display_g),
    .an_0(display_an_0), .an_1(display_an_1), .an_2(display_an_2), .an_3(display_an_3)
    );

endmodule
