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
	
	//input clk,
	
	inout [7:0]hora,//Datos de trabajo
	inout [7:0]min,
	inout [7:0]seg,
	inout [7:0]dia_semana,
	inout [7:0]dia,
	inout [7:0]mes,
	inout [7:0]aho,
	inout [7:0]seg_timer,
	inout [7:0]min_timer,
	inout [7:0]hora_timer,
	inout [7:0]alarma_timer,
	

	
	//Direccion de Banco local de Registros
	input [3:0]addr,
	//Dato de direccion para RAM
	input [7:0]addr_RAM,
	
	//Dato de RTC
	inout[7:0]dato,
	
	//Para controlar condicional de cada posicion de memoria
	input controlador_dato
	
    );
//dato de direccion RAM
//reg [7:0]dato_direccion;
//Dato usado para trabajar en el modulo
reg [7:0]dato_secundario;
////
reg [7:0]hora_trabajo;//Datos de trabajo
reg [7:0]min_trabajo;
reg [7:0]seg_trabajo;
reg [7:0]dia_semana_trabajo;
reg [7:0]dia_trabajo;
reg [7:0]mes_trabajo;
reg [7:0]aho_trabajo;
reg [7:0]seg_timer_trabajo;
reg [7:0]min_timer_trabajo;
reg [7:0]hora_timer_trabajo;
reg [7:0]alarma_timer_trabajo;

//Vaiables de estado
//reg write,read,state;


//*********************************************************


assign dato = dato_secundario;


//assign dato_direccion = addr_RAM;



assign seg = seg_trabajo;
assign min = min_trabajo;
assign hora = hora_trabajo;
assign dia_semana = dia_semana_trabajo;
assign dia = dia_trabajo;
assign mes = mes_trabajo;
assign aho = aho_trabajo;
assign seg_timer = seg_timer_trabajo;
assign min_timer = min_timer_trabajo;
assign hora_timer = hora_timer_trabajo;
assign alarma_timer = alarma_timer_trabajo;
/*
//Parte Secuencial
always@(posedge clk)

begin
	if(controlador_dato) state <= read;
			else state <= write;
end
*/
		
//*********************************************************

//Parte Combinacional

always@*



begin
	case(controlador_dato)

//-------------------------------------------	
		1'b0:
		begin
	
		case(addr)
		
		4'b0000: dato_secundario <= seg_trabajo;
		4'b0001: dato_secundario <= min_trabajo;
		4'b0010: dato_secundario <= hora_trabajo;
		4'b0011: dato_secundario <= dia_semana_trabajo;
		4'b0100: dato_secundario <= dia_trabajo;
		4'b0101: dato_secundario <= mes_trabajo;
		4'b0110: dato_secundario <= aho_trabajo;
		4'b0111: dato_secundario <= seg_timer_trabajo;
		4'b1000: dato_secundario <= min_timer_trabajo;
		4'b1001: dato_secundario <= hora_timer_trabajo;
		4'b1010: dato_secundario <= alarma_timer_trabajo;
		4'b1011: dato_secundario <= addr_RAM;
		default: begin
			dato_secundario <= 8'bzzzzzzzz;
			seg_trabajo <= seg_trabajo;
			min_trabajo <= min_trabajo;
			hora_trabajo <= hora_trabajo;
			dia_semana_trabajo <= dia_semana_trabajo;
			dia_trabajo <= dia_trabajo;
			mes_trabajo <= mes_trabajo;
			aho_trabajo <= aho_trabajo;
			seg_timer_trabajo <= seg_timer_trabajo;
			min_timer_trabajo <= min_timer_trabajo;
			hora_timer_trabajo <= hora_timer_trabajo;
			alarma_timer_trabajo <= alarma_timer_trabajo;
			end
		endcase
		
		
		
		end
//-------------------------------------------	

      1'b1:
		begin	
		
		case(addr)
		
		4'b0000: seg_trabajo <= dato_secundario;
		4'b0001: min_trabajo <= dato_secundario;
		4'b0010: hora_trabajo <= dato_secundario;
		4'b0011: dia_semana_trabajo <= dato_secundario;
		4'b0100: dia_trabajo <= dato_secundario;
		4'b0101: mes_trabajo <= dato_secundario;
		4'b0110: aho_trabajo <= dato_secundario;
		4'b0111: seg_timer_trabajo <= dato_secundario;
		4'b1000: min_timer_trabajo <= dato_secundario;
		4'b1001: hora_timer_trabajo <= dato_secundario;
		4'b1010: alarma_timer_trabajo <= dato_secundario;
		default: begin
			dato_secundario <= 8'bzzzzzzzz;
			seg_trabajo <= seg_trabajo;
			min_trabajo <= min_trabajo;
			hora_trabajo <= hora_trabajo;
			dia_semana_trabajo <= dia_semana_trabajo;
			dia_trabajo <= dia_trabajo;
			mes_trabajo <= mes_trabajo;
			aho_trabajo <= aho_trabajo;
			seg_timer_trabajo <= seg_timer_trabajo;
			min_timer_trabajo <= min_timer_trabajo;
			hora_timer_trabajo <= hora_timer_trabajo;
			alarma_timer_trabajo <= alarma_timer_trabajo;
			end
		
		endcase
		
		end
		
		default: dato_secundario <=  8'bzzzzzzzz;
//-------------------------------------------
endcase
end	


endmodule
