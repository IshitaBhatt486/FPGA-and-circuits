`timescale 1ns / 1ps
module tb_full_adder;
    reg a, b, cin;
    wire sum, cout;
    reg [1:0] expected; // the correct answer, worked out by the testbench
    integer i;
    integer errors = 0;

    full_adder dut (
        .a(a), .b(b), .cin(cin),
        .sum(sum), .cout(cout)
    );
    initial begin
        $display(" a b cin | cout sum | result");
        for (i = 0; i < 8; i = i + 1) begin
            {a, b, cin} = i; // apply input combination number i
            #10; // wait 10 ns for the outputs to settle
            expected = a + b + cin; // correct 2-bit answer
            if ({cout, sum} === expected)
                b %b | %b %b | PASS", a, b, cin, cout, sum);
            else begin
                $display(" %b %b %b | %b %b | FAIL (expected %b %b)",
            a, b, cin, cout, sum, expected[1], expected[0]);
            errors = errors + 1;
            end
        end
        if (errors == 0)
            $display("*** ALL 8 TESTS PASSED ***");
        else
            $display("*** %0d TEST(S) FAILED ***", errors);
        $finish;
    end
endmodule