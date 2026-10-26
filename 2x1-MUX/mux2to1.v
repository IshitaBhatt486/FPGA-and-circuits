module mux2to1(
        input a,
        input b,
        input sel,
        output y
    );
    wire sel_n, t1, t2;
    not (sel_n, sel); // invert select line
    and (t1, a, sel_n);
    and (t2, b, sel);
    or (y, t1, t2);
endmodule