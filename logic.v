module logic(
    input clk,      // high frequency clock
    input tick,     // period: 1s
    input keydown_num, keydown_start, keydown_clear, keydown_confirm,   // only one key is allowed at a time
    input [3:0] num,
    output reg display = 0,
    output reg [4:0] input_val,     // max: 20
    output reg [5:0] remaining     // count down from 2*input_val
    );

parameter INITIAL = 0, INPUT_0 = 1, INPUT_1 = 2, INPUT_2 = 3, COUNTDOWN = 4;

reg [2:0] state = INITIAL;
reg [3:0] inactive_time = 0;    // max: 10

reg tick_prev = 0;
reg keydown_num_prev = 0, keydown_start_prev = 0, keydown_clear_prev = 0, keydown_confirm_prev = 0;

always @ (posedge clk) begin

    if (tick && !tick_prev) begin
        if (state == COUNTDOWN) begin
            remaining = remaining - 1;
            if (remaining == 0) begin
                state = INPUT_0;
                input_val = 0;
            end
        end else begin
            inactive_time = inactive_time + 1;
            if (inactive_time == 10) begin
                state = INITIAL;
                display = 0;
            end
        end
    end

    if (keydown_start && !keydown_start_prev) begin
        inactive_time = 0;
        if (state == INITIAL) begin
            state = INPUT_0;
            display = 1;
            input_val = 0;
            remaining = 0;
        end
    end

    if (keydown_clear && !keydown_clear_prev) begin
        inactive_time = 0;
        if (state == INPUT_1 || state == INPUT_2) begin
            state = INPUT_0;
            input_val = 0;
            remaining = 0;
        end
    end

    if (keydown_num && !keydown_num_prev) begin
        inactive_time = 0;
        if (state == INPUT_0) begin
            if (num != 0) begin
                state = INPUT_1;
                input_val = num;
            end
        end else if (state == INPUT_1) begin
            state = INPUT_2;
            if (input_val == 1) input_val = 10 + num;
            else input_val = 20;
        end
        remaining = input_val << 1;
    end

    if (keydown_confirm && !keydown_confirm_prev) begin
        inactive_time = 0;
        if (state == INPUT_1 || state == INPUT_2) state = COUNTDOWN;
    end

    tick_prev = tick;
    keydown_clear_prev = keydown_clear;
    keydown_confirm_prev = keydown_confirm;
    keydown_start_prev = keydown_start;
    keydown_num_prev = keydown_num;

end


endmodule
