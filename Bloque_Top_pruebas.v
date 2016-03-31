`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:05:24 03/30/2016 
// Design Name: 
// Module Name:    Bloque_Top_pruebas 
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

module Bloque_Top_pruebas
(
input clock_FPGA, reset,
input [2:0]sw,
output hsync, vsync,
output [11:0]RGB
);

wire [3:0] digit0_HH, digit1_HH, digit0_MM, digit1_MM, digit0_SS, digit1_SS,//
digit0_DAY, digit1_DAY, digit0_MES, digit1_MES, digit0_YEAR, digit1_YEAR,//
digit0_HH_T, digit1_HH_T, digit0_MM_T, digit1_MM_T, digit0_SS_T, digit1_SS_T;

wire AM_PM;
wire [2:0] dia_semana;
wire [1:0] funcion;
wire [1:0] cursor_location;

bloque_prueba_frames Instancia_bloque_prueba_frames
(
.sw(sw),
.digit0_HH(digit0_HH), .digit1_HH(digit1_HH), .digit0_MM(digit0_MM), .digit1_MM(digit1_MM), .digit0_SS(digit0_SS), .digit1_SS(digit1_SS),//
.digit0_DAY(digit0_DAY), .digit1_DAY(digit1_DAY), .digit0_MES(digit0_MES), .digit1_MES(digit1_MES), .digit0_YEAR(digit0_YEAR), .digit1_YEAR(digit1_YEAR),//
.digit0_HH_T(digit0_HH_T), .digit1_HH_T(digit1_HH_T), .digit0_MM_T(digit0_MM_T), .digit1_MM_T(digit1_MM_T), .digit0_SS_T(digit0_SS_T), .digit1_SS_T(digit1_SS_T),//Decenas y unidades para los números en pantalla (18 inputs de 3 bits)
.AM_PM(AM_PM),//Entrada para conocer si en la información de hora se despliega AM o PM
.dia_semana(dia_semana),//Para interpretar el dia de la semana a escribir (3-bits: 7 días)
.funcion(funcion),//2-bits: cuatro estados del modo configuración
.cursor_location(cursor_location)//Marca la posición del cursor en modo configuración
);

Clock_screen_top Instancia_Clock_screen_top
(
.clock(clock_FPGA), .reset(reset),
.digit0_HH(digit0_HH), .digit1_HH(digit1_HH), .digit0_MM(digit0_MM), .digit1_MM(digit1_MM), .digit0_SS(digit0_SS), .digit1_SS(digit1_SS),//
.digit0_DAY(digit0_DAY), .digit1_DAY(digit1_DAY), .digit0_MES(digit0_MES), .digit1_MES(digit1_MES), .digit0_YEAR(digit0_YEAR), .digit1_YEAR(digit1_YEAR),//
.digit0_HH_T(digit0_HH_T), .digit1_HH_T(digit1_HH_T), .digit0_MM_T(digit0_MM_T), .digit1_MM_T(digit1_MM_T), .digit0_SS_T(digit0_SS_T), .digit1_SS_T(digit1_SS_T),//Decenas y unidades para los números en pantalla (18 inputs de 3 bits)
.AM_PM(AM_PM),//Entrada para conocer si en la información de hora se despliega AM o PM
.dia_semana(dia_semana),//Para interpretar el dia de la semana a escribir (3-bits: 7 días)
.funcion(funcion),//2-bits: cuatro estados del modo configuración
.cursor_location(cursor_location),//Marca la posición del cursor en modo configuración
.hsync(hsync),.vsync(vsync),
.RGB(RGB)
);


endmodule

