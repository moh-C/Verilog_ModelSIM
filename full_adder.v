module full_adder(output C, S, input x, y, Cin);
	assign {C, S} = x + y + Cin;
endmodule