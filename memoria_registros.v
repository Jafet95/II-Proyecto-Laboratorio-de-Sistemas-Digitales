`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:23:16 04/12/2016 
// Design Name: 
// Module Name:    memoria_registros 
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
module memoria_registros( 
	input clk, reset, desactivar_alarma, sw2,
	
	input cs_seg_hora,cs_min_hora,cs_hora_hora,
	input cs_dia_fecha,cs_mes_fecha,cs_jahr_fecha,cs_dia_semana,
	input cs_seg_timer,cs_min_timer,cs_hora_timer,
	
	input hold_seg_hora,hold_min_hora,hold_hora_hora,
	input hold_dia_fecha,hold_mes_fecha,hold_jahr_fecha,hold_dia_semana,
	input hold_seg_timer,hold_min_timer,hold_hora_timer,
	
	input [7:0]rtc_seg_hora,rtc_min_hora,rtc_hora_hora,
	input [7:0]rtc_dia_fecha,rtc_mes_fecha,rtc_jahr_fecha,rtc_dia_semana,
	input [7:0]rtc_seg_timer,rtc_min_timer,rtc_hora_timer,
	
	input [7:0]count_seg_hora,count_min_hora,count_hora_hora,
	input [7:0]count_dia_fecha,count_mes_fecha,count_jahr_fecha,count_dia_semana,
	input [7:0]count_seg_timer,count_min_timer,count_hora_timer,
	
	output [7:0]out_seg_hora,out_min_hora,out_hora_hora,
	output [7:0]out_dia_fecha,out_mes_fecha,out_jahr_fecha,out_dia_semana,
	
	output [7:0]out_seg_timer_rtc,out_min_timer_rtc,out_hora_timer_rtc,
	output [7:0]out_seg_timer_vga,out_min_timer_vga,out_hora_timer_vga,
	
	output reg estado_alarma,
	output reg flag_mostrar_count
    );
	 
//wire flag1,flag2,flag3;
reg flag_done_timer;
//assign flag_done_timer = (flag1 && flag2 && flag3)? 1'b1:1'b0;

 
////////intancia reg seg_hora
Registro_Universal instancia_seg_hora (
	 .hold(hold_seg_hora),
    .in_rtc_dato(rtc_seg_hora), 
    .in_count_dato(count_seg_hora), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_seg_hora), 
    .out_dato(out_seg_hora)
    );
////////intancia reg min_hora
Registro_Universal instancia_min_hora (
	 .hold(hold_min_hora),
    .in_rtc_dato(rtc_min_hora), 
    .in_count_dato(count_min_hora), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_min_hora), 
    .out_dato(out_min_hora)
    );
////////intancia reg hora_hora
Registro_Universal instancia_hora_hora (
	 .hold(hold_hora_hora),
    .in_rtc_dato(rtc_hora_hora), 
    .in_count_dato(count_hora_hora), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_hora_hora), 
    .out_dato(out_hora_hora)
    );
////////intancia reg dia_fecha
Registro_Universal instancia_dia_fecha (
	 .hold(hold_dia_fecha),
    .in_rtc_dato(rtc_dia_fecha), 
    .in_count_dato(count_dia_fecha), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_dia_fecha), 
    .out_dato(out_dia_fecha)
    );
////////intancia reg mes_fecha
Registro_Universal instancia_mes_fecha (
	 .hold(hold_mes_fecha),
    .in_rtc_dato(rtc_mes_fecha), 
    .in_count_dato(count_mes_fecha), 
    .clk(clk), 
    .reset(reset),  
    .chip_select(cs_mes_fecha), 
    .out_dato(out_mes_fecha)
    );
////////intancia reg jahr_fecha
Registro_Universal instancia_jahr_fecha (
	 .hold(hold_jahr_fecha),	
    .in_rtc_dato(rtc_jahr_fecha), 
    .in_count_dato(count_jahr_fecha), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_jahr_fecha), 
    .out_dato(out_jahr_fecha)
    );
////////intancia reg dia_semana
Registro_Universal instancia_dia_semana (
    .hold(hold_dia_semana),
    .in_rtc_dato(rtc_dia_semana), 
    .in_count_dato(count_dia_semana), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_dia_semana), 
    .out_dato(out_dia_semana)
    );
////////intancia reg seg_timer
Registro_timer instancia_seg_timer (
	 .hold(hold_seg_timer),
    .in_rtc_dato(rtc_seg_timer), 
    .in_count_dato(count_seg_timer), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_seg_timer),
    .out_dato_vga(out_seg_timer_vga), 
    .out_dato_rtc(out_seg_timer_rtc)
    );
////////intancia reg min_timer
Registro_timer instancia_min_timer (
	 .hold(hold_min_timer),
    .in_rtc_dato(rtc_min_timer), 
    .in_count_dato(count_min_timer), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_min_timer), 
    .out_dato_vga(out_min_timer_vga), 
    .out_dato_rtc(out_min_timer_rtc)
    );
////////intancia reg hora_timer
Registro_timer instancia_hora_timer(
	 .hold(hold_hora_timer),
    .in_rtc_dato(rtc_hora_timer), 
    .in_count_dato(count_hora_timer), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_hora_timer),
    .out_dato_vga(out_hora_timer_vga), 
    .out_dato_rtc(out_hora_timer_rtc)
    );

//Para generar flag_done_timer
always@(posedge clk)
begin
	if(reset) flag_done_timer <= 1'b0;
	else if((rtc_seg_timer == count_seg_timer)&&(rtc_min_timer == count_min_timer)&&((count_hora_timer!=0)||(count_min_timer!=0)||(count_seg_timer!=0))&&(estado_alarma==0)) flag_done_timer <= 1'b1;
	else flag_done_timer <= 1'b0;
end
	 
	 
///////  FSM para alarma timer //////////

localparam [1:0]
espera_conf = 2'b00,
conf = 2'b01,
timer_run = 2'b10,
alarma_on = 2'b11;

reg [1:0] state_reg , state_next;
//// secuancial
always@(posedge clk , posedge reset) 
begin
if (reset) state_reg = espera_conf;
else state_reg = state_next;
end
/// combinacional
always@*
begin
state_next = state_reg ; 
case (state_reg)
	espera_conf: begin
	flag_mostrar_count = 1'b1;
	estado_alarma = 1'b0;
		if(sw2) state_next = conf;
		else state_next = espera_conf;
	end
	conf: begin
	flag_mostrar_count = 1'b1;
	estado_alarma = 1'b0;
	if(~sw2) state_next = timer_run;
	else state_next = conf;
	end
	timer_run: begin
	flag_mostrar_count = 1'b0;
	estado_alarma = 1'b0;
	if (flag_done_timer) state_next = alarma_on;
	else state_next = timer_run;
	end
	alarma_on: begin
	flag_mostrar_count = 1'b1;
	estado_alarma = 1'b1;
	if (desactivar_alarma) state_next = espera_conf;
	else state_next = alarma_on;
	end
endcase
end

/////////////////////////////////////////

endmodule 
