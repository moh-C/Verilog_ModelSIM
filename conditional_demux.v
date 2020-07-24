module (input A, input [1:0] Sel, output W, X, Y, Z);
    assign W = Sel[0] ? 0 : (Sel[1] ? 0 : A);
    assign X = Sel[0] ? 0 : (Sel[1] ? A : 0);
    assign Y = Sel[0] ? (Sel[1] ? 0 : A) : 0;
    assign Z = Sel[0] ? (Sel[1] ? A : 0) : 0;
endmodule