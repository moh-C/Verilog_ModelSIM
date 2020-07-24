module (input A, input [1:0] Sel, output W, X, Y, Z);
    assign W = A & (~Sel[0]) & (~Sel[1]);
    assign X = A & (~Sel[0]) & (Sel[1]);
    assign Y = A & Sel[0] & (~Sel[1]);
    assign Z = A & Sel[0] & Sel[1];
endmodule