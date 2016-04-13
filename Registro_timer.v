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
		input wire estado_alarma,
		input wire btn_desactivar,
		output wire [7:0]out_dato_vga,
		output wire [7:0]out_dato_rtc,
		output wire flag_out
    );
reg flag_out_reg;
reg flag_out_next;
reg [7:0]reg_dato;
reg [7:0]next_dato;
reg [7:0]dato_temp;

//Secuencial
always@(negedge clk, posedge reset)
begin
	if(reset) reg_dato <= 0;
	else reg_dato <= next_dato;
end

//Combinacional
always@*
	begin
	dato_temp = in_count_dato;
	if (~hold) begin
	case(chip_select)
	1'b0: next_dato = in_rtc_dato;
	1'b1: next_dato = in_count_dato;
	endcase
	end
	else next_dato = reg_dato;
	end
	
///////// hold del flag	/////////////////////

assign flag_timer_up = (reg_dato == dato_temp)? 1'b1:1'b0;
assign flag_out = flag_out_reg;
 
always@(posedge clk, posedge reset)
begin
	if(reset) flag_out_reg <= 1'b0;
	else flag_out_reg <= flag_out_next;
end

always@* begin
 if(flag_timer_up) flag_out_next = 1'b1;
 else if (btn_desactivar) flag_out_next = 1'b0;
 else flag_out_next = flag_out_reg;
end
/////////////////////////////////////////////////

assign out_dato_vga = (estado_alarma)? dato_temp : reg_dato;
assign out_dato_rtc = 8'h00;
endmodule