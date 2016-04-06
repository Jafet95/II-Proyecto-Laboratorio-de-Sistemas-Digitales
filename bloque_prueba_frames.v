`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:15:32 03/28/2016 
// Design Name: 
// Module Name:    bloque_prueba_frames 
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
module bloque_prueba_frames
(
input wire [2:0]sw,
output reg [3:0] digit0_HH, digit1_HH, digit0_MM, digit1_MM, digit0_SS, digit1_SS,//
digit0_DAY, digit1_DAY, digit0_MES, digit1_MES, digit0_YEAR, digit1_YEAR,//
digit0_HH_T, digit1_HH_T, digit0_MM_T, digit1_MM_T, digit0_SS_T, digit1_SS_T,//Decenas y unidades para los números en pantalla (18 inputs de 3 bits)
output reg AM_PM,//Entrada para conocer si en la información de hora se despliega AM o PM
output reg [2:0] dia_semana,//Para interpretar el dia de la semana a escribir (3-bits: 7 días)
output reg [1:0]funcion,//2-bits: cuatro estados del modo configuración
output reg [1:0] cursor_location,//Marca la posición del cursor en modo configuración
output reg timer_end,//bandera proveniente del RTC que indica la finalización del tiempo del timer
output reg formato_hora//Señal que indica si la hora esta en formato 12 hrs o 24 hrs (0->24 hrs)
);


//Lógica de salida
always@*

begin

case(sw)

3'h0://Escribe 0's, cursor off (modo normal), escribe AM, escribe Lunes, emula finalización de TIMER
begin
digit0_HH = 4'b0000;
digit1_HH = 4'b0000;
digit0_MM = 4'b0000; 
digit1_MM = 4'b0000;
digit0_SS = 4'b0000;
digit1_SS = 4'b0000;//

digit0_DAY = 4'b0000;
digit1_DAY = 4'b0000;
digit0_MES = 4'b0000;
digit1_MES = 4'b0000;
digit0_YEAR = 4'b0000;
digit1_YEAR = 4'b0000;//

digit0_HH_T = 4'b0000; 
digit1_HH_T = 4'b0000;
digit0_MM_T = 4'b0000;
digit1_MM_T = 4'b0000;
digit0_SS_T = 4'b0000;
digit1_SS_T = 4'b0000;

AM_PM = 1'b0;
dia_semana = 3'b001;
funcion = 2'b00;
cursor_location = 2'b00;
timer_end = 1'b1;
formato_hora = 1'b1;
end

3'h1://Escribe 0's, cursor on (config. hora: cambia HH, escribe PM, escribe Martes)
begin
digit0_HH = 4'b0101;
digit1_HH = 4'b0001;
digit0_MM = 4'b0000; 
digit1_MM = 4'b0000;
digit0_SS = 4'b0000;
digit1_SS = 4'b0000;//

digit0_DAY = 4'b0000;
digit1_DAY = 4'b0000;
digit0_MES = 4'b0000;
digit1_MES = 4'b0000;
digit0_YEAR = 4'b0000;
digit1_YEAR = 4'b0000;//

digit0_HH_T = 4'b0000; 
digit1_HH_T = 4'b0000;
digit0_MM_T = 4'b0000;
digit1_MM_T = 4'b0000;
digit0_SS_T = 4'b0000;
digit1_SS_T = 4'b0000;

AM_PM = 1'b1;
dia_semana = 3'b010;
funcion = 2'b01;
cursor_location = 2'b10;
timer_end = 1'b0;
formato_hora = 1'b1;
end

3'h2://Escribe 0's, cursor on (config. hora: cambia MM, escribe AM, escribe Miércoles)
begin
digit0_HH = 4'b0000;
digit1_HH = 4'b0000;
digit0_MM = 4'b0110; 
digit1_MM = 4'b0011;
digit0_SS = 4'b0000;
digit1_SS = 4'b0000;//

digit0_DAY = 4'b0000;
digit1_DAY = 4'b0000;
digit0_MES = 4'b0000;
digit1_MES = 4'b0000;
digit0_YEAR = 4'b0000;
digit1_YEAR = 4'b0000;//

digit0_HH_T = 4'b0000; 
digit1_HH_T = 4'b0000;
digit0_MM_T = 4'b0000;
digit1_MM_T = 4'b0000;
digit0_SS_T = 4'b0000;
digit1_SS_T = 4'b0000;

AM_PM = 1'b0;
dia_semana = 3'b011;
funcion = 2'b01;
cursor_location = 2'b11;
timer_end = 1'b0;
formato_hora = 1'b1;
end

3'h3://Escribe 0's, cursor on (config. fecha: cambia Día, escribe PM, escribe Jueves)
begin
digit0_HH = 4'b0000;
digit1_HH = 4'b0000;
digit0_MM = 4'b0000; 
digit1_MM = 4'b0000;
digit0_SS = 4'b0000;
digit1_SS = 4'b0000;//

digit0_DAY = 4'b0001;
digit1_DAY = 4'b0011;
digit0_MES = 4'b0000;
digit1_MES = 4'b0000;
digit0_YEAR = 4'b0000;
digit1_YEAR = 4'b0000;//

digit0_HH_T = 4'b0000; 
digit1_HH_T = 4'b0000;
digit0_MM_T = 4'b0000;
digit1_MM_T = 4'b0000;
digit0_SS_T = 4'b0000;
digit1_SS_T = 4'b0000;

AM_PM = 1'b1;
dia_semana = 3'b100;
funcion = 2'b10;
cursor_location = 2'b10;
timer_end = 1'b0;
formato_hora = 1'b1;
end

3'h4://Escribe 0's, cursor on (config. fecha: día de la semana(cursor),escribe año 99, formato 24 hrs , escribe Viernes)
begin
digit0_HH = 4'b0000;
digit1_HH = 4'b0000;
digit0_MM = 4'b0000; 
digit1_MM = 4'b0000;
digit0_SS = 4'b0000;
digit1_SS = 4'b0000;//

digit0_DAY = 4'b0000;
digit1_DAY = 4'b0000;
digit0_MES = 4'b0000;
digit1_MES = 4'b0000;
digit0_YEAR = 4'b1001;
digit1_YEAR = 4'b1001;//

digit0_HH_T = 4'b0000; 
digit1_HH_T = 4'b0000;
digit0_MM_T = 4'b0000;
digit1_MM_T = 4'b0000;
digit0_SS_T = 4'b0000;
digit1_SS_T = 4'b0000;

AM_PM = 1'b0;
dia_semana = 3'b101;
funcion = 2'b10;
cursor_location = 2'b11;
timer_end = 1'b0;
formato_hora = 1'b0;
end

3'h5://Escribe 0's, cursor on (config. timer: cambia MM, formato 24 hrs, escribe Sábado)
begin
digit0_HH = 4'b0000;
digit1_HH = 4'b0000;
digit0_MM = 4'b0000; 
digit1_MM = 4'b0000;
digit0_SS = 4'b0000;
digit1_SS = 4'b0000;//

digit0_DAY = 4'b0000;
digit1_DAY = 4'b0000;
digit0_MES = 4'b0000;
digit1_MES = 4'b0000;
digit0_YEAR = 4'b0000;
digit1_YEAR = 4'b0000;//

digit0_HH_T = 4'b0000; 
digit1_HH_T = 4'b0000;
digit0_MM_T = 4'b0101;
digit1_MM_T = 4'b0010;
digit0_SS_T = 4'b0000;
digit1_SS_T = 4'b0000;

AM_PM = 1'b1;
dia_semana = 3'b110;
funcion = 2'b11;
cursor_location = 2'b01;
timer_end = 1'b0;
formato_hora = 1'b0;
end

3'h6://Escribe 0's, cursor on (config. TIMER: cambia SS, formato 24 hrs, escribe Domingo)
begin
digit0_HH = 4'b0000;
digit1_HH = 4'b0000;
digit0_MM = 4'b0000; 
digit1_MM = 4'b0000;
digit0_SS = 4'b0000;
digit1_SS = 4'b0000;//

digit0_DAY = 4'b0000;
digit1_DAY = 4'b0000;
digit0_MES = 4'b0000;
digit1_MES = 4'b0000;
digit0_YEAR = 4'b0000;
digit1_YEAR = 4'b0000;//

digit0_HH_T = 4'b0000; 
digit1_HH_T = 4'b0000;
digit0_MM_T = 4'b0000;
digit1_MM_T = 4'b0000;
digit0_SS_T = 4'b0011;
digit1_SS_T = 4'b0100;

AM_PM = 1'b0;
dia_semana = 3'b111;
funcion = 2'b11;
cursor_location = 2'b00;
timer_end = 1'b0;
formato_hora = 1'b0;
end

3'h7://Escribe en todos los dígitos, cursor off (modo normal), formato 24 hrs, escribe Lunes
begin
digit0_HH = 4'b0101;
digit1_HH = 4'b0001;
digit0_MM = 4'b0010; 
digit1_MM = 4'b0101;
digit0_SS = 4'b1001;
digit1_SS = 4'b0011;//

digit0_DAY = 4'b1001;
digit1_DAY = 4'b0010;
digit0_MES = 4'b0011;
digit1_MES = 4'b0000;
digit0_YEAR = 4'b0110;
digit1_YEAR = 4'b0001;//

digit0_HH_T = 4'b0110; 
digit1_HH_T = 4'b0001;
digit0_MM_T = 4'b0001;
digit1_MM_T = 4'b0001;
digit0_SS_T = 4'b0101;
digit1_SS_T = 4'b1001;

AM_PM = 1'b1;
dia_semana = 3'b001;
funcion = 2'b00;
cursor_location = 2'b00;
timer_end = 1'b0;
formato_hora = 1'b0;
end
endcase
end

endmodule
