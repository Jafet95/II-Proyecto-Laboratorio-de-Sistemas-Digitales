`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:06:15 04/03/2016
// Design Name:   antirrebote
// Module Name:   C:/Users/Jafet/Documents/Proyectos Dis.Sist.Digitales/II_Proyecto_Laboratorio_Sistemas_Digitales/Archivos .v/II-Proyecto-Laboratorio-de-Sistemas-Digitales/Testbench_antirrebote.v
// Project Name:  II_Proyecto_Laboratorio_Sistemas_Digitales
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: antirrebote
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Testbench_antirrebote;

	// Inputs
	reg clk;
	reg reset;
	reg sw;

	// Outputs
	wire db;

	// Instantiate the Unit Under Test (UUT)
	antirrebote uut (
		.clk(clk), 
		.reset(reset), 
		.sw(sw), 
		.db(db)
	);
	
	//Para generar clock de 100 MHz
	initial begin
	clk = 0;
	forever #5 clk = ~clk;
	end

	initial begin
		// Initialize Inputs
		reset = 0;
		sw = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
	
	reset = 1;
	sw = 0;

	#100

	//Oscilación 0->1 de 4ms de sw (3 veces)
	reset = 0;
	sw = 0;
	
	#2000000
	
	sw = 1;
	
	#2000000
	
	sw = 0;
	
	#2000000
	
	sw = 1;
	
	#2000000
	
	sw = 0;
	
	#2000000
	
	sw = 1;

	#300000000

//Oscilación 1->0 de 4ms de sw (3 veces)
	sw = 1;
	
	#2000000
	
	sw = 0;
	
	#2000000
	
	sw = 1;
	
	#2000000
	
	sw = 0;
	
	#2000000
	
	sw = 1;
	
	#2000000
	
	sw = 0;

	#300000000$stop;

	end
      
endmodule

