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
	input clk, reset, desactivar_alarma,
	
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
	
	output wire estado_alarma
    );
	 
wire flag1,flag2,flag3;
assign estado_alarma = (flag1 && flag2 && flag3)? 1'b1:1'b0;

 
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
	 .estado_alarma(estado_alarma),
	 .btn_desactivar(desactivar_alarma),
    .out_dato_vga(out_seg_timer_vga), 
    .out_dato_rtc(out_seg_timer_rtc), 
    .flag_out(flag1)
    );
////////intancia reg min_timer
Registro_timer instancia_min_timer (
	 .hold(hold_min_timer),
    .in_rtc_dato(rtc_min_timer), 
    .in_count_dato(count_min_timer), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_min_timer), 
	 .estado_alarma(estado_alarma),
	 .btn_desactivar(desactivar_alarma),
    .out_dato_vga(out_min_timer_vga), 
    .out_dato_rtc(out_min_timer_rtc), 
    .flag_out(flag2)
    );
////////intancia reg hora_timer
Registro_timer instancia_hora_timer(
	 .hold(hold_hora_timer),
    .in_rtc_dato(rtc_hora_timer), 
    .in_count_dato(count_hora_timer), 
    .clk(clk), 
    .reset(reset), 
    .chip_select(cs_hora_timer), 
	 .estado_alarma(estado_alarma),
	 .btn_desactivar(desactivar_alarma),
    .out_dato_vga(out_hora_timer_vga), 
    .out_dato_rtc(out_hora_timer_rtc), 
    .flag_out(flag3)
    );

endmodule 
