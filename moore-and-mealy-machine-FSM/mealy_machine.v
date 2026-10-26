`timescale 1ns / 1ps
// Mealy sequence detector for the pattern 1011 (overlapping).

module seq_mealy(
        input clk,
        input rst, // synchronous reset
        input en, // take one step (one input bit) when en = 1
        input x, // the input bit
        output z, // 1 when the bit now on x completes 1011
        output [1:0] state_out // present state, for the LEDs
    );

    localparam S0 = 2'd0, // nothing useful seen yet
    S1 = 2'd1, // seen ...1
    S2 = 2'd2, // seen ...10
    S3 = 2'd3; // seen ...101
    reg [1:0] state = S0;
    reg [1:0] next;

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
            S3: next = x ? S1 : S2; // after 1011, the last 1 can start a new pattern
            default: next = S0;
        endcase
    end

    // Output logic
    assign z = (state == S3) && x;
    assign state_out = state;
    
endmodule