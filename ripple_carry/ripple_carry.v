`timescale 1ns / 1ps
module ripple_carry(X,Y,S,Co,clk);
	input [3:0] X, Y; // Two 4-bit inputs
	input clk;
	output [3:0]S;
	output Co;
	wire w1, w2, w3, Co1;
	wire [3:0] X1, Y1, S1;
	// Input Register //

	DFlipFlop XFF(X,clk,X1);
	DFlipFlop YFF(Y,clk,Y1);

	// Instantiating 4 1-bit full adders in verilog
	fulladder u1(X1[0], Y1[0], 1'b0, S1[0], w1);
	fulladder u2(X1[1], Y1[1], w1, S1[1], w2);
	fulladder u3(X1[2], Y1[2], w2, S1[2], w3);
	fulladder u4(X1[3], Y1[3], w3, S1[3], Co1);

	DFlipFlop SFF(S1,clk,S);
	DFlipFlop1b CFF(Co1,clk,Co);
endmodule

`timescale 1ns / 1ps
module fulladder(X,Y,Ci,S,Co);
	input X, Y, Ci;
	output S, Co;  
	wire w1, w2, w3;
	// structural code for one bit full adder
	xor G1(w1, X, Y);
	xor G2(S, w1, Ci);
	and G3(w2, w1, Ci);
	and G4(w3, X, Y);
	or G5(Co, w2, w3);
endmodule

`timescale 1ns / 1ps
module DFlipFlop(D, clk, Q);
	input [3:0] D; // Data Input
	input clk; // clock input
	output reg [3:0] Q; // Output Q
	always @(posedge clk)
	begin
	  	Q <= D;
	end
endmodule

`timescale 1ns / 1ps
module DFlipFlop1b(D, clk, Q);
	input D;
	input clk;
	output reg Q;  // output Q
	always @(posedge clk)
	begin
		Q <= D;
	end
endmodule


