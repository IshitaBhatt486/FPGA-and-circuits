`timescale 1ns / 1ps
module tb_updown_counter;
    reg clk = 0;
    reg rst = 1, en = 0, up = 1;
    wire [3:0] q;
    integer expected = 0; // golden model of the count
    integer errors = 0;
    integer checks = 0;

    updown_counter #(.N(4)) dut (.clk(clk), .rst(rst), .en(en), .up(up), .q(q));

    always #4 clk = ~clk;

    always @(posedge clk) begin
        if (rst)
            expected <= 0;
        else if (en && up)
            expected <= (expected + 1) % 16;
        else if (en && !up)
            expected <= (expected + 15) % 16;
    end

    // (skip time 0 - no rising edge has happened yet, so q is still unknown)
    always @(negedge clk) if ($time > 0) begin
        checks = checks + 1;
        if (q !== expected) begin
            $display("FAIL at %0d ns: q = %0d, expected %0d", $time, q, expected);
            errors = errors + 1;
        end
    end

    initial begin
        repeat (2) @(negedge clk); // hold reset for 2 cycles
        rst = 0; en = 1; up = 1;
        repeat (20) @(negedge clk); // count up 20 times (wraps 15 -> 0)
        en = 0;
        repeat (3) @(negedge clk); // pause: count must not change
        en = 1; up = 0;
        repeat (20) @(negedge clk); // count down 20 times (wraps 0 -> 15)
        rst = 1;
        repeat (2) @(negedge clk); // reset in the middle of counting
        rst = 0;
        repeat (5) @(negedge clk);
        if (errors == 0)
            $display("*** ALL %0d CHECKS PASSED ***", checks);
        else
            $display("*** %0d OF %0d CHECKS FAILED ***", errors, checks);
        $finish;
    end
endmodule