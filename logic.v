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

/*
 * Signals are assigned by key/tick block;
 * slots are assigned by clk block;
 * operations are done only when signal differs from slot.
 */
reg signal_tick = 0, slot_tick = 0;
reg signal_num = 0, slot_num = 0;
reg signal_start = 0, slot_start = 0;
reg signal_clear = 0, slot_clear = 0;
reg signal_confirm = 0, slot_confirm = 0;

always @ (posedge clk) begin

    if (slot_tick != signal_tick) begin
        slot_tick = signal_tick;
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

    if (slot_start != signal_start) begin
        slot_start = signal_start; 
        inactive_time = 0;
        if (state == INITIAL) begin
            state = INPUT_0;
            display = 1;
            input_val = 0;
            remaining = 0;
        end
    end

    if (slot_clear != signal_clear) begin
        slot_clear = signal_clear;
        inactive_time = 0;
        if (state == INPUT_1 || state == INPUT_2) begin
            state = INPUT_0;
            input_val = 0;
            remaining = 0;
        end
    end

    if (slot_num != signal_num) begin
        slot_num = signal_num; 
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

    if (slot_confirm != signal_confirm) begin
        slot_confirm = signal_confirm;
        inactive_time = 0;
        if (state == INPUT_1 || state == INPUT_2) state = COUNTDOWN;
    end

end


always @ (posedge keydown_start) begin
    signal_start = !slot_start;
end

always @ (posedge keydown_confirm) begin
    signal_confirm = !slot_confirm;
end

always @ (posedge keydown_clear) begin
    signal_clear = !slot_clear;
end

always @ (posedge keydown_num) begin
    signal_num = !slot_num;
end

always @ (posedge tick) begin
    signal_tick = !slot_tick;
end

endmodule
