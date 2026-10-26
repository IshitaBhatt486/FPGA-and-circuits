// Moore sequence detector for the pattern 1011 (overlapping).

`timescale 1ns / 1ps
module seq_moore(
        input clk,
        input rst, // synchronous reset
        input en, // take one step (one input bit) when en = 1
        input x, // the input bit
        output y, // 1 while in state S4 (1011 has just been seen)
        output [2:0] state_out // present state, for the LEDs
    );

    localparam S0 = 3'd0, // nothing useful seen yet
    S1 = 3'd1, // seen ...1
    S2 = 3'd2, // seen ...10
    S3 = 3'd3, // seen ...101
    S4 = 3'd4; // seen ...1011 -> output 1
    reg [2:0] state = S0; // present state (flip-flops)
    reg [2:0] next; // next state (combinational)

    //State Register
    always @(posedge clk) begin
        if (rst)
            state <= S0;
        else if (en)
            state <= next;
    end

    // Next-state logic
    always @(*) begin
        case (state)
            S0: next = x ? S1 : S0;
            S1: next = x ? S1 : S2;
            S2: next = x ? S3 : S0;
            S3: next = x ? S4 : S2;
            S4: next = x ? S1 : S2;
            default: next = S0;
        endcase
    end

    // Output logic
    assign y = (state == S4);
    assign state_out = state;
    
endmodule