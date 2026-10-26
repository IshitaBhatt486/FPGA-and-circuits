`timescale 1ns / 1ps
module updown_counter #(
            parameter N = 4 // number of bits
        )(
        input clk, // clock
        input rst, // synchronous reset: q becomes 0
        input en, // count only when en = 1
        input up, // 1 = count up, 0 = count down
        output reg [N-1:0] q // the count
    );
    always @(posedge clk) begin
        if (rst)
            q <= 0;
        else if (en) begin
            if (up)
                q <= q + 1;
            else
            q <= q - 1;
        end
    end
endmodule