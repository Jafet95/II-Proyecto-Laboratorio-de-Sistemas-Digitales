`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    16:48:28 04/05/2016 
// Design Name: 
// Module Name:    Top_prueba_botones_VGA 
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
module Top_prueba_botones_VGA
(
input wire clk,
input wire reset,
input wire [3:0] sw,//3 interruptores
input wire [3:0] btn,//4 botones
output wire hsync,vsync,
output wire[11:0] RGB
);

wire [3:0] sw_db;//debounce
wire [3:0] btn_db;//debounce

wire [3:0] digit0_HH, digit1_HH, digit0_MM, digit1_MM, digit0_SS, digit1_SS,//
digit0_DAY, digit1_DAY, digit0_MES, digit1_MES, digit0_YEAR, digit1_YEAR,//
digit0_HH_T, digit1_HH_T, digit0_MM_T, digit1_MM_T, digit0_SS_T, digit1_SS_T;//Decenas y unidades para los números en pantalla (18 inputs de 3 bits)
wire AM_PM;
wire [7:0] dia_semana;
wire [1:0] cursor_location;

debouncing Instancia_debouncing
(
.clk(clk),
.reset(reset),
.sw(sw),//3 interruptores
.btn(btn),//4 botones
.sw_db(sw_db),//debounce
.btn_db(btn_db)//debounce
);

contadores_configuracion Instancia_contadores_configuracion
(
.clk(clk), 
.reset(reset),
.enUP(btn_db[0]),
.enDOWN(btn_db[1]),
.enLEFT(btn_db[2]),
.enRIGHT(btn_db[3]),
.config_mode({sw_db[1],sw_db[0]}),//Cuatro estados del modo configuración
.formato_hora(sw_db[2]),
.digit0_HH(digit0_HH), .digit1_HH(digit1_HH), .digit0_MM(digit0_MM), .digit1_MM(digit1_MM), .digit0_SS(digit0_SS), .digit1_SS(digit1_SS),//
.digit0_DAY(digit0_DAY), .digit1_DAY(digit1_DAY), .digit0_MES(digit0_MES), .digit1_MES(digit1_MES), .digit0_YEAR(digit0_YEAR), .digit1_YEAR(digit1_YEAR),//
.digit0_HH_T(digit0_HH_T), .digit1_HH_T(digit1_HH_T), .digit0_MM_T(digit0_MM_T), .digit1_MM_T(digit1_MM_T), .digit0_SS_T(digit0_SS_T), .digit1_SS_T(digit1_SS_T),
.AM_PM(AM_PM),//Entrada para conocer si en la información de hora se despliega AM o PM
.dia_semana(dia_semana),//Para interpretar el dia de la semana a escribir (3-bits: 7 días)
.cursor_location(cursor_location)//Marca la posición del cursor en modo configuración
);

Clock_screen_top Instancia_Clock_screen_top
(
.clock(clk), .reset(reset),
.digit0_HH(digit0_HH), .digit1_HH(digit1_HH), .digit0_MM(digit0_MM), .digit1_MM(digit1_MM), .digit0_SS(digit0_SS), .digit1_SS(digit1_SS),//
.digit0_DAY(digit0_DAY), .digit1_DAY(digit1_DAY), .digit0_MES(digit0_MES), .digit1_MES(digit1_MES), .digit0_YEAR(digit0_YEAR), .digit1_YEAR(digit1_YEAR),//
.digit0_HH_T(digit0_HH_T), .digit1_HH_T(digit1_HH_T), .digit0_MM_T(digit0_MM_T), .digit1_MM_T(digit1_MM_T), .digit0_SS_T(digit0_SS_T), .digit1_SS_T(digit1_SS_T),//Decenas y unidades para los números en pantalla (18 inputs de 3 bits)
.AM_PM(AM_PM),//Entrada para conocer si en la información de hora se despliega AM o PM
.dia_semana(dia_semana[2:0]),//Para interpretar el dia de la semana a escribir (3-bits: 7 días)
.config_mode({sw_db[1],sw_db[0]}),//1-bit: OR de los tres estados del modo configuración
.cursor_location(cursor_location),//Marca la posición del cursor en modo configuración
.timer_end(sw_db[3]),//bandera proveniente del RTC que indica la finalización del tiempo del timer
.formato_hora(sw_db[2]),//Señal que indica si la hora esta en formato 12 hrs o 24 hrs (0->24 hrs)
.hsync(hsync),.vsync(vsync),
.RGB(RGB)
);

endmodule
