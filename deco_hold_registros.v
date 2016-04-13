`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:18:15 04/12/2016 
// Design Name: 
// Module Name:    deco_hold_registros 
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
module deco_hold_registros(
	input clk,reset,reg_rd,
	input [3:0]addr_mem_local,
	output reg hold_seg_hora,
	output reg hold_min_hora,
	output reg hold_hora_hora,
	output reg hold_dia_fecha,
	output reg hold_mes_fecha,
	output reg hold_jahr_fecha,
	output reg hold_dia_semana,
	output reg hold_seg_timer,
	output reg hold_min_timer,
	output reg hold_hora_timer
    );
	 
always@(posedge clk ,posedge reset)
begin
if (reset) begin
	hold_seg_hora = 1'b0;
	hold_min_hora= 1'b0;
	hold_hora_hora= 1'b0;
	hold_dia_fecha= 1'b0;
	hold_mes_fecha= 1'b0;
	hold_jahr_fecha= 1'b0;
	hold_dia_semana= 1'b0;
	hold_seg_timer= 1'b0;
	hold_min_timer= 1'b0;
	hold_hora_timer= 1'b0;
end
else begin
	if (~reg_rd) begin
	case(addr_mem_local)
		4'd0: begin
		hold_seg_hora = 1'b0;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_dia_semana= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
	end
	4'd1: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b0;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_dia_semana= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
	end
	4'd2: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b0;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_dia_semana= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
	end
	4'd3: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b0;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_dia_semana= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
	end
	4'd4: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b0;
		hold_jahr_fecha= 1'b1;
		hold_dia_semana= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
	end
	4'd5: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b0;
		hold_dia_semana= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
	end
	4'd6: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_dia_semana= 1'b0;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
	end
	4'd7: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_dia_semana= 1'b1;
		hold_seg_timer= 1'b0;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
	end
	4'd8: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_dia_semana= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b0;
		hold_hora_timer= 1'b1;
	end
	4'd9: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_dia_semana= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b0;
	end 
	default: begin
		hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_dia_semana= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
	end
	endcase
	end
	else begin
	hold_seg_hora = 1'b1;
		hold_min_hora= 1'b1;
		hold_hora_hora= 1'b1;
		hold_dia_fecha= 1'b1;
		hold_mes_fecha= 1'b1;
		hold_jahr_fecha= 1'b1;
		hold_dia_semana= 1'b1;
		hold_seg_timer= 1'b1;
		hold_min_timer= 1'b1;
		hold_hora_timer= 1'b1;
	end
end
end

endmodule