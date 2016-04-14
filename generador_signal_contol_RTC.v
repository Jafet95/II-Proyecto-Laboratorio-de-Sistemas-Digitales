`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:47:36 04/14/2016 
// Design Name: 
// Module Name:    generador_signal_contol_RTC 
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
module generador_signal_contol_RTC(
	input wire clk,
	input wire reset,
	input wire in_escribir_leer,
	input wire en_funcion,
	
	output reg reg_a_d, //Senales de control RTC
	output reg reg_cs,
	output reg reg_wr,
	output reg reg_rd,
	output reg out_flag_capturar_dato,
	output reg out_direccion_dato,
	output reg reg_funcion_r_w,
	output wire flag_done,
	output wire [4:0]q 
	  
    ); 
/////parametros de estado
localparam
espera = 1'b1,
leer_escribir = 1'b0;
	 
// Bits del contador para generar una señal periódica de (2^N)*10ns
localparam N = 5;


// Declaración de señales
reg [N-1:0] q_reg;
reg [N-1:0] q_next;
reg state_reg, state_next;
reg reset_count;

//Descripción del comportamiento

//=============================================
// Contador para generar un pulso de(2^N)*10ns
//=============================================
always @(posedge clk, posedge reset_count)
begin
    if (reset_count) q_reg <= 0;
	 else  q_reg <= q_next;	 
end
always@*
begin
q_next <= q_reg + 1'b1;
end



// Pulso de salida
assign flag_done = (q_reg == 20) ? 1'b1 : 1'b0;//Tbandera fin de proseso
assign q = q_reg;

 
///logica secuencial
always @(posedge clk, posedge reset)
begin
  if (reset)
     state_reg <= espera;
  else
     state_reg <= state_next;
end
// Lógica de estado siguiente y salida
  always@*
   begin
	

	state_next = state_reg;  // default state: the same
	
	
	case(state_reg)
	espera:
	
		begin
			reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			reg_a_d = 1'b1;
			reg_funcion_r_w = 1'b0;
			out_direccion_dato = 1'b0;
			reset_count = 1'b1;
			out_flag_capturar_dato = 1'b0;
			if(en_funcion)
			begin
			state_next = leer_escribir;
			end

			else
			begin
			state_next = espera;

			end
		end
		
	leer_escribir:
	begin
	reset_count = 1'b0;
	//Proseso de lectura_escritura	
	case(q_reg)
		5'd0: begin //inicia 
			reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_rd = 1'b1;
			reg_wr = 1'b1;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
			out_direccion_dato = 1'b0;
		end 
		5'd1: begin // baja salida a_d
			reg_a_d = 1'b0;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b0;
		end
		
		5'd2: begin// baja cs con wr o rd incio de manipulacion del bis de datos
			reg_a_d = 1'b0;
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
		5'd3: begin
			reg_a_d = 1'b0;
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
		end
		5'd4: begin
			reg_a_d = 1'b0;
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
		end
		5'd5: begin
			reg_a_d = 1'b0;
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
		end
		
		5'd6: begin
			reg_a_d = 1'b0;
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			
		5'd7:begin 
			reg_a_d = 1'b0;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
		end
		5'd8: begin
			reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
		end
		5'd9: begin
			reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end
		5'd10: begin
			reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end
		5'd11: begin
			reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
			end
		5'd12: begin
			reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end
		5'd13: begin
			reg_a_d = 1'b1;
			out_direccion_dato = 1'b1;
			if (in_escribir_leer)begin
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			else begin
			reg_cs = 1'b0;
			reg_wr = 1'b1;
			reg_rd = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end
		end
		5'd14:begin
			reg_a_d = 1'b1;
			out_direccion_dato = 1'b1;
			if (in_escribir_leer)begin
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			else begin
			reg_cs = 1'b0;
			reg_wr = 1'b1;
			reg_rd = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end
		end
		5'd15:begin
			reg_a_d = 1'b1;
			out_direccion_dato = 1'b1;
			if (in_escribir_leer)begin
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			else begin
			reg_cs = 1'b0;
			reg_wr = 1'b1;
			reg_rd = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
			end
		end
		5'd16: begin
			reg_a_d = 1'b1;
			out_direccion_dato = 1'b1;
			if (in_escribir_leer)begin
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			else begin
			reg_cs = 1'b0;
			reg_wr = 1'b1;
			reg_rd = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end
		end
		5'd17: begin
			reg_a_d = 1'b1;
			out_direccion_dato = 1'b1;
			if (in_escribir_leer)begin
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			else begin
			reg_cs = 1'b0;
			reg_wr = 1'b1;
			reg_rd = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end
		end
		5'd18: begin
			reg_a_d = 1'b1;
			out_direccion_dato = 1'b1;
			if (in_escribir_leer)begin
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			else begin
			reg_cs = 1'b0;
			reg_wr = 1'b1;
			reg_rd = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end end
		
		5'd19: begin reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b1;
			if (in_escribir_leer)begin
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			else begin
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
			end
			end
		5'd20:
		begin reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
			
		end
		
		default: begin 
		state_next = leer_escribir;
		reg_a_d = 1'b1;
		reg_cs =  1'b1;
		reg_rd =  1'b1;
		reg_wr =  1'b1;
		out_direccion_dato =  1'b0;
		reg_funcion_r_w =  1'b0;
		out_flag_capturar_dato = 1'b0;
		end 
		endcase	 
	end
	default: begin
	state_next = espera;
	reg_cs = 1'd1;
	reg_a_d = 1'd1;
	reg_wr = 1'd1;
	reg_rd = 1'd1;
	reg_funcion_r_w = 1'd0;
	out_direccion_dato = 1'd0;
	end
	endcase
	
   end

endmodule