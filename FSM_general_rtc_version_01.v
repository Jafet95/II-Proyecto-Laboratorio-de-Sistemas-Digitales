`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:54:44 04/10/2016 
// Design Name: 
// Module Name:    FSM_general_rtc_version_01 
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
module FSM_general_rtc_version_01(	
 	
	input clk,
	input reset,
	input in_flag_done,
	input in_sw0,
	input in_sw1,
	input	in_sw2,

	output wire [2:0]out_funcion_conf,
	output reg [7:0]out_addr_ram_rtc,
	output reg [7:0]out_dato_inicio,
	output reg out_flag_inicio,
	output reg out_funcion_w_r,
	output reg out_en_funcion_rtc
    );
	 
//////////parametros locales	 
localparam E = 3; 
	 
localparam N = 4;
// Declaración de señales
reg [N-1:0] q_reg;
reg [N-1:0] q_next = 4'd0;
reg [E-1:0]state_reg, state_next;
reg reset_count;
reg reg_hora_timer;
reg flag_config;
reg [1:0]sel_count;
reg [2:0]reg_sel_bloque;
reg [2:0]next_sel_bloque;

assign out_funcion_conf = {in_sw2,in_sw1,in_sw0};

localparam  [3:0]
espera = 4'd0,
inicio = 4'd1,
lectura_cte = 4'd2,
lectura_configuracion_hora = 4'd3,
lectura_configuracion_fecha = 4'd4,
lectura_configuracion_timer = 4'd5,
escritura_hora_fecha = 4'd6,
escritura_timer = 4'd7; 

 //////////////// contador para FSM (avanza cada vez que llega la bandera in_flag_done) 
always @(posedge clk, posedge reset_count)
begin
	if (reset_count) q_reg = 1'b0;
	else q_reg = q_next;
end
always@*
begin
if (in_flag_done) begin
	q_next = q_reg + 1'b1;
end
else q_next = q_reg;
end
 
//////////////////////////
////logica secuencial
always @(posedge clk, posedge reset)
begin
  if (reset) begin 
     state_reg <= espera;
	  end
  else begin
     state_reg <= state_next;
	  reg_sel_bloque = next_sel_bloque;
	  end
end

always @* begin
	if(reg_sel_bloque != next_sel_bloque) reset_count = 1'b1;
	else reset_count = 1'b0;
end

////logica combinacional
always@*
	begin
	out_addr_ram_rtc = 8'h00;
	state_next = state_reg;	
	
	case(state_reg)
		espera:  
			begin
			out_en_funcion_rtc = 0;
			state_next = inicio;
			out_flag_inicio = 1'b0;
			out_funcion_w_r = 1'b0;
			out_addr_ram_rtc = 8'h00;
			out_dato_inicio  = 8'h00;
			next_sel_bloque = 3'd0;
			end
			 
		inicio:
			begin
			out_funcion_w_r = 1'b1;
			out_flag_inicio = 1'b1;
			out_en_funcion_rtc = 1'b1;
			next_sel_bloque = 3'd1;
			case(q_reg) 
				4'd0:begin
				out_addr_ram_rtc = 8'h02;
				out_dato_inicio = 8'h10;
				end
				4'd1:
				begin 
				out_addr_ram_rtc = 8'h02;
				out_dato_inicio = 8'h00;
				end 
				4'd2: begin
				out_addr_ram_rtc = 8'h10;
				out_dato_inicio = 8'hD2;
				end
				4'd3: begin
				out_addr_ram_rtc = 8'h0;
				out_dato_inicio = 8'h00;
				end
				4'd4: begin
				out_addr_ram_rtc = 8'h21;
				out_dato_inicio = 8'h00;
				end
				4'd5: begin
				out_addr_ram_rtc = 8'h22;
				out_dato_inicio = 8'h00;
				end
				4'd6: begin
				out_addr_ram_rtc = 8'h23;
				out_dato_inicio = 8'h00;
				end
				4'd7: begin
				out_addr_ram_rtc = 8'h24;
				out_dato_inicio = 8'h00;
				end
				4'd8: begin
				out_addr_ram_rtc = 8'h25;
				out_dato_inicio = 8'h00;
				end
				4'd9: begin
				out_addr_ram_rtc = 8'h26;
				out_dato_inicio = 8'h00;
				end
				4'd10: begin
				out_addr_ram_rtc = 8'h27;
				out_dato_inicio = 8'h00;
				end
				4'd11: begin
				out_addr_ram_rtc = 8'hF1;
				out_dato_inicio = 8'h00;
				end
				4'd12: begin 
				state_next = lectura_cte;
				out_en_funcion_rtc = 1'b0;
				out_addr_ram_rtc = 8'h00;
				out_dato_inicio = 8'h00;
				state_next = lectura_cte; 
				end 
				default: begin 
				out_en_funcion_rtc = 1'b0;
				out_addr_ram_rtc = 8'h00;
				out_dato_inicio = 8'h00;
				end
			endcase 
			end	
			
	///////////////////////////// BLOQUE DE ESCRITURA HORA FECHA////////////////////////////////////		 
			
		escritura_hora_fecha:
			begin
			next_sel_bloque = 3'd6;
			out_funcion_w_r = 1'b1;
			out_flag_inicio = 1'b0;
			out_dato_inicio = 8'h00;
			out_en_funcion_rtc = 1'b1;
				case(q_reg)
				4'd0: out_addr_ram_rtc = 8'h21;
				4'd1: out_addr_ram_rtc = 8'h22;
				4'd2: out_addr_ram_rtc = 8'h23;
				4'd3: out_addr_ram_rtc = 8'h24;
				4'd4: out_addr_ram_rtc = 8'h25;
				4'd5: out_addr_ram_rtc = 8'h26;
				4'd6: out_addr_ram_rtc = 8'h27;
				4'd7:	out_addr_ram_rtc = 8'hF1;
				4'd8: begin state_next = lectura_cte;
				out_addr_ram_rtc = 8'h00;
				end
				
				default: begin
				out_addr_ram_rtc = 8'h00;
				out_en_funcion_rtc = 1'b0;
				end
			endcase
			end
			
			
////////////////////////////////////////////////////
///////////////////////////// BLOQUE DE ESCRITURA TIMER////////////////////////////////////		 
			
		escritura_timer:
			begin
			next_sel_bloque = 3'd7;
			out_funcion_w_r = 1'b1;
			out_flag_inicio = 1'b0;
			out_dato_inicio = 8'h00;
			out_en_funcion_rtc = 1'b1;	
				case(q_reg)
				4'd0:out_addr_ram_rtc = 8'h41;
				4'd1: out_addr_ram_rtc = 8'h42;
				4'd2: out_addr_ram_rtc = 8'h43;
				4'd3: out_addr_ram_rtc = 8'hF2;
				4'd4: begin 
				out_flag_inicio = 1'b1;
				out_addr_ram_rtc = 8'h0;
				out_dato_inicio = 8'h08;
				end
				4'd5: begin state_next = lectura_cte;
				out_addr_ram_rtc = 8'h00;
				end
				default: out_en_funcion_rtc = 1'b0;
				endcase
			end
////////////////////////////////////	BLOQUE DE LECTURA CONSTANTE //////////////////////////////////////		
		lectura_cte:
			begin 
			next_sel_bloque = 2'd2;
			out_dato_inicio = 8'h00;
			out_flag_inicio = 1'b0;
			out_funcion_w_r = 1'b0;
			out_en_funcion_rtc = 1'b1;
				case(q_reg)
				4'd0: out_addr_ram_rtc = 8'hF0;
				4'd1: out_addr_ram_rtc = 8'h21;
				4'd2: out_addr_ram_rtc = 8'h22;
				4'd3: out_addr_ram_rtc = 8'h23;
				4'd4: out_addr_ram_rtc = 8'h24;
				4'd5: out_addr_ram_rtc = 8'h25;
				4'd6: out_addr_ram_rtc = 8'h26; 
				4'd7: out_addr_ram_rtc = 8'h27;
				4'd8: out_addr_ram_rtc = 8'h41;
				4'd9: out_addr_ram_rtc = 8'h42;
				4'd10: out_addr_ram_rtc = 8'h43;
				4'd11:begin
				out_en_funcion_rtc = 1'b1;
				out_addr_ram_rtc = 8'h00;
				case(out_funcion_conf)
				3'b001: state_next = lectura_configuracion_hora;
				3'b010: state_next = lectura_configuracion_fecha;
				3'b100: state_next = lectura_configuracion_timer;
				default: state_next = lectura_cte;
				endcase
				end
				default: begin
				out_funcion_w_r = 1'b0;
				out_en_funcion_rtc = 1'b1;
				out_addr_ram_rtc = 8'h00;
				end
				
			endcase
			end
/////////////////////////////// BLOQUE DE LECTURA EN MODO CONFIGURACION/////////////////////			
			lectura_configuracion_hora:
			begin
			out_en_funcion_rtc = 1'b1;
			next_sel_bloque = 3'd3;
			out_funcion_w_r = 1'b0;
			out_flag_inicio = 1'b0;
			out_dato_inicio = 8'h00;
			out_en_funcion_rtc = 1'b1;
				case(q_reg)
				4'd0: out_addr_ram_rtc = 8'hF2;
				4'd1: out_addr_ram_rtc = 8'h41;
				4'd2: out_addr_ram_rtc = 8'h42;
				4'd3: out_addr_ram_rtc = 8'h43;
				4'd4: begin
				if (out_funcion_conf == 3'b000) state_next = escritura_hora_fecha;
				else state_next = lectura_configuracion_hora;
				end
				default: begin
				out_en_funcion_rtc = 1'b0;
				out_addr_ram_rtc = 8'h00;
				end
				endcase
			end
			
			lectura_configuracion_fecha: 
			begin
			out_en_funcion_rtc = 1'b1;
			next_sel_bloque = 3'd4;
			out_funcion_w_r = 1'b0;
			out_flag_inicio = 1'b0;
			out_dato_inicio = 8'h00;
			out_en_funcion_rtc = 1'b1;
			case(q_reg)
				4'd0: out_addr_ram_rtc = 8'hF1; 
				4'd1: out_addr_ram_rtc = 8'h21;
				4'd2: out_addr_ram_rtc = 8'h22;
				4'd3: out_addr_ram_rtc = 8'h23;
				4'd4: out_addr_ram_rtc = 8'hF2;
				4'd5: out_addr_ram_rtc = 8'h41;
				4'd6: out_addr_ram_rtc = 8'h42; 
				4'd7: out_addr_ram_rtc = 8'h43;
				4'd8:begin if (out_funcion_conf == 3'b000) state_next = escritura_hora_fecha;
				else state_next = lectura_configuracion_fecha;
				end
				default: begin
				out_en_funcion_rtc = 1'b0;
				out_addr_ram_rtc = 8'h00;
				end
				endcase
			end
			//////////
			lectura_configuracion_timer:begin
			out_en_funcion_rtc = 1'b1;
			next_sel_bloque = 3'd5;
			out_funcion_w_r = 1'b0;
			out_flag_inicio = 1'b0;
			out_dato_inicio = 8'h00;
			out_en_funcion_rtc = 1'b1;
			case(q_reg)
				4'd0: out_addr_ram_rtc = 8'hF1;
				4'd1: out_addr_ram_rtc = 8'h21;
				4'd2: out_addr_ram_rtc = 8'h22;
				4'd3: out_addr_ram_rtc = 8'h23; 
				4'd4: out_addr_ram_rtc = 8'h24;
				4'd5: out_addr_ram_rtc = 8'h25;
				4'd6: out_addr_ram_rtc = 8'h26;
				4'd7: out_addr_ram_rtc = 8'h27; 
				4'd8: begin
				if(out_funcion_conf == 3'b000) state_next = escritura_timer;
				else state_next = lectura_configuracion_timer;
				end
				default: begin
				out_en_funcion_rtc = 1'b0;
				out_addr_ram_rtc = 8'h00;
				end 
				endcase
		end
		default: begin state_next = espera;
		out_en_funcion_rtc = 1'b0;
		sel_count = 2'd0;
		next_sel_bloque = 3'd0;
		out_dato_inicio  = 8'h00;
		out_en_funcion_rtc = 1'b0;
		out_funcion_w_r = 1'b0;
		out_addr_ram_rtc = 8'h00;
		out_flag_inicio = 1'b0;
		end
endcase
end



endmodule

