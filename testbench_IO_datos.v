`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:36:03 04/13/2016
// Design Name:   logica_para_Escribir_Leer_Mux
// Module Name:   C:/Users/Jafet/Documents/Proyectos Dis.Sist.Digitales/II_Proyecto_Laboratorio_Sistemas_Digitales/Archivos .v/II-Proyecto-Laboratorio-de-Sistemas-Digitales/testbench_IO_datos.v
// Project Name:  II_Proyecto_Laboratorio_Sistemas_Digitales
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: logica_para_Escribir_Leer_Mux
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench_IO_datos;

	// Inputs
	reg clk;
	reg reset;
	reg in_flag_dato;
	reg in_direccion_dato;
	reg [7:0] in_dato_inicio;
	reg in_flag_inicio;
	reg in_wr;
	reg [7:0] in_dato;
	reg [7:0] addr_RAM;
	reg controlador_dato;

	// Outputs
	wire [7:0] out_reg_dato;

	// Bidirs
	wire [7:0] dato;

	// Instantiate the Unit Under Test (UUT)
	logica_para_Escribir_Leer_Mux uut (
		.clk(clk), 
		.reset(reset), 
		.in_flag_dato(in_flag_dato), 
		.in_direccion_dato(in_direccion_dato), 
		.in_dato_inicio(in_dato_inicio), 
		.in_flag_inicio(in_flag_inicio), 
		.in_wr(in_wr), 
		.in_dato(in_dato), 
		.out_reg_dato(out_reg_dato), 
		.addr_RAM(addr_RAM), 
		.dato(dato), 
		.controlador_dato(controlador_dato)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 0;
		in_flag_dato = 0;
		in_direccion_dato = 0;
		in_dato_inicio = 0;
		in_flag_inicio = 0;
		in_wr = 0;
		in_dato = 0;
		addr_RAM = 0;
		controlador_dato = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

