`timescale 1ns / 1ps

module logic(
    input clk_1s,
    input keydown_num, keydown_start, keydown_clear, keydown_confirm,
    input [3:0] num,
    output reg display = 0,
    output reg [4:0] input_val,     // max: 20
    output reg [5:0] remaining      // count down from 2*input_val
    );

parameter INITIAL = 0, INPUT_0 = 1, INPUT_1 = 2, INPUT_2 = 3, COUNTDOWN = 4;

reg [2:0] state = INITIAL;
reg [3:0] inactive_time = 0;    // max: 10

parameter delay = 20;  // time after positive edge of keydown_num to read number

always @ (keydown_start or keydown_clear or keydown_num or keydown_confirm or clk_1s) begin

    #delay;

    if (keydown_start) begin
        inactive_time = 0;
        if (state == INITIAL) begin
            state = INPUT_0;
            display = 1;
            input_val = 0;
            remaining = 0;
        end
    end

    if (keydown_clear) begin
        inactive_time = 0;
        if (state == INPUT_1 || state == INPUT_2) begin
            state = INPUT_0;
            input_val = 0;
            remaining = 0;
        end
    end

    if (keydown_num) begin
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

    if (keydown_confirm) begin
        inactive_time = 0;
        if (state == INPUT_1 || state == INPUT_2) state = COUNTDOWN;
    end

    if (clk_1s) begin
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

end

endmodule
