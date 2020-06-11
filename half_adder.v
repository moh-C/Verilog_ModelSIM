module half_adder(output C,S, input x, y);
	xor(S, x, y);
	and(C, x, y);
endmodule