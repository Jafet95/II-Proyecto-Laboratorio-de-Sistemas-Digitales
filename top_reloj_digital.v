`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:52:26 04/13/2016 
// Design Name: 
// Module Name:    top_reloj_digital 
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
module top_reloj_digital
(
input clk,
input reset,
input wire [3:0]sw_Nexys,//Modo configuración (x3), formato_hora
input wire [4:0]btn_Nexys,//Botones de desplazamiento en la configuración (x4), desactivar alarma timer

inout [7:0]dato_RTC,	

output a_d,
output cs,
output rd,
output wr,
output wire hsync,vsync,
output wire [11:0] RGB

);

//Conexiones entre módulos
//FSM antirrebote
wire [3:0]sw_db;//Modo configuración (x3), formato_hora
wire [4:0]btn_db;//Botones de desplazamiento en la configuración (x4), desactivar alarma timer

//Control RTC a VGA
wire [7:0]out_seg_hora,out_min_hora,out_hora_hora;
wire [7:0]out_dia_fecha,out_mes_fecha,out_jahr_fecha,out_dia_semana;
wire [7:0]out_seg_timer,out_min_timer,out_hora_timer;
wire estado_alarma;
wire [1:0]cursor_location;
wire AM_PM;

//FSM's antirrebote
debouncing Instancia_debouncing
(
.clk(clk),
.reset(reset),
.sw(sw_Nexys),//4 interruptores
.btn(btn_Nexys),//5 botones
.sw_db(sw_db),//debounce
.btn_db(btn_db)//debounce
);

//Control RTC
Contol_RTC Instancia_Control_RTC(
.clk(clk),
.reset(reset),
.sw0(sw_db[0]),
.sw1(sw_db[1]),
.sw2(sw_db[2]),
.enUP(btn_db[0]),
.enDOWN(btn_db[1]),
.enRIGHT(btn_db[3]),
.enLEFT(btn_db[2]),
.desactivar_alarma(btn_db[4]),
.formato_hora(sw_db[3]),
.dato(dato_RTC),
	
.a_d(a_d),
.cs(cs),
.rd(rd),
.wr(wr),
	
.out_seg_hora(out_seg_hora),.out_min_hora(out_min_hora),.out_hora_hora(out_hora_hora),
.out_dia_fecha(out_dia_fecha),.out_mes_fecha(out_mes_fecha),.out_jahr_fecha(out_jahr_fecha),.out_dia_semana(out_dia_semana),
.out_seg_timer(out_seg_timer),.out_min_timer(out_min_timer),.out_hora_timer(out_hora_timer),

.estado_alarma(estado_alarma),
.cursor_location(cursor_location),	
.AM_PM(AM_PM)
);

//Control VGA
Clock_screen_top Instancia_Clock_screen_top
(
.clock(clk),
.reset(reset),

.digit0_HH(out_hora_hora[3:0]), .digit1_HH(out_hora_hora[7:4]), .digit0_MM(out_min_hora[3:0]), .digit1_MM(out_min_hora[7:4]), .digit0_SS(out_seg_hora[3:0]), .digit1_SS(out_seg_hora[7:4]),//
.digit0_DAY(out_dia_fecha[3:0]), .digit1_DAY(out_dia_fecha[7:4]), .digit0_MES(out_mes_fecha[3:0]), .digit1_MES(out_mes_fecha[7:4]), .digit0_YEAR(out_jahr_fecha[3:0]), .digit1_YEAR(out_jahr_fecha[7:4]),//
.digit0_HH_T(out_hora_timer[3:0]), .digit1_HH_T(out_hora_timer[7:4]), .digit0_MM_T(out_min_timer[3:0]), .digit1_MM_T(out_min_timer[7:4]), .digit0_SS_T(out_seg_timer[3:0]), .digit1_SS_T(out_seg_timer[7:4]),//Decenas y unidades para los números en pantalla (18 inputs de 3 bits)

.AM_PM(AM_PM),//Entrada para conocer si en la información de hora se despliega AM o PM
.dia_semana(out_dia_semana),//Para interpretar el dia de la semana a escribir (3-bits: 7 días)
.config_mode({sw_db[2],sw_db[1],sw_db[0]}),//Cuatro estados del modo configuración
.cursor_location(cursor_location),//Marca la posición del cursor en modo configuración
.formato_hora(sw_db[3]),//Señal que indica si la hora esta en formato 12 hrs o 24 hrs (0->24 hrs)
.estado_alarma(estado_alarma),

.hsync(hsync),
.vsync(vsync),
.RGB(RGB)
//output wire pixel_tick
);

endmodule
