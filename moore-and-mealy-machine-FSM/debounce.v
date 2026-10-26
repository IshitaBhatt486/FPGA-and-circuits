`timescale 1ns / 1ps

module debounce #(
            parameter N = 1_250_000 // must stay stable N cycles (10 ms at 125 MHz)
        )(
        input clk,
        input btn, // raw, bouncy button
        output press // one-clock pulse per push
    );

    reg sync0 = 0, sync1 = 0; // 2-flip-flop synchroniser
    reg stable = 0, stable_d = 0;
    reg [$clog2(N)-1:0] cnt = 0;
    always @(posedge clk) begin
        sync0 <= btn;
        sync1 <= sync0;
        if (sync1 != stable) begin
            if (cnt == N - 1) begin
                stable <= sync1;
                cnt <= 0;
            end else
                
        end else
            cnt <= 0;
        stable_d <= stable;
    end
    assign press = stable & ~stable_d;
endmodule