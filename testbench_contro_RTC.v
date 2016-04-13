`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:19:19 04/12/2016
// Design Name:   Contol_RTC
// Module Name:   D:/ISE/MemoRAM/testbench_contro_RTC.v
// Project Name:  MemoRAM
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Contol_RTC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module testbench_contro_RTC;

	// Inputs
	reg clk;
	reg reset;
	reg sw1;
	reg sw2;
	reg enUP;
	reg enDOWN;
	reg enRIGHT;
	reg enLEFT;
	reg desactivar_alarma;
	reg formato_hora;

	// Outputs
	wire a_d;
	wire cs;
	wire rd;
	wire wr;
	wire [7:0] out_seg_hora;
	wire [7:0] out_min_hora;
	wire [7:0] out_hora_hora;
	wire [7:0] out_dia_fecha;
	wire [7:0] out_mes_fecha;
	wire [7:0] out_jahr_fecha;
	wire [7:0] out_dia_semana;
	wire [7:0] out_seg_timer;
	wire [7:0] out_min_timer;
	wire [7:0] out_hora_timer;
	wire estado_alarma;
	wire [1:0] cursor_location;
	wire AM_PM;

	// Bidirs
	wire [7:0] dato;

	// Instantiate the Unit Under Test (UUT)
	Contol_RTC uut (
		.clk(clk), 
		.reset(reset), 
		.sw1(sw1), 
		.sw2(sw2), 
		.enUP(enUP), 
		.enDOWN(enDOWN), 
		.enRIGHT(enRIGHT), 
		.enLEFT(enLEFT), 
		.desactivar_alarma(desactivar_alarma), 
		.formato_hora(formato_hora), 
		.dato(dato), 
		.a_d(a_d), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.out_seg_hora(out_seg_hora), 
		.out_min_hora(out_min_hora), 
		.out_hora_hora(out_hora_hora), 
		.out_dia_fecha(out_dia_fecha), 
		.out_mes_fecha(out_mes_fecha), 
		.out_jahr_fecha(out_jahr_fecha), 
		.out_dia_semana(out_dia_semana), 
		.out_seg_timer(out_seg_timer), 
		.out_min_timer(out_min_timer), 
		.out_hora_timer(out_hora_timer), 
		.estado_alarma(estado_alarma), 
		.cursor_location(cursor_location), 
		.AM_PM(AM_PM)
	);
always #10 clk = ~clk;
	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		sw1 = 0;
		sw2 = 0;
		enUP = 0;
		enDOWN = 0;
		enRIGHT = 0;
		enLEFT = 0;
		desactivar_alarma = 0;
		formato_hora = 0;

		// Wait 100 ns for global reset to finish
		#10 reset = 0;
		//#40 dato = 8'd12;
		#5000 sw2 = 1;
		#2000 sw2 = 0;
		#1000000 $stop;
        
		// Add stimulus here

	end
      
endmodule

