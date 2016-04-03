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
	
	output reg [7:0]hora,//Datos de trabajo
	output reg [7:0]min,
	output reg [7:0]seg,
	output reg [7:0]dia_semana,
	output reg [7:0]dia,
	output reg [7:0]mes,
	output reg [7:0]aho,
	output reg [7:0]seg_timer,
	output reg [7:0]min_timer,
	output reg [7:0]hora_timer,
	output reg [7:0]alarma_timer,
	

	
	//Direccion de Banco local de Registros
	input [3:0]addr,
	//Dato de direccion para RAM
	input[7:0]addr_RAM,
	
	//Dato de RTC
	inout[7:0]dato,
	
	//Para controlar condicional de cada posicion de memoria
	input controlador_dato
	
    );
//dato de direccion RAM
reg [7:0]dato_direccion;
//Dato usado para trabajar en el modulo
reg [7:0]dato_secundario;
//Vaiables de estado
reg write,read,state;


//*********************************************************


assign dato = dato_secundario;
assign addr_RAM = dato_direccion;

//Parte Secuencial
always@(posedge clk)
begin
	if(controlador_dato) state <= read;
			else state <= write;
end

		
//*********************************************************

//Parte Combinacional

always@*



begin
	case(state)

//-------------------------------------------	
		write:
		
		begin
		case(addr)
		
		4'b0000: dato_secundario <= seg;
		4'b0001: dato_secundario <= min;
		4'b0010: dato_secundario <= hora;
		4'b0011: dato_secundario <= dia_semana;
		4'b0100: dato_secundario <= dia;
		4'b0101: dato_secundario <= mes;
		4'b0110: dato_secundario <= aho;
		4'b0111: dato_secundario <= seg_timer;
		4'b1000: dato_secundario <= min_timer;
		4'b1001: dato_secundario <= hora_timer;
		4'b1010: dato_secundario <= alarma_timer;
		4'b1011: dato_secundario <= dato_direccion;
		default dato_secundario <= 32'dz;
		endcase
		
		
		
		end
//-------------------------------------------	

      read:
		
		begin	
		case(addr)
		
		4'b0000: seg <= dato_secundario;
		4'b0001: min <= dato_secundario;
		4'b0010: hora <= dato_secundario;
		4'b0011: dia_semana <= dato_secundario;
		4'b0100: dia <= dato_secundario;
		4'b0101: mes <= dato_secundario;
		4'b0110: aho <= dato_secundario;
		4'b0111: seg_timer <= dato_secundario;
		4'b1000: min_timer <= dato_secundario;
		4'b1001: hora_timer <= dato_secundario;
		4'b1010: alarma_timer <= dato_secundario;
		4'b1011: dato_direccion <= dato_secundario;
		default dato_secundario <= 32'dz;
		endcase
		
		end
//-------------------------------------------
endcase
end	


endmodule
