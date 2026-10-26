`timescale 1ns / 1ps

module fsm_top #(
            parameter DEB = 1_250_000 // debounce time: 10 ms at 125 MHz
        )(
        input clk, // 125 MHz
        input sw0, // SW0 : the input bit x
        input [1:0] btn, // BTN0 : step BTN1 : reset
        output [3:0] led, // LD0 Mealy z, LD1 Moore y, LD3..LD2 Mealy state
        output led4_r, led4_g, led4_b, // LD4 colour = Moore state
        output led5_b // LD5 blue = present value of x
    );

    wire step;
    wire [1:0] mealy_state;
    wire [2:0] moore_state;
    reg [1:0] rst_sync = 0;

    debounce #(.N(DEB)) db (.clk(clk), .btn(btn[0]), .press(step));

    always @(posedge clk) rst_sync <= {rst_sync[0], btn[1]}; // synchronise reset
    seq_mealy mealy (.clk(clk), .rst(rst_sync[1]), .en(step), .x(sw0),
    .z(led[0]), .state_out(mealy_state));
    seq_moore moore (.clk(clk), .rst(rst_sync[1]), .en(step), .x(sw0),
    .y(led[1]), .state_out(moore_state));
    assign led[3:2] = mealy_state;

    // Moore state colour: S0 off, S1 red, S2 green, S3 blue, S4 white
    assign led4_r = (moore_state == 3'd1) || (moore_state == 3'd4);
    assign led4_g = (moore_state == 3'd2) || (moore_state == 3'd4);
    assign led4_b = (moore_state == 3'd3) || (moore_state == 3'd4);
    assign led5_b = sw0;
    
endmodule