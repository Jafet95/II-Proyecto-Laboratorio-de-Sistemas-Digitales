`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   13:08:36 03/21/2016
// Design Name:   timing_generator_VGA
// Module Name:   C:/Users/Jafet/Documents/Proyectos Dis.Sist.Digitales/II_Proyecto_Laboratorio_Sistemas_Digitales/Archivos .v/II-Proyecto-Laboratorio-de-Sistemas-Digitales/TestBench_timing_generator_VGA.v
// Project Name:  II_Proyecto_Laboratorio_Sistemas_Digitales
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: timing_generator_VGA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestBench_timing_generator_VGA;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire hsync;
	wire vsync;
	wire video_on;
	wire p_tick;
	wire [9:0] pixel_x;
	wire [9:0] pixel_y;

	// Instantiate the Unit Under Test (UUT)
	timing_generator_VGA uut (
		.clk(clk), 
		.reset(reset), 
		.hsync(hsync), 
		.vsync(vsync), 
		.video_on(video_on), 
		.p_tick(p_tick), 
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y)
	);
	
	//Para generar clock de 100 MHz
	initial begin
	clk = 0;
	forever #5 clk = ~clk;
	end

	initial 
	
	begin
		// Initialize Inputs
		reset = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		
		reset = 0;
		
		#50000000$stop;	
		
	end
      
endmodule

