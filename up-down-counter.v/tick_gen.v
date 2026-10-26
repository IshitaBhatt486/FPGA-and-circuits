`timescale 1ns / 1ps
module tick_gen #(
            parameter DIV = 62_500_000 // one tick every DIV clock cycles
        )(
        input clk,
        output reg tick = 0 // 1 for exactly one clock cycle
    );
    reg [$clog2(DIV)-1:0] cnt = 0;
    always @(posedge clk) begin
        if (cnt == DIV - 1) begin
            cnt <= 0;
            tick <= 1;
        end else begin
            cnt <= cnt + 1;
            tick <= 0;
        end
    end
endmodule