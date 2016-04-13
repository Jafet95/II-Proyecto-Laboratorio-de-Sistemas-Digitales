`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:43:39 04/11/2016 
// Design Name: 
// Module Name:    logica_distributir_dato_rtc_registros 
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

module logica_distributir_dato_rtc_registros(
	input [3:0]in_addr_mem_local,
	input [7:0]in_dato_rtc,
	output reg[7:0]seg_hora,
	output reg[7:0]min_hora,
	output reg[7:0]hora_hora,
	output reg[7:0]dia_fecha,
	output reg[7:0]mes_fecha,
	output reg[7:0]jahr_fecha,
	output reg[7:0]dia_semana,
	output reg[7:0]seg_timer,
	output reg[7:0]min_timer,
	output reg[7:0]hora_timer
    );


	 
always@*
	begin
	 case (in_addr_mem_local)
		4'd0: begin // escribe segundos_horas
		seg_hora = in_dato_rtc;
		min_hora= 8'b0;
		hora_hora = 8'b0;
		dia_fecha = 8'b0;
		mes_fecha = 8'b0;
		jahr_fecha = 8'b0;
		dia_semana = 8'b0;
		seg_timer = 8'b0;
		min_timer = 8'b0;
		hora_timer = 8'b0;
		end
		4'd1: begin // escribe minutos_horas
		seg_hora = 8'b0;
		min_hora= in_dato_rtc;
		hora_hora = 8'b0;
		dia_fecha = 8'b0;
		mes_fecha = 8'b0;
		jahr_fecha = 8'b0;
		dia_semana = 8'b0;
		seg_timer = 8'b0;
		min_timer = 8'b0;
		hora_timer = 8'b0;
		end
		4'd2: begin // escribe horas_horas
		seg_hora = 8'b0;
		min_hora= 8'b0;
		hora_hora = in_dato_rtc;
		dia_fecha = 8'b0;
		mes_fecha = 8'b0;
		jahr_fecha = 8'b0;
		dia_semana = 8'b0;
		seg_timer = 8'b0;
		min_timer = 8'b0;
		hora_timer = 8'b0;
		end
		4'd3: begin // escribe dia_fecha
		seg_hora = 8'b0;
		min_hora= 8'b0;
		hora_hora = 8'b0;
		dia_fecha = in_dato_rtc;
		mes_fecha = 8'b0;
		jahr_fecha = 8'b0;
		dia_semana = 8'b0;
		seg_timer = 8'b0;
		min_timer = 8'b0;
		hora_timer = 8'b0;
		end
		4'd4: begin // escribe mes_fecha
		seg_hora = 8'b0;
		min_hora= 8'b0;
		hora_hora = 8'b0;
		dia_fecha = 8'b0;
		mes_fecha = in_dato_rtc;
		jahr_fecha = 8'b0;
		dia_semana = 8'b0;
		seg_timer = 8'b0;
		min_timer = 8'b0;
		hora_timer = 8'b0;
		end
		4'd5: begin // escribe jahr_fecha
		seg_hora = 8'b0;
		min_hora= 8'b0;
		hora_hora = 8'b0;
		dia_fecha = 8'b0;
		mes_fecha = 8'b0;
		jahr_fecha = in_dato_rtc;
		dia_semana = 8'b0;
		seg_timer = 8'b0;
		min_timer = 8'b0;
		hora_timer = 8'b0;
		end
		4'd6: begin // escribe dia_semana
		seg_hora = 8'b0;
		min_hora= 8'b0;
		hora_hora = 8'b0;
		dia_fecha = 8'b0;
		mes_fecha = 8'b0;
		jahr_fecha = 8'b0;
		dia_semana = in_dato_rtc;
		seg_timer = 8'b0;
		min_timer = 8'b0;
		hora_timer = 8'b0;
		end
		4'd7: begin // escribe min_timer
		seg_hora = 8'b0;
		min_hora= 8'b0;
		hora_hora = 8'b0;
		dia_fecha = 8'b0;
		mes_fecha = 8'b0;
		jahr_fecha = 8'b0;
		dia_semana = 8'b0;
		seg_timer = in_dato_rtc;
		min_timer = 8'b0;
		hora_timer = 8'b0;
		end
		4'd8: begin // escribe min_timer
		seg_hora = 8'b0;
		min_hora= 8'b0;
		hora_hora = 8'b0;
		dia_fecha = 8'b0;
		mes_fecha = 8'b0;
		jahr_fecha = 8'b0;
		dia_semana = 8'b0;
		seg_timer = 8'b0;
		min_timer = in_dato_rtc;
		hora_timer = 8'b0;
		end
		4'd9:  begin // escribe hora_timer
		seg_hora = 8'b0;
		min_hora= 8'b0;
		hora_hora = 8'b0;
		dia_fecha = 8'b0;
		mes_fecha = 8'b0;
		jahr_fecha = 8'b0;
		dia_semana = 8'b0;
		seg_timer = 8'b0;
		min_timer =  8'b0;
		hora_timer =  in_dato_rtc;
		end
		
	
		default: 
		  begin // escribe hora_timer
			seg_hora = 8'b0;
		min_hora= 8'b0;
		hora_hora = 8'b0;
		dia_fecha = 8'b0;
		mes_fecha = 8'b0;
		jahr_fecha = 8'b0;
		dia_semana = 8'b0;
		seg_timer = 8'b0;
		min_timer =  8'b0;
		hora_timer =  8'b0;
		end
		endcase 
		end
endmodule

