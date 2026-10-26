`timescale 1ns / 1ps
module counter_top #(
            parameter SLOW_DIV = 62_500_000, // 125 MHz / 62.5 M = 2 counts per second
            parameter FAST_DIV = 12_500_000 // 125 MHz / 12.5 M = 10 counts per second
        )(
        input clk, // 125 MHz clock
        input [1:0] sw, // sw[0] : 1 = up, 0 = down sw[1] : 1 = fast
        input [1:0] btn, // btn[0]: reset btn[1]: pause
        output [3:0] led, // the count, LD3..LD0
        output led4_g, // LD4 green : count is about to wrap around
        output led5_b, // LD5 blue : counting up
        output led5_r // LD5 red : counting down
    );
    
    wire tick_slow, tick_fast, en;
    tick_gen #(.DIV(SLOW_DIV)) slow (.clk(clk), .tick(tick_slow));
    tick_gen #(.DIV(FAST_DIV)) fast (.clk(clk), .tick(tick_fast));
    assign en = (sw[1] ? tick_fast : tick_slow) & ~btn[1];

    updown_counter #(.N(4)) counter (
        .clk(clk), .rst(btn[0]), .en(en), .up(sw[0]), .q(led)
    );

    assign led4_g = sw[0] ? (led == 4'd15) : (led == 4'd0);
    assign led5_b = sw[0];
    assign led5_r = ~sw[0];
endmodule