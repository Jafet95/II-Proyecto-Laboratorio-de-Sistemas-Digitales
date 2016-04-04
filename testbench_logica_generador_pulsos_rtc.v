`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:00:27 04/03/2016
// Design Name:   logica_generador_pulsos_RTC
// Module Name:   D:/ISE/MemoRAM/testbench_logica_generador_pulsos_rtc.v
// Project Name:  MemoRAM
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: logica_generador_pulsos_RTC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench_logica_generador_pulsos_rtc;

	// Inputs
	reg clk;
	reg rst;
	reg [1:0] funcion;
	reg [7:0] cuenta;

	// Outputs
	wire a_d_out;
	wire cs_out;
	wire wr_out;
	wire rd_out;
	wire [3:0] addr_logica_escribir_leer_out;
	wire [7:0] addr_RAM_out;
	wire funcion_r_w_out;

	// Instantiate the Unit Under Test (UUT)
	logica_generador_pulsos_RTC uut (
		.clk(clk), 
		.rst(rst), 
		.funcion(funcion), 
		.cuenta(cuenta), 
		.a_d_out(a_d_out), 
		.cs_out(cs_out), 
		.wr_out(wr_out), 
		.rd_out(rd_out), 
		.addr_logica_escribir_leer_out(addr_logica_escribir_leer_out), 
		.addr_RAM_out(addr_RAM_out), 
		.funcion_r_w_out(funcion_r_w_out)
	);
	
	always #10 clk = ~clk;
	
	
	
	always@(negedge clk) begin
	if (cuenta == 255 || rst) begin
		cuenta = 0;
		 $finish;
		end
	else cuenta = cuenta + 1;
	end
	
	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		funcion = 0;
		cuenta = 0;

		// Wait 100 ns for global reset to finish
		#10;
		rst=1;  
		#10;
		rst=0;
		funcion = 2'b00;
     
		// Add stimulus here

	end
      
endmodule

