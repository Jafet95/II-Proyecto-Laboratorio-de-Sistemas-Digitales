`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:18:04 04/12/2016 
// Design Name: 
// Module Name:    decofdificador_cs_registros 
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
module decofdificador_cs_registros(
	input [2:0]funcion_conf,
	input wire flag_mostrar_count,
	output reg cs_seg_hora,
	output reg cs_min_hora,
	output reg cs_hora_hora,
	output reg cs_dia_fecha,
	output reg cs_mes_fecha,
	output reg cs_jahr_fecha,
	output reg cs_dia_semana,
	output reg cs_seg_timer,
	output reg cs_min_timer,
	output reg cs_hora_timer
    );
	 
always@*
begin

	case(funcion_conf)
		3'b000: begin
		cs_seg_hora = 1'b0;
		cs_min_hora= 1'b0;
		cs_hora_hora= 1'b0;
		cs_dia_fecha= 1'b0;
		cs_mes_fecha= 1'b0;
		cs_jahr_fecha= 1'b0;
		cs_dia_semana= 1'b0;
		if(flag_mostrar_count)
			begin
			cs_seg_timer= 1'b1;
			cs_min_timer= 1'b1;
			cs_hora_timer= 1'b1;
			end
		else
			begin
			cs_seg_timer= 1'b0;
			cs_min_timer= 1'b0;
			cs_hora_timer= 1'b0;
			end
		

	end
		3'b001: begin
		cs_seg_hora = 1'b1;
		cs_min_hora= 1'b1;
		cs_hora_hora= 1'b1;
		cs_dia_fecha= 1'b0;
		cs_mes_fecha= 1'b0;
		cs_jahr_fecha= 1'b0;
		cs_dia_semana= 1'b0;
		if(flag_mostrar_count)
			begin
			cs_seg_timer= 1'b1;
			cs_min_timer= 1'b1;
			cs_hora_timer= 1'b1;
			end
		else
			begin
			cs_seg_timer= 1'b0;
			cs_min_timer= 1'b0;
			cs_hora_timer= 1'b0;
			end
	end
		3'b010:
		begin
		cs_seg_hora = 1'b0;
		cs_min_hora= 1'b0;
		cs_hora_hora= 1'b0;
		cs_dia_fecha= 1'b1;
		cs_mes_fecha= 1'b1;
		cs_jahr_fecha= 1'b1;
		cs_dia_semana= 1'b1;
		if(flag_mostrar_count)
			begin
			cs_seg_timer= 1'b1;
			cs_min_timer= 1'b1;
			cs_hora_timer= 1'b1;
			end
		else
			begin
			cs_seg_timer= 1'b0;
			cs_min_timer= 1'b0;
			cs_hora_timer= 1'b0;
			end
	end
		3'b100:
		begin
		cs_seg_hora = 1'b0;
		cs_min_hora= 1'b0;
		cs_hora_hora= 1'b0;
		cs_dia_fecha= 1'b0;
		cs_mes_fecha= 1'b0;
		cs_jahr_fecha= 1'b0;
		cs_dia_semana= 1'b0;
		cs_seg_timer= 1'b1;
		cs_min_timer= 1'b1;
		cs_hora_timer= 1'b1;
	end
	default: begin
		cs_seg_hora = 1'b0;
		cs_min_hora= 1'b0;
		cs_hora_hora= 1'b0;
		cs_dia_fecha= 1'b0;
		cs_mes_fecha= 1'b0;
		cs_jahr_fecha= 1'b0;
		cs_dia_semana= 1'b0;
		cs_seg_timer= 1'b0;
		cs_min_timer= 1'b0;
		cs_hora_timer= 1'b0;
	end
endcase
end

endmodule
