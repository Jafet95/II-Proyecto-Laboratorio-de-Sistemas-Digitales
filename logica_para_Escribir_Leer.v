`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:23:17 04/03/2016 
// Design Name: 
// Module Name:    logica_para_Escribir_Leer 
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
module logica_para_Escribir_Leer_Mux(
	
	input clk, 
	input reset,
	input in_flag_dato,//bandera para capturar dato
	input in_direccion_dato,
	input [7:0]in_dato_inicio,
	input in_flag_inicio,
	
	input [7:0]in_dato,//Datos de entrada para rtc
	
	output reg [7:0]out_reg_dato,//Datos de salida para banco de registros
	
	input [7:0]addr_RAM,//Dato de direccion para RAM
	
	
	inout tri [7:0]dato, //Dato de RTC
	
	
	input controlador_dato //Para controlar condicional si lerr o escribir
	 
    );
//dato de direccion RAM
//reg [7:0]dato_direccion;
//Dato usado para trabajar en el modulo

reg [7:0]dato_secundario;
reg [7:0]in_reg_dato;
reg [7:0]temp_dato;

//*********************************************************
 
// ASIGNACION DE BUS DE 3 ESTADOS
assign dato = (in_flag_dato)? dato_secundario : 8'bZ;

 
//CONTROLADOR DE SALIDA
always @(dato,controlador_dato,in_direccion_dato,in_flag_dato,in_reg_dato,addr_RAM)begin
if(in_flag_dato) begin
	case({controlador_dato,in_direccion_dato})
		2'b00: begin dato_secundario = 8'd0; // OPCION LEER DIRECCION NO DEBE PASAR
		out_reg_dato = 8'b0;
		end
		2'b01: begin dato_secundario = 8'd0;//LEER DATO
		out_reg_dato = dato;
		end 
		2'b10: begin dato_secundario = addr_RAM;// ESCRIBIR DIRECCION RAM
		out_reg_dato = 8'b0;
		end 
		2'b11: begin  dato_secundario = in_reg_dato;// ESCRIBE DATO
		out_reg_dato = 8'd0;
		end
	endcase
	end
else begin out_reg_dato = 8'd0;
dato_secundario = 8'd0;
end
end

//assign dato_direccion = addr_RAM;
always@(posedge clk, posedge reset) 
begin
if (reset) in_reg_dato <= 8'd0;
else begin
if (in_flag_inicio) in_reg_dato <= in_dato_inicio;
else in_reg_dato <= in_dato;
end
end

endmodule
