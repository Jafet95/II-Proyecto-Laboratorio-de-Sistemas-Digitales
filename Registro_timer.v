`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:30:48 04/12/2016 
// Design Name: 
// Module Name:    Registro_timer 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Registro_timer(
		input wire hold,
		input wire [7:0]in_rtc_dato,
		input wire [7:0]in_count_dato,
		input wire clk, //system clock
		input wire reset, //system reset
		input wire chip_select, //Control data
		output wire [7:0]out_dato_vga,
		output wire [7:0]out_dato_rtc
    );

reg [7:0]reg_dato;
reg [7:0]next_dato;
//reg [7:0]dato_temp;

//Secuencial
always@(negedge clk, posedge reset)
begin
	if(reset) reg_dato <= 0;
	else reg_dato <= next_dato;
end

//Combinacional
always@*
	begin
	if (~hold) begin
	case(chip_select)
	1'b0: next_dato = in_rtc_dato;
	1'b1: next_dato = in_count_dato;
	endcase
	end
	else next_dato = reg_dato;
	end

/////////////////////////////////////////////////

assign out_dato_vga = reg_dato;
assign out_dato_rtc = 8'h00;

endmodule