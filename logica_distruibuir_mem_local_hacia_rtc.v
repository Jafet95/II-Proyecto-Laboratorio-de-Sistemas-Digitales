`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:43:45 04/11/2016 
// Design Name: 
// Module Name:    logica_distruibuir_mem_local_hacia_rtc 
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
module logica_distruibuir_mem_local_hacia_rtc(
	input reg_wr,
	input [3:0]in_addr_mem_local,
	input [7:0]in_seg_hora,
	input [7:0]in_min_hora,
	input [7:0]in_hora_hora,
	input [7:0]in_dia_fecha,
	input [7:0]in_mes_fecha,
	input [7:0]in_jahr_fecha,
	input [7:0]in_dia_semana,
	input [7:0]in_seg_timer,
	input [7:0]in_min_timer,
	input [7:0]in_hora_timer,
	output wire [7:0]out_dato_para_rtc
    );
reg [7:0]out_dato;
assign out_dato_para_rtc = out_dato;


always @* begin
	if (~reg_wr) begin
	case (in_addr_mem_local)
		4'd0: out_dato = in_seg_hora;
		4'd1: out_dato = in_min_hora;
		4'd2: out_dato = in_hora_hora;
		4'd3: out_dato = in_dia_fecha;
		4'd4: out_dato = in_mes_fecha;
		4'd5: out_dato = in_jahr_fecha;
		4'd6: out_dato = in_dia_semana;
		4'd7: out_dato = in_seg_timer;
		4'd8: out_dato = in_min_timer;
		4'd9: out_dato = in_hora_timer;
		default out_dato = 8'd0; 
		endcase
		end
		else out_dato = 8'd0;
end


endmodule
