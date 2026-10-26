`timescale 1ns / 1ps
module adder2(
        input [1:0] a, // SW1, SW0
        input [1:0] b, // BTN1, BTN0
        input cin, // BTN2
        output [1:0] sum, // LD1, LD0
        output cout, // LD2
        output equal // LD3 : on when A equals B
    );
    wire c1; // carry from bit 0 to bit 1
    full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c1));
    full_adder fa1 (.a(a[1]), .b(b[1]), .cin(c1), .sum(sum[1]), .cout(cout));
    assign equal = (a == b);
endmodule