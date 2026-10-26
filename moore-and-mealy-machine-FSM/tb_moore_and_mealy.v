`timescale 1ns / 1ps
module tb_seq_detect;
    reg clk = 0, rst = 1, en = 0, x = 0;
    wire z, y; // Mealy and Moore outputs
    wire [1:0] s_mealy;
    wire [2:0] s_moore;
    reg [3:0] hist = 0; // golden model: the last 4 accepted bits
    reg exp_z, exp_y;
    integer i, errors = 0, found_z = 0, found_y = 0;

    reg [19:0] seq = 20'b1011_0110_0101_1010_1110; // contains 1011 four times (two
    overlap)

    seq_mealy mealy (.clk(clk), .rst(rst), .en(en), .x(x), .z(z), .state_out(s_mealy));
    seq_moore moore (.clk(clk), .rst(rst), .en(en), .x(x), .y(y), .state_out(s_moore));

    always #4 clk = ~clk; // 125 MHz

    always @(posedge clk)
        if (rst) hist <= 0;
        else if (en) hist <= {hist[2:0], x};

    task check;
        begin
            exp_z = ({hist[2:0], x} == 4'b1011);
            exp_y = (hist == 4'b1011);
            if (z !== exp_z || y !== exp_y) begin
                $display("FAIL at %0d ns: x=%b z=%b (exp %b) y=%b (exp %b)",
                $time, x, z, exp_z, y, exp_y);
                errors = errors + 1;
            end
        end
    endtask

    initial begin
        repeat (2) @(negedge clk);
        rst = 0; en = 1;

        for (i = 19; i >= 0; i = i - 1) begin
            @(negedge clk);
            x = seq[i]; // new bit, half a cycle before the rising edge
            #1 check;
            if (z) found_z = found_z + 1;
            if (y) found_y = found_y + 1;
        end

        @(negedge clk) en = 0; x = 1; // hold: no step, states must not change
        #1 check;
        repeat (3) @(negedge clk);
        #1 check;
        @(negedge clk) #1 check;

        $display("Detections: Mealy %0d, Moore %0d (expected 4 and 4)", found_z, found_y);
        if (errors == 0) $display("*** ALL CHECKS PASSED ***");
        else $display("*** %0d CHECKS FAILED ***", errors);
        $finish;
    end
endmodule