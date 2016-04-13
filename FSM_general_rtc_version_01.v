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
	input in_sw1,
	input	in_sw2,

	output wire [1:0]out_funcion_conf,
	output reg [7:0]out_addr_ram_rtc,
	output reg [7:0]out_dato_inicio,
	output reg out_flag_inicio,
	output reg out_funcion_w_r,
	output reg out_en_funcion_rtc,
	output wire [3:0]q,
	output wire [2:0]state_now
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



assign q = q_reg;
assign out_funcion_conf = {in_sw2,in_sw1};

localparam  [2:0]
espera = 3'd0,
inicio = 3'd1,
escritura = 3'd2,
lectura_cte = 3'd3,
lectura_configuracion = 3'd4; 

  
//Descripción del comportamiento

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
 

assign state_now = state_reg;
always @(posedge clk, posedge reset) begin
	if (reset) flag_config = 0;
	else begin
		if (out_funcion_conf == 2'b00) flag_config = 1'b0;
		else flag_config = 1'b1;
	end

end
//////////////////////////
////logica secuencial
always @(posedge clk, posedge reset)
begin
  if (reset) begin 
     state_reg <= espera;
	  end
  else 
     state_reg <= state_next;
end

reg [1:0]reg_sel_bloque;
reg [1:0]next_sel_bloque;
always @(reg_sel_bloque , next_sel_bloque,reset) begin
	if (reset) reset_count = 1'b1;
	else begin
	if(reg_sel_bloque != next_sel_bloque) reset_count = 1'b1;
	else reset_count = 1'b0;
	end
	
end



////logica combinacional
always@*
	begin
	out_addr_ram_rtc = 8'h00;
	state_next = state_reg;	
	next_sel_bloque = reg_sel_bloque;
	case(state_reg)
		espera:  
			begin
			//sel_count = 2'd0;
			out_en_funcion_rtc = 0;
			//reset_count = 1'b1;
			state_next = inicio;
			out_flag_inicio = 1'b0;
			out_funcion_w_r = 1'b0;
			reg_hora_timer = 1'b0;
			out_addr_ram_rtc = 8'h00;
			out_dato_inicio  = 8'h00;
			reg_sel_bloque = 2'd0;
			end
			 
			
		inicio:
			begin
			//reset_count = 1'b0;
			reg_hora_timer = 1'b0;
			out_funcion_w_r = 1'b1;
			//sel_count = 2'd0;
			out_flag_inicio = 1'b1;
			out_en_funcion_rtc = 1'b1;
			reg_sel_bloque = 2'd0;
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
				 
				//reset_count = 1'b1;
				end
				4'd3: begin 
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
			
	///////////////////////////// BLOQUE DE ESCRITURA////////////////////////////////////		 
			
		escritura:
			
			begin
			reg_sel_bloque = 2'd3;
			//reset_count = 1'b0;
			out_funcion_w_r = 1'b1;
			//sel_count = 2'd0;
			out_flag_inicio = 1'b0;
			out_dato_inicio = 8'h00;
			//sel_count = 2'd2;
			out_en_funcion_rtc = 1'b1;
				/////escribe registros de hora
				if (~reg_hora_timer) begin
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
				out_en_funcion_rtc = 1'b0;
				out_addr_ram_rtc = 8'h00;
				//reset_count = 1'b1;
				end
				
				default: begin
				out_addr_ram_rtc = 8'h00;
				out_en_funcion_rtc = 1'b0;
				end
			endcase
			end
			///////////////escribe registros timer
			else begin
				case(q_reg)
				
				4'd0:out_addr_ram_rtc = 8'h41;
				4'd1: out_addr_ram_rtc = 8'h42;
				4'd2: out_addr_ram_rtc = 8'h43;
				4'd3: out_addr_ram_rtc = 8'hF2;
				
				
				4'd4: begin state_next = lectura_cte;
				//reset_count = 1'b1;
				out_en_funcion_rtc = 1'b0;
				out_addr_ram_rtc = 8'h00;
				end
				default: begin
				//reset_count = 1'b1;
				out_en_funcion_rtc = 1'b0;
				end
				endcase
			end
			end
////////////////////////////////////	BLOQUE DE LECTURA CONSTANTE //////////////////////////////////////		
		lectura_cte:
			begin 
			reg_sel_bloque = 2'd1;
			out_dato_inicio = 8'h00;
			out_flag_inicio = 1'b0;
			reg_hora_timer = 1'b0;
			out_funcion_w_r = 1'b0;
			//sel_count = 2'd3;
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
				
				4'd12:begin
				out_en_funcion_rtc = 1'b1;
				out_addr_ram_rtc = 8'h00;
				if (flag_config) state_next = lectura_configuracion;
				else state_next = lectura_cte;
				end
				
				default: begin
				out_funcion_w_r = 1'b0;
				out_en_funcion_rtc = 1'b1;
				out_addr_ram_rtc = 8'h00;
				end
				
			endcase
			end
/////////////////////////////// BLOQUE DE LECTURA EN MODO CONFIGURACION/////////////////////			
			lectura_configuracion:
			begin
			out_en_funcion_rtc = 1'b1;
			reg_sel_bloque = 2'd0;
			out_funcion_w_r = 1'b0;
			out_flag_inicio = 1'b0;
			//sel_count = 2'd1;
			out_dato_inicio = 8'h00;
			out_en_funcion_rtc = 1'b1;

			case (out_funcion_conf)
			2'd0:begin
					state_next = escritura;
					//reset_count = 1'b1;
					out_en_funcion_rtc = 1'b0;
					out_addr_ram_rtc = 8'h00;
			end
			/////////// CONFIGURANDO HORA
			2'd1: begin
				reg_hora_timer = 1'b0;
				case(q_reg)
				4'd0: out_addr_ram_rtc = 8'hF2;
				4'd1: out_addr_ram_rtc = 8'h41;
				4'd2: out_addr_ram_rtc = 8'h42;
				4'd3: begin 
					out_addr_ram_rtc = 8'h43;
					//reset_count = 1'b1;
						end
				
				default: begin
				out_en_funcion_rtc = 1'b0;
				out_addr_ram_rtc = 8'h00;
				end
				
				endcase
			end
			////// CONFIGURANDO FECHA
			2'd2: begin
				reg_hora_timer = 1'b0;
			case(q_reg)
				4'd0: out_addr_ram_rtc = 8'hF1; 
				4'd1: out_addr_ram_rtc = 8'h21;
				4'd2: out_addr_ram_rtc = 8'h22;
				4'd3: out_addr_ram_rtc = 8'h23;
				4'd4: out_addr_ram_rtc = 8'hF2;
				4'd5: out_addr_ram_rtc = 8'h41;
				4'd6: out_addr_ram_rtc = 8'h42; 
				4'd7: begin
					out_addr_ram_rtc = 8'h43; 
					//reset_count = 1'b1;
						end
						
				default: begin
				out_en_funcion_rtc = 1'b0;
				out_addr_ram_rtc = 8'h00;
				end
				
			endcase
			end
			////// CONFIGURANDO TIMER
			2'd3: begin
				reg_hora_timer = 1'b1;
				case(q_reg)
				4'd0: out_addr_ram_rtc = 8'hF1;
				4'd1: out_addr_ram_rtc = 8'h21;
				4'd2: out_addr_ram_rtc = 8'h22;
				4'd3: out_addr_ram_rtc = 8'h23; 
				4'd4: out_addr_ram_rtc = 8'h24;
				4'd5: out_addr_ram_rtc = 8'h25;
				4'd6: out_addr_ram_rtc = 8'h26;
				4'd7: begin out_addr_ram_rtc = 8'h27; 
				//reset_count = 1'b1;
				end
				
				default: begin
				out_en_funcion_rtc = 1'b0;
				out_addr_ram_rtc = 8'h00;
				end 
				endcase
			end
			endcase
		end
		default: begin state_next = espera;
		out_en_funcion_rtc = 1'b0;
		sel_count = 2'd0;
		reg_hora_timer = 1'b0;
		out_dato_inicio  = 8'h00;
		out_en_funcion_rtc = 1'b0;
		out_funcion_w_r = 1'b0;
		out_addr_ram_rtc = 8'h00;
		out_flag_inicio = 1'b0;
		end
endcase
end



endmodule
