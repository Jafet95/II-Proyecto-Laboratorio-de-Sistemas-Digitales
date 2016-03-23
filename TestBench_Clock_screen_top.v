`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   16:25:37 03/22/2016
// Design Name:   Clock_screen_top
// Module Name:   C:/Users/Jafet/Documents/Proyectos Dis.Sist.Digitales/II_Proyecto_Laboratorio_Sistemas_Digitales/Archivos .v/II-Proyecto-Laboratorio-de-Sistemas-Digitales/TestBench_Clock_screen_top.v
// Project Name:  II_Proyecto_Laboratorio_Sistemas_Digitales
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Clock_screen_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestBench_Clock_screen_top;

	// Inputs
	reg clk;
	reg reset;

	// Outputs
	wire hsync;
	wire vsync;
	wire [11:0] RGB;

	// Instantiate the Unit Under Test (UUT)
	Clock_screen_top uut (
		.clk(clk), 
		.reset(reset), 
		.hsync(hsync), 
		.vsync(vsync), 
		.RGB(RGB),
		.pixel_tick(pixel_tick)
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
	
initial begin
$timeformat(-5,1,"ns",4);
$display("hsync vsync RGB[0] RGB[1] RGB[2] RGB[3] RGB[4] RGB[5] RGB[6] RGB[7] RGB[8] RGB[9] RGB[10] RGB[11]");
$monitor("%t: %b %b %b %b %b %b %b %b %b %b %b %b %b %b", $realtime,
hsync, vsync, RGB[0],RGB[1],RGB[2],RGB[3],RGB[4],RGB[5],RGB[6],RGB[7],RGB[8],RGB[9],RGB[10],RGB[11]);
end
      
endmodule

