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

	input wire clk,
	input wire rst,
	//input en,
	input wire[1:0]funcion,
	input wire [7:0]cuenta,//Senal del contador
	output wire a_d_out, //Senales de control RTC
	output wire cs_out,
	output wire wr_out,
	output wire rd_out,
	output wire [3:0]addr_logica_escribir_leer_out,
	output wire [7:0]addr_RAM_out,
	output wire funcion_r_w_out
	
    );
	 
//registros para de uso interno
reg [1:0]state,next_state;// lectura_total, lectura_sin_hora, lectura_sin_timer, lectura_sin_fecha;
reg a_d,cs,wr,rd,funcion_r_w;
reg [3:0]addr_logica_escribir_leer;
reg [7:0]addr_RAM;

localparam [1:0]
lectura_total = 2'b00,
lectura_sin_hora = 2'b01,
lectura_sin_fecha = 2'b10,
lectura_sin_timer = 2'b11;

//Asignaciones logicas

assign a_d_out = a_d;
assign cs_out = cs;
assign wr_out = wr;
assign rd_out = rd;
assign funcion_r_w_out = funcion_r_w;
assign addr_logica_escribir_leer_out = addr_logica_escribir_leer;
assign addr_RAM_out = addr_RAM;




////PAARTE COMBINACIONAL
always@(posedge clk,posedge rst)
	
	begin
	if (cuenta == 255) begin
		a_d = 0;
		cs = 0;
		rd = 0;
		wr = 0;
		funcion_r_w = 2'b0;
		addr_logica_escribir_leer = 8'd0; 
		addr_RAM = 8'd0;
	end
	else begin
		
		a_d =a_d;
		cs = cs;
		rd = rd;
		wr = wr;
		funcion_r_w = funcion_r_w;
		addr_logica_escribir_leer = addr_logica_escribir_leer; 
		addr_RAM = addr_RAM;
	end
	if(rst) begin
		state = lectura_total;
		end
	else state = next_state;
	end
		
////PARTE SECUENCIAL
always@*
begin


next_state = state;
	case(state)

//-------------------------------------------
/////////////////////////////////////////////
//////////////LECTURA_TOTAL///////////////
/////////////////////////////////////////////
//-------------------------------------------	
		lectura_total:
		
		begin
	
		
		case(funcion)
		2'b00: next_state = lectura_total;
		2'b01: next_state = lectura_sin_hora;
		2'b10: next_state = lectura_sin_fecha;
		2'b11: next_state = lectura_sin_timer;
		endcase
		case(cuenta)
		
////Actualizacion de datos		
		8'd0: addr_RAM = 8'hF1;
		8'd1: a_d = 0;
		8'd2: begin
			cs = 0;
			wr = 0;
			rd = 1;
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
			
		8'd6: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
			
		8'd7: a_d=1;
			
		8'd9: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
			
		8'd13: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd17: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
			
/////////Prosedimiento para leer registro 01			
		8'd22: addr_RAM = 8'h01;
		8'd23: a_d = 0;
		8'd24: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd25: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd28: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd29: begin
			a_d = 1;
			end
		8'd32: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd33: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b1010;
			end
		8'd36: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd37: begin
			a_d = 0;
			funcion_r_w =0;
			addr_logica_escribir_leer = 4'b1111;
			end

/////////Prosedimiento para leer registro 21		
		8'd42: addr_RAM = 8'h21;
		8'd43: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd44: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd47: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd48: begin
			a_d = 1;
			end
		8'd54: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd56: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0000;
			end
		8'd58: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd59: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			funcion_r_w = 0;
			end
/////////Prosedimiento para leer registro 22		
		8'd64: addr_RAM = 8'h22;
		8'd65: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd66: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd69: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd70: begin
			a_d = 1;
			end
		8'd77: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd78: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0001;
			end
		8'd81: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd82: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end

/////////Prosedimiento para leer registro 23		
		8'd86: addr_RAM = 8'h23;
		8'd87: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd89: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd91: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd92: begin
			a_d = 1;
			end
		8'd99: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd100: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0010;
			end
		8'd103: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd104: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
		
		
/////////Prosedimiento para leer registro 24	
		8'd111: addr_RAM = 8'h24;
		8'd112: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd113: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd116: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd117: begin
			a_d = 1;
			end
		8'd124: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd125: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0100;
			end
		8'd128: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd129: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
/////////Prosedimiento para leer registro 25	
		8'd136: addr_RAM = 8'h25;
		8'd137: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd138: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd141: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd142: begin
			a_d = 1;
			end
		8'd149: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd150: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0101;
			end
		8'd153: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd154: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
/////////Prosedimiento para leer registro 26	
		8'd161: addr_RAM = 8'h26;
		8'd162: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd163: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd166: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd167: begin
			a_d = 1;
			end
		8'd174: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd175: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0100;
			end
		8'd178: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd179: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
///////Secuencia para espacio de memoria 27
		8'd186: addr_RAM = 8'h27;
		8'd187: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd189: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd191: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd192: begin
			a_d = 1;
			end
		8'd199: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd200: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0011;
			end
		8'd203: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd204: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end				
	
/////////Prosedimiento para leer registro 41	
		8'd209: addr_RAM = 8'h41;
		8'd210: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd211: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd214: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd215: begin
			a_d = 1;
			end
		8'd222: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd223: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b01111;
			end
		8'd226: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd227: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end

/////////Prosedimiento para leer registro 42	
		8'd234: addr_RAM = 8'h42;
		8'd235: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd236: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd239: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd240: begin
			a_d = 1;
			end
		8'd247: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd249: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b1000;
			end
		8'd251: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd252: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end				
		

/////////Prosedimiento para leer registro 43	
		8'd259: addr_RAM = 8'h43;
		8'd260: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd261: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd264: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd265: begin
			a_d = 1;
			end
		8'd272: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd273: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b1001;
			end
		8'd276: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd277: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
		
		endcase
		
		end
//-------------------------------------------
/////////////////////////////////////////////
//////////////LECTURA_SIN_HORA///////////////
/////////////////////////////////////////////
//-------------------------------------------	
	lectura_sin_hora:
		begin
	
		
		case(funcion)
		2'b00: next_state = lectura_total;
		2'b01: next_state = lectura_sin_hora;
		2'b10: next_state = lectura_sin_fecha;
		2'b11: next_state = lectura_sin_timer;
		endcase
		
		case(cuenta)
		
////Actualizacion de datos		
		8'd0: addr_RAM = 8'hF1;
		8'd1: a_d = 0;
		8'd2: begin
			cs = 0;
			wr = 0;
			rd = 1;
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
			
		8'd6: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
			
		8'd7: a_d=1;
			
		8'd9: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
			
		8'd13: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd17: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
			
/////////Prosedimiento para leer registro 01			
		8'd22: addr_RAM = 8'h01;
		8'd23: a_d = 0;
		8'd24: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd25: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd28: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd29: begin
			a_d = 1;
			end
		8'd32: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd33: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b1010;
			end
		8'd36: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd37: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end

		
/////////Prosedimiento para leer registro 24	
		8'd111: addr_RAM = 8'h24;
		8'd112: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd113: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd116: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd117: begin
			a_d = 1;
			end
		8'd124: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd125: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0100;
			end
		8'd128: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd129: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
/////////Prosedimiento para leer registro 25	
		8'd136: addr_RAM = 8'h25;
		8'd137: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd138: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd141: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd142: begin
			a_d = 1;
			end
		8'd149: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd150: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0101;
			end
		8'd153: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd154: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
/////////Prosedimiento para leer registro 26	
		8'd161: addr_RAM = 8'h26;
		8'd162: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd163: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd166: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd167: begin
			a_d = 1;
			end
		8'd174: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd175: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0100;
			end
		8'd178: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd179: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
///////Secuencia para espacio de memoria 27
		8'd186: addr_RAM = 8'h27;
		8'd187: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd189: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd191: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd192: begin
			a_d = 1;
			end
		8'd199: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd200: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0011;
			end
		8'd203: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd204: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end				
	
/////////Prosedimiento para leer registro 41	
		8'd209: addr_RAM = 8'h41;
		8'd210: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd211: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd214: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd215: begin
			a_d = 1;
			end
		8'd222: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd223: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b01111;
			end
		8'd226: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd227: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end

/////////Prosedimiento para leer registro 42	
		8'd234: addr_RAM = 8'h42;
		8'd235: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd236: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd239: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd240: begin
			a_d = 1;
			end
		8'd247: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd249: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b1000;
			end
		8'd251: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd252: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end				
		

/////////Prosedimiento para leer registro 43	
		8'd259: addr_RAM = 8'h43;
		8'd260: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd261: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd264: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd265: begin
			a_d = 1;
			end
		8'd272: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd273: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b1001;
			end
		8'd276: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd277: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end				
		endcase
		
		
		
		
		end
//-------------------------------------------
/////////////////////////////////////////////
//////////////LECTURA_SIN_FECHA///////////////
/////////////////////////////////////////////
//-------------------------------------------
	lectura_sin_fecha:
		begin

		
		case(funcion)
		2'b00: next_state = lectura_total;
		2'b01: next_state = lectura_sin_hora;
		2'b10: next_state = lectura_sin_fecha;
		2'b11: next_state = lectura_sin_timer;
		endcase
		case(cuenta)
		
////Actualizacion de datos		
		8'd0: addr_RAM = 8'hF1;
		8'd1: a_d = 0;
		8'd2: begin
			cs = 0;
			wr = 0;
			rd = 1;
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
			
		8'd6: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
			
		8'd7: a_d=1;
			
		8'd9: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
			
		8'd13: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd17: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
			
/////////Prosedimiento para leer registro 01			
		8'd22: addr_RAM = 8'h01;
		8'd23: a_d = 0;
		8'd24: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd25: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd28: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd29: begin
			a_d = 1;
			end
		8'd32: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd33: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b1010;
			end
		8'd36: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd37: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end

/////////Prosedimiento para leer registro 21		
		8'd42: addr_RAM = 8'h21;
		8'd43: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd44: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd47: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd48: begin
			a_d = 1;
			end
		8'd54: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd56: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0000;
			end
		8'd58: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd59: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
/////////Prosedimiento para leer registro 22		
		8'd64: addr_RAM = 8'h22;
		8'd65: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd66: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd69: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd70: begin
			a_d = 1;
			end
		8'd77: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd78: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0001;
			end
		8'd81: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd82: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end

/////////Prosedimiento para leer registro 23		
		8'd86: addr_RAM = 8'h23;
		8'd87: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd89: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd91: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd92: begin
			a_d = 1;
			end
		8'd99: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd100: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0010;
			end
		8'd103: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd104: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
		

/////////Prosedimiento para leer registro 41	
		8'd209: addr_RAM = 8'h41;
		8'd210: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd211: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd214: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd215: begin
			a_d = 1;
			end
		8'd222: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd223: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b01111;
			end
		8'd226: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd227: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end

/////////Prosedimiento para leer registro 42	
		8'd234: addr_RAM = 8'h42;
		8'd235: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd236: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd239: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd240: begin
			a_d = 1;
			end
		8'd247: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd249: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b1000;
			end
		8'd251: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd252: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end				
		

/////////Prosedimiento para leer registro 43	
		8'd259: addr_RAM = 8'h43;
		8'd260: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd261: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd264: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd265: begin
			a_d = 1;
			end
		8'd272: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd273: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b1001;
			end
		8'd276: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd277: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end				
			
		
		endcase
		
		
		
		end
//-------------------------------------------
/////////////////////////////////////////////
//////////////LECTURA_SIN_TIMER///////////////
/////////////////////////////////////////////
//-------------------------------------------
	lectura_sin_timer:
		begin
	
		
		case(funcion)
		2'b00: next_state = lectura_total;
		2'b01: next_state = lectura_sin_hora;
		2'b10: next_state = lectura_sin_fecha;
		2'b11: next_state = lectura_sin_timer;
		endcase
		case(cuenta)
		
////Actualizacion de datos		
		8'd0: addr_RAM = 8'hF1;
		8'd1: a_d = 0;
		8'd2: begin
			cs = 0;
			wr = 0;
			rd = 1;
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
			
		8'd6: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
			
		8'd7: a_d=1;
			
		8'd9: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
			
		8'd13: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd17: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
			
/////////Prosedimiento para leer registro 01			
		8'd22: addr_RAM = 8'h01;
		8'd23: a_d = 0;
		8'd24: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd25: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd28: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd29: begin
			a_d = 1;
			end
		8'd32: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd33: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b1010;
			end
		8'd36: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd37: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end

/////////Prosedimiento para leer registro 21		
		8'd42: addr_RAM = 8'h21;
		8'd43: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd44: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd47: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd48: begin
			a_d = 1;
			end
		8'd54: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd56: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0000;
			end
		8'd58: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd59: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
/////////Prosedimiento para leer registro 22		
		8'd64: addr_RAM = 8'h22;
		8'd65: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd66: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd69: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd70: begin
			a_d = 1;
			end
		8'd77: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd78: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0001;
			end
		8'd81: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd82: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end

/////////Prosedimiento para leer registro 23		
		8'd86: addr_RAM = 8'h23;
		8'd87: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd89: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd91: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end 
		8'd92: begin
			a_d = 1;
			end
		8'd99: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd100: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0010;
			end
		8'd103: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd104: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
		
		
/////////Prosedimiento para leer registro 24	
		8'd111: addr_RAM = 8'h24;
		8'd112: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd113: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd116: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd117: begin
			a_d = 1;
			end
		8'd124: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd125: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0100;
			end
		8'd128: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd129: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
/////////Prosedimiento para leer registro 25	
		8'd136: addr_RAM = 8'h25;
		8'd137: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd138: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd141: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd142: begin
			a_d = 1;
			end
		8'd149: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd150: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0101;
			end
		8'd153: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd154: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
/////////Prosedimiento para leer registro 26	
		8'd161: addr_RAM = 8'h26;
		8'd162: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd163: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd166: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd167: begin
			a_d = 1;
			end
		8'd174: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd175: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0100;
			end
		8'd178: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd179: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
///////Secuencia para espacio de memoria 27
		8'd186: addr_RAM = 8'h27;
		8'd187: begin
			cs = 0;
			wr = 0;
			rd = 1;
			end
		8'd189: begin
			funcion_r_w = 0;
			addr_logica_escribir_leer = 4'b1011;
			end
		8'd191: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd192: begin
			a_d = 1;
			end
		8'd199: begin
			cs = 0;
			wr = 1;
			rd = 0;
			end
		8'd200: begin
			funcion_r_w = 1;
			addr_logica_escribir_leer = 4'b0011;
			end
		8'd203: begin
			cs = 1;
			wr = 1;
			rd = 1;
			end
		8'd204: begin
			a_d = 0;
			addr_logica_escribir_leer = 4'b1111;
			end
	
		
		endcase
		
		
		
		
		end
   
//-------------------------------------------
endcase
end	





endmodule
