`timescale 1ns/1ps
module Adder4bit_tb();
	// Inputs
	reg [3:0] A;
	reg [3:0] B;
	reg Cin;
	reg clk;
	// Outputs
	wire [3:0] Sum;
	wire Cout;
	// UUT instantiation
	ripple_carry uut(.X(A), .Y(B), .S(Sum), .Co(Co), .clk(clk));
	
	initial begin
		// Initialize i/p
		A = 4'b0000;
		B = 4'b0000;
		// Cin = 4'b0;
		// Wait 100ns for global reset to finish
		#100;
		// Add stimulus here
		A = 4'b1011;
		B = 4'b0100;
		//Cin = 4'b0;
		#20;
		A = 4'b1111;
		B = 4'b1101;
		// Cin = 4'b1;
	end


	initial begin
		clk = 0;
		forever #10 clk = ~clk;
	end

endmodule

