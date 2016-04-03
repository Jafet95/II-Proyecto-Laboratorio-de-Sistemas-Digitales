`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:39:12 04/03/2016 
// Design Name: 
// Module Name:    logica_generador_pulsos_RTC 
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
/////////////////////////////////////
/////////////////////////////////////////////
module logica_generador_pulsos_RTC(

	input clk,
	input en,
	input [1:0]funcion,
	input [4:0]cuenta,//Senal del contador
	output a_d, //Senales de control RTC
	output cs,
	output wr,
	output rd,
	output [3:0]addr_logica_escribir_leer,
	output [7:0]addr_RAM,
	output funcion_r_w
	
    );
	 
//registros para de uso interno
reg state, lectura_total, lectura_sin_hora, lectura_sin_timer, lectura_sin_fecha;
reg a_d_trabajo,cs_trabajo,wr_trabajo,rd_trabajo,funcion_r_w_trabajo;
reg [3:0]addr_logica_escribir_leer_trabajo;
reg [7:0]addr_RAM_trabajo;


//Asignaciones logicas
assign a_d = a_d_trabajo;
assign cs = cs_trabajo;
assign wr = wr_trabajo;
assign rd = rd_trabajo;
assign funcion_r_w = funcion_r_w_trabajo;
assign addr_logica_escribir_leer = addr_logica_escribir_leer_trabajo;
assign addr_RAM = addr_RAM_trabajo;




////PAARTE COMBINACIONAL
always@(posedge clk)
	begin
	case (funcion)
		2'b00: state = lectura_total;
		2'b01: state = lectura_sin_hora;
		2'b10: state = lectura_sin_fecha;
		2'b01: state = lectura_sin_timer;
	endcase
	end
	
	
////PARTE SECUENCIAL
always@*
begin
	case(state)

//-------------------------------------------	
		lectura_total:
		
		begin
		case(cuenta)
		
		10'd0: addr_RAM_trabajo = 8'hF1;
		10'd1: a_d_trabajo = 0;
		10'd2: begin
			cs_trabajo = 0;
			wr_trabajo = 0;
			rd_trabajo = 1;
			funcion_r_w_trabajo = 0;
			addr_logica_escribir_leer_trabajo = 4'b1011;
			end
			
		10'd6: begin
			cs_trabajo = 1;
			wr_trabajo = 1;
			rd_trabajo = 1;
			end
		10'd7: a_d_trabajo=1;
			
		10'd9: begin
			funcion_r_w_trabajo = 0;
			addr_logica_escribir_leer_trabajo = 4'b1111;
			end
			
		//10'd12:a_d=1;
		
		10'd13: begin
			cs_trabajo = 0;
			wr_trabajo = 1;
			rd_trabajo = 0;
			end
		10'd17: begin
			cs_trabajo = 1;
			wr_trabajo = 1;
			rd_trabajo = 1;
			end
		10'd18: begin
			a_d_trabajo = 0;
			end
			
			
		10'd23: addr_RAM_trabajo = 8'hF1; 
		10'd24: begin
			cs_trabajo = 0;
			wr_trabajo = 0;
			rd_trabajo = 1;
			end
		
		endcase
		
		
		
		end
//-------------------------------------------	

   
//-------------------------------------------
endcase
end	





endmodule
