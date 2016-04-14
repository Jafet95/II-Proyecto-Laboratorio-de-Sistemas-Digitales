`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:30:29 04/12/2016 
// Design Name: 
// Module Name:    Contol_RTC 
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
module Contol_RTC(
	input clk,
	input reset,
	input sw1,
	input sw2,
	input enUP,
	input enDOWN,
	input enRIGHT,
	input enLEFT,
	input wire desactivar_alarma,
	input wire formato_hora,
	inout [7:0]dato,
	
	output a_d,
	output cs,
	output rd,
	output wr,
	
	output [7:0]out_seg_hora,out_min_hora,out_hora_hora,
	output [7:0]out_dia_fecha,out_mes_fecha,out_jahr_fecha,out_dia_semana,
	output [7:0]out_seg_timer,out_min_timer,out_hora_timer,
	
	
	output estado_alarma,
	output [1:0]cursor_location,
	
	output reg AM_PM
    );
/////////////// conexiones
wire [1:0]out_FSM_general_funcion_conf;
wire [7:0]out_FSM_general_addr_ram_rtc;
wire [7:0]out_FSM_general_dato_inicio;
wire out_FSM_general_funcion_w_r;///// 1 escribe en rtc / 0 lee de rtc
wire out_FSM_general_en_funcion_rtc;

wire out_lector_escritor_flag_capturar_dato;
wire out_lector_escritor_direccion_dato;
wire out_lector_escritor_funcion_w_r;
wire out_lector_escritor_flag_done;
//////////////////////////// hold's
wire hold_seg_hora; 
wire hold_min_hora; 
wire hold_hora_hora; 
wire hold_dia_fecha; 
wire hold_mes_fecha; 
wire hold_jahr_fecha; 
wire hold_dia_semana; 
wire hold_seg_timer;
wire hold_min_timer; 
wire hold_hora_timer;
//////////////////////
///////////////////////////////////////// cs's para registros

wire cs_seg_hora; 
wire cs_min_hora; 
wire cs_hora_hora; 
wire cs_dia_fecha; 
wire cs_mes_fecha; 
wire cs_jahr_fecha; 
wire cs_dia_semana; 
wire cs_seg_timer;
wire cs_min_timer; 
wire cs_hora_timer;

//////////////////////////////////////  cable que emtra a los registros sale de la logica combinacacional
wire [7:0]rtc_seg_hora; 
wire [7:0]rtc_min_hora; 
wire [7:0]rtc_hora_hora; 
wire [7:0]rtc_dia_fecha; 
wire [7:0]rtc_mes_fecha; 
wire [7:0]rtc_jahr_fecha; 
wire [7:0]rtc_dia_semana; 
wire [7:0]rtc_seg_timer;
wire [7:0]rtc_min_timer; 
wire [7:0]rtc_hora_timer;
////////////////////////////////

wire [7:0]out_seg_timer_rtc;
wire [7:0]out_min_timer_rtc;
wire [7:0]out_hora_timer_rtc;
wire [7:0]out_dato_para_rtc;
wire [7:0]in_dato_rtc;
//////////////

wire [7:0]count_seg_hora; 
wire [7:0]count_min_hora; 
wire [7:0]count_hora_hora; 
wire [7:0]count_dia_fecha; 
wire [7:0]count_mes_fecha; 
wire [7:0]count_jahr_fecha; 
wire [7:0]count_dia_semana; 
wire [7:0]count_seg_timer;
wire [7:0]count_min_timer; 
wire [7:0]count_hora_timer;

///////////////////////////


wire [3:0]addr_mem_local;
wire [7:0]data_HH;
reg [3:0]digit0_HH, digit1_HH;


///////////////////////
/////////////intancia FSM general/////////////

FSM_general_rtc_version_01 FSM_general (
    .clk(clk), 
    .reset(reset), 
    .in_flag_done(out_lector_escritor_flag_done), 
    .in_sw1(sw1), 
    .in_sw2(sw2), 
    .out_funcion_conf(out_FSM_general_funcion_conf), 
    .out_addr_ram_rtc(out_FSM_general_addr_ram_rtc), 
    .out_dato_inicio(out_FSM_general_dato_inicio), 
    .out_flag_inicio(out_FSM_general_flag_inicio), 
    .out_funcion_w_r(out_FSM_general_funcion_w_r), 
    .out_en_funcion_rtc(out_FSM_general_en_funcion_rtc), 
    .q(), 
    .state_now()
    );
///////////////////////////////




///////////////intancia generador de pulsos RTC //////////
generador_signal_contol_RTC lector_escritor (
    .clk(clk), 
    .reset(reset), 
    .in_escribir_leer(out_FSM_general_funcion_w_r), 
    .en_funcion(out_FSM_general_en_funcion_rtc), 
    .reg_a_d(a_d), 
    .reg_cs(cs), 
    .reg_wr(wr), 
    .reg_rd(rd), 
    .out_flag_capturar_dato(out_lector_flag_capturar_dato), 
    .out_direccion_dato(out_lector_direccion_dato), 
    .reg_funcion_r_w(out_lector_escritor_funcion_w_r), 
    .flag_done(out_lector_escritor_flag_done), 
    .q()
    );
////////////////////////////////

 

//////////////////intancia I/O datos////////
logica_para_Escribir_Leer_Mux instancia_captura_escritura_bus_de_datos (
    .clk(clk), 
    .reset(reset), 
    .in_flag_dato(out_lector_flag_capturar_dato), 
    .in_direccion_dato(out_lector_direccion_dato), 
    .in_dato_inicio(out_FSM_general_dato_inicio), 
    .in_flag_inicio(out_FSM_general_flag_inicio), 
    .in_dato(out_dato_para_rtc), 
    .out_reg_dato(in_dato_rtc), 
    .addr_RAM(out_FSM_general_addr_ram_rtc), 
    .dato(dato), 
    .controlador_dato(out_lector_escritor_funcion_w_r)
    );
///////////////////////////////////////////

//////////intancia traductor addr_rtc_addr_mem_local 
traducto_addr_rtc_addr_mem_local traductor (
    .clk(clk), 
    .reset(reset), 
    .addr_rtc(out_FSM_general_addr_ram_rtc), 
    .addr_mem_local(addr_mem_local)
    );
//////////////////

////////////intancia banco reg locales 
memoria_registros intancia_memoria_registros (
    .clk(clk), 
    .reset(reset), 
	 .desactivar_alarma(desactivar_alarma),
    .cs_seg_hora(cs_seg_hora), 
    .cs_min_hora(cs_min_hora), 
    .cs_hora_hora(cs_hora_hora), 
    .cs_dia_fecha(cs_dia_fecha), 
    .cs_mes_fecha(cs_mes_fecha), 
    .cs_jahr_fecha(cs_jahr_fecha), 
    .cs_dia_semana(cs_dia_semana), 
    .cs_seg_timer(cs_seg_timer), 
    .cs_min_timer(cs_min_timer), 
    .cs_hora_timer(cs_hora_timer),
	 .hold_seg_hora(hold_seg_hora),
	 .hold_min_hora(hold_min_hora),
	 .hold_hora_hora(hold_hora_hora),
	 .hold_dia_fecha(hold_dia_fecha),
	 .hold_mes_fecha(hold_mes_fecha),
	 .hold_jahr_fecha(hold_jahr_fecha),
	 .hold_dia_semana(hold_dia_semana),
	 .hold_seg_timer(hold_seg_timer),
	 .hold_min_timer(hold_min_timer),
	 .hold_hora_timer(hold_hora_timer),
    .rtc_seg_hora(rtc_seg_hora), 
    .rtc_min_hora(rtc_min_hora), 
    .rtc_hora_hora(rtc_hora_hora), 
    .rtc_dia_fecha(rtc_dia_fecha), 
    .rtc_mes_fecha(rtc_mes_fecha), 
    .rtc_jahr_fecha(rtc_jahr_fecha), 
    .rtc_dia_semana(rtc_dia_semana), 
    .rtc_seg_timer(rtc_seg_timer), 
    .rtc_min_timer(rtc_min_timer), 
    .rtc_hora_timer(rtc_hora_timer), 
    .count_seg_hora(count_seg_hora), 
    .count_min_hora(count_min_hora), 
    .count_hora_hora(count_hora_hora), 
    .count_dia_fecha(count_dia_fecha), 
    .count_mes_fecha(count_mes_fecha), 
    .count_jahr_fecha(count_jahr_fecha), 
    .count_dia_semana(count_dia_semana), 
    .count_seg_timer(count_seg_timer), 
    .count_min_timer(count_min_timer), 
    .count_hora_timer(count_hora_timer), 
    .out_seg_hora(out_seg_hora), 
    .out_min_hora(out_min_hora), 
    .out_hora_hora(data_HH), 
    .out_dia_fecha(out_dia_fecha), 
    .out_mes_fecha(out_mes_fecha), 
    .out_jahr_fecha(out_jahr_fecha), 
    .out_dia_semana(out_dia_semana), 
    .out_seg_timer_rtc(out_seg_timer_rtc), 
    .out_min_timer_rtc(out_min_timer_rtc), 
    .out_hora_timer_rtc(out_hora_timer_rtc), 
    .out_seg_timer_vga(out_seg_timer), 
    .out_min_timer_vga(out_min_timer), 
    .out_hora_timer_vga(out_hora_timer), 
    .estado_alarma(estado_alarma)
    );
//////////////////////////////////////////////////////////

/////////////////intancia logica_distributir_dato_rtc_registros
logica_distributir_dato_rtc_registros instancia_logica_distributir_dato_rtc_registros (
    .in_addr_mem_local(addr_mem_local), 
    .in_dato_rtc(in_dato_rtc), 
    .seg_hora(rtc_seg_hora), 
    .min_hora(rtc_min_hora), 
    .hora_hora(rtc_hora_hora), 
    .dia_fecha(rtc_dia_fecha), 
    .mes_fecha(rtc_mes_fecha), 
    .jahr_fecha(rtc_jahr_fecha), 
    .dia_semana(rtc_dia_semana), 
    .seg_timer(rtc_seg_timer), 
    .min_timer(rtc_min_timer), 
    .hora_timer(rtc_hora_timer)
    );
//////////////////

///////////////intnacia logica para cs'=s
decofdificador_cs_registros logica_para_cs_registros (
    .funcion_conf(out_FSM_general_funcion_conf), 
    .cs_seg_hora(cs_seg_hora), 
    .cs_min_hora(cs_min_hora), 
    .cs_hora_hora(cs_hora_hora), 
    .cs_dia_fecha(cs_dia_fecha), 
    .cs_mes_fecha(cs_mes_fecha), 
    .cs_jahr_fecha(cs_jahr_fecha), 
    .cs_dia_semana(cs_dia_semana), 
    .cs_seg_timer(cs_seg_timer), 
    .cs_min_timer(cs_min_timer), 
    .cs_hora_timer(cs_hora_timer)
    );
/////////////////////////////////////

/////////// intancia logica_distruibuir_mem_local_hacia_rtc
logica_distruibuir_mem_local_hacia_rtc instancia_logica_distruibuir_mem_local_hacia_rtc (
    .clk(clk), 
    .reset(reset), 
    .reg_wr(wr), 
    .in_addr_mem_local(addr_mem_local), 
    .in_seg_hora(out_seg_hora), 
    .in_min_hora(out_min_hora), 
    .in_hora_hora(out_hora_hora), 
    .in_dia_fecha(out_dia_fecha), 
    .in_mes_fecha(out_mes_fecha), 
    .in_jahr_fecha(out_jahr_fecha), 
    .in_dia_semana(out_dia_semana), 
    .in_seg_timer(out_seg_timer_rtc), 
    .in_min_timer(out_min_timer_rtc), 
    .in_hora_timer(out_hora_timer_rtc), 
    .out_dato_para_rtc(out_dato_para_rtc)
    );
////////////////////

////////////////////intancia decodificador para hold
deco_hold_registros instancia_deco_hold 
(
	 .reg_rd(rd),
    .addr_mem_local(addr_mem_local), 
    .hold_seg_hora(hold_seg_hora), 
    .hold_min_hora(hold_min_hora), 
    .hold_hora_hora(hold_hora_hora), 
    .hold_dia_fecha(hold_dia_fecha), 
    .hold_mes_fecha(hold_mes_fecha), 
    .hold_jahr_fecha(hold_jahr_fecha), 
    .hold_dia_semana(hold_dia_semana), 
    .hold_seg_timer(hold_seg_timer), 
    .hold_min_timer(hold_min_timer), 
    .hold_hora_timer(hold_hora_timer)
);
////////////////////////
/////////////// INTANCIA CONTADORES
contadores_configuracion instancia_contadores_A_D (
    .clk(clk), 
    .reset(reset), 
    .enUP(enUP), 
    .enDOWN(enDOWN), 
    .enLEFT(enLEFT), 
    .enRIGHT(enRIGHT), 
    .config_mode(out_FSM_general_funcion_conf), 
    .btn_data_SS(count_seg_hora), 
    .btn_data_MM(count_min_hora), 
    .btn_data_HH(count_hora_hora), 
    .btn_data_YEAR(count_dia_fecha), 
    .btn_data_MES(count_mes_fecha), 
    .btn_data_DAY(count_jahr_fecha), 
    .btn_data_SS_T(count_seg_timer), 
    .btn_data_MM_T(count_min_timer), 
    .btn_data_HH_T(count_hora_timer), 
    .AM_PM(), 
    .dia_semana(count_dia_semana), 
    .cursor_location(cursor_location)
    );
	 ////////////////fin intnciaciones

/////////////////////////
///////////// BLOQUE PARA TRADUCIR FORMATO DE LA HORA

always@*
begin
	if(formato_hora)//12 hrs (Traduce a formato 12 hrs)
	begin
		case(data_HH)
		8'd0: begin digit1_HH = 4'b0000; digit0_HH = 4'b0000; AM_PM = 0; end//00 BCD en 8 bits
		8'd1: begin digit1_HH = 4'b0000; digit0_HH = 4'b0001; AM_PM = 0; end//01 BCD en 8 bits
		8'd2: begin digit1_HH = 4'b0000; digit0_HH = 4'b0010; AM_PM = 0; end//02 BCD en 8 bits
		8'd3: begin digit1_HH = 4'b0000; digit0_HH = 4'b0011; AM_PM = 0; end//03 BCD en 8 bits
		8'd4: begin digit1_HH = 4'b0000; digit0_HH = 4'b0100; AM_PM = 0; end//04 BCD en 8 bits
		8'd5: begin digit1_HH = 4'b0000; digit0_HH = 4'b0101; AM_PM = 0; end//05 BCD en 8 bits
		8'd6: begin digit1_HH = 4'b0000; digit0_HH = 4'b0110; AM_PM = 0; end//06 BCD en 8 bits
		8'd7: begin digit1_HH = 4'b0000; digit0_HH = 4'b0111; AM_PM = 0; end//07 BCD en 8 bits
		8'd8: begin digit1_HH = 4'b0000; digit0_HH = 4'b1000; AM_PM = 0; end//08 BCD en 8 bits
		8'd9: begin digit1_HH = 4'b0000; digit0_HH = 4'b1001; AM_PM = 0; end//09 BCD en 8 bits
		8'd16: begin digit1_HH = 4'b0001; digit0_HH = 4'b0000; AM_PM = 0; end//10 BCD en 8 bits
		8'd17: begin digit1_HH = 4'b0001; digit0_HH = 4'b0001; AM_PM = 0; end//11 BCD en 8 bits
		
		8'd18: begin digit1_HH = 4'b0001; digit0_HH = 4'b0010; AM_PM = 1; end//12 BCD en 8 bits
		8'd19: begin digit1_HH = 4'b0001; digit0_HH = 4'b0011; AM_PM = 1; end//13 BCD en 8 bits
		8'd20: begin digit1_HH = 4'b0001; digit0_HH = 4'b0100; AM_PM = 1; end//14 BCD en 8 bits
		8'd21: begin digit1_HH = 4'b0001; digit0_HH = 4'b0101; AM_PM = 1; end//15 BCD en 8 bits
		8'd22: begin digit1_HH = 4'b0001; digit0_HH = 4'b0110; AM_PM = 1; end//16 BCD en 8 bits
		8'd23: begin digit1_HH = 4'b0001; digit0_HH = 4'b0111; AM_PM = 1; end//17 BCD en 8 bits
		8'd24: begin digit1_HH = 4'b0001; digit0_HH = 4'b1000; AM_PM = 1; end//18 BCD en 8 bits
		8'd25: begin digit1_HH = 4'b0001; digit0_HH = 4'b1001; AM_PM = 1; end//19 BCD en 8 bits
		8'd32: begin digit1_HH = 4'b0010; digit0_HH = 4'b0000; AM_PM = 1; end//20 BCD en 8 bits
		8'd33: begin digit1_HH = 4'b0010; digit0_HH = 4'b0001; AM_PM = 1; end//21 BCD en 8 bits
		8'd34: begin digit1_HH = 4'b0010; digit0_HH = 4'b0010; AM_PM = 1; end//22 BCD en 8 bits
		8'd35: begin digit1_HH = 4'b0010; digit0_HH = 4'b0011; AM_PM = 1; end//23 BCD en 8 bits
		default:  begin digit1_HH = 0; digit0_HH = 0; AM_PM = 0; end
		endcase
	end
	
	else //24 hrs (Transfiere el dato simplemente)
	begin
		digit1_HH = data_HH[7:4];
		digit0_HH = data_HH[3:0];
		AM_PM = 0;
	end
end

assign out_hora_hora = {digit1_HH,digit0_HH};

//////////////////////////////////////////////////////////////////////////////////




endmodule

