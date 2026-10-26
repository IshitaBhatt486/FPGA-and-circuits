`timescale 1ns / 1ps
module full_adder(
        input a,
        input b,
        input cin,
        output sum,
        output cout
    );
    assign sum = a ^ b ^ cin; // 1 when an odd number of inputs are 1
    assign cout = (a & b) | (a & cin) | (b & cin); // 1 when two or more inputs are 1
endmodule