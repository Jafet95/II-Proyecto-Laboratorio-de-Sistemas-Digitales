`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:56:06 04/04/2016 
// Design Name: 
// Module Name:    Lector_RTC 
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
module Lector_RTC(

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
	output wire [3:0]q 
	  
    ); 
/////parametros de estado
localparam
espera = 1'b1,
leer_escribir = 1'b0;
	 
// Bits del contador para generar una señal periódica de (2^N)*10ns
localparam N = 4;


// Declaración de señales
reg [N-1:0] q_reg;
reg [N-1:0] q_next;
reg state_reg, state_next;
reg reset_count;

reg fake_a_d;
reg fake_cs;
reg fake_rd;
reg fake_wr;
reg fake_out_direccion_dato;
reg fake_funcion_r_w;
always@(posedge clk , posedge reset) begin
	if (reset) begin
			fake_a_d = 1'b0;
			fake_cs= 1'b0;
			fake_rd= 1'b0;
			fake_wr= 1'b0;
			fake_out_direccion_dato= 1'b0;
			fake_funcion_r_w= 1'b0;
		end
	else begin
			fake_a_d = reg_a_d;
			fake_cs= reg_cs;
			fake_rd= reg_rd;
			fake_wr= reg_wr;
			fake_out_direccion_dato= out_direccion_dato;	
			fake_funcion_r_w= reg_funcion_r_w;
	end
	
end


//reg reg_a_d; //Senales de control RTC 
//assign out_a_d = reg_a_d; 
/*
reg reg_cs,
reg reg_wr,
reg reg_rd,
reg out_flag_capturar_dato,
reg out_direccion_dato,
	//output reg [3:0]reg_addr_logica_escribir_leer,
	//output reg [7:0]reg_addr_RAM,
reg reg_funcion_r_w,
reg out_flag_inicio, 
*/


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
assign flag_done = (q_reg == 15) ? 1'b1 : 1'b0;//Tbandera fin de proseso
assign q = q_reg;
/*
always@(posedge clk) begin
	if(en_funcion) begin
	
	out_flag_capturar_dato = 1'b1;
	end
	else begin
	
	out_flag_capturar_dato = 1'b0;
	end
end
*/
 
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
			//state_next = espera;
//	reg_addr_RAM = 8'd0;
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
		4'd0: begin //inicia 
			reg_a_d = 1'b1;
			out_direccion_dato = 1'b0;
			reg_cs = 1'b1;
			reg_rd = 1'b1;
			reg_wr = 1'b1;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b0;
		end 
		4'd1: begin // baja salida a_d
			reg_a_d = 1'b0;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b0;
		end
		
		4'd2: begin// baja cs con wr o rd incio de manipulacion del bis de datos
			reg_a_d = 1'b0;
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			out_direccion_dato = fake_out_direccion_dato;
			reg_funcion_r_w = fake_funcion_r_w;
			out_flag_capturar_dato = 1'b1;
			end
		4'd3: begin
		reg_a_d = fake_a_d;
		reg_cs = fake_cs;
		reg_rd = fake_rd;
		reg_wr = fake_wr;
		out_direccion_dato = fake_out_direccion_dato;
		reg_funcion_r_w = fake_funcion_r_w;
		out_flag_capturar_dato = 1'b1;
		end
		4'd4: begin
		reg_a_d = fake_a_d;
		reg_cs = fake_cs;
		reg_rd = fake_rd;
		reg_wr = fake_wr;
		out_direccion_dato = fake_out_direccion_dato;
		reg_funcion_r_w = fake_funcion_r_w;
		out_flag_capturar_dato = 1'b1;
		end
		4'd5: begin
		reg_a_d = fake_a_d;
		reg_cs = fake_cs;
		reg_rd = fake_rd;
		reg_wr = fake_wr;
		out_direccion_dato = fake_out_direccion_dato;
		reg_funcion_r_w = fake_funcion_r_w;
		out_flag_capturar_dato = 1'b1;
		end
		
		4'd6: begin// sube cs fin de periodo de manipulacion de dato
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			reg_a_d = fake_a_d;
			out_direccion_dato = fake_out_direccion_dato;
			reg_funcion_r_w = fake_funcion_r_w;
			out_flag_capturar_dato = 1'b0;
			end
			
		4'd7:begin reg_a_d=1'b1;
		out_direccion_dato = 1'b1;
		reg_funcion_r_w = fake_funcion_r_w;
		reg_cs = fake_cs;
		reg_rd = fake_rd;
		reg_wr = fake_wr;
		out_flag_capturar_dato = 1'b0;
		end
		4'd8: begin
		reg_a_d = fake_a_d;
		reg_cs = fake_cs;
		reg_rd = fake_rd;
		reg_wr = fake_wr;
		out_direccion_dato = fake_out_direccion_dato;
		reg_funcion_r_w = fake_funcion_r_w;
		out_flag_capturar_dato = 1'b0;
		end
		4'd9: begin
		reg_a_d = fake_a_d;
		reg_cs = fake_cs;
		reg_rd = fake_rd;
		reg_wr = fake_wr;
		out_direccion_dato = fake_out_direccion_dato;
		reg_funcion_r_w = fake_funcion_r_w;
		out_flag_capturar_dato = 1'b0;
		end
		4'd10: begin
		reg_a_d = fake_a_d;
		reg_cs = fake_cs;
		reg_rd = fake_rd;
		reg_wr = fake_wr;
		out_direccion_dato = fake_out_direccion_dato;
		reg_funcion_r_w = fake_funcion_r_w;
		out_flag_capturar_dato = 1'b0;
		end
		4'd11: begin
			//if (in_flag_inicio) out_flag_inicio = 1'b1;
			//else out_flag_inicio = 1'b0;
			out_flag_capturar_dato = 1'b1;
			reg_a_d = fake_a_d;
			out_direccion_dato = fake_out_direccion_dato;
			if (in_escribir_leer)begin
			out_direccion_dato = fake_out_direccion_dato;
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			reg_funcion_r_w = 1'b1;
			end
			else begin
			reg_cs = 1'b0;
			reg_wr = 1'b1;
			reg_rd = 1'b0;
			reg_funcion_r_w = 1'b0;
			end
			end
		4'd12: begin
		out_flag_capturar_dato = 1'b1;
		reg_a_d = fake_a_d;
		reg_cs = fake_cs;
		reg_rd = fake_rd;
		reg_wr = fake_wr;
		out_direccion_dato = fake_out_direccion_dato;
		reg_funcion_r_w = fake_funcion_r_w;
		end
		4'd13: begin
		out_flag_capturar_dato = 1'b1;
		reg_a_d = fake_a_d;
		reg_cs = fake_cs;
		reg_rd = fake_rd;
		reg_wr = fake_wr;
		out_direccion_dato = fake_out_direccion_dato;
		reg_funcion_r_w = fake_funcion_r_w;
		end
		4'd14: begin
			//if (in_flag_inicio) out_flag_inicio = 1'b1;
			//else out_flag_inicio = 1'b0;
			out_flag_capturar_dato = 1'b0;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			reg_a_d = fake_a_d;
			out_direccion_dato = fake_out_direccion_dato;
		reg_funcion_r_w = fake_funcion_r_w;
			end
		4'd15: begin
			out_flag_capturar_dato = 1'b0;
			reg_a_d = 1'b1;
			state_next = espera;
			reg_cs = fake_cs;
			reg_rd = fake_rd;
			reg_wr = fake_wr;
			out_direccion_dato = fake_out_direccion_dato;
			reg_funcion_r_w = fake_funcion_r_w;
			//out_flag_inicio = 1'b0;
			//out_flag_inicio = 1'b0;
			end
		default: begin state_next = leer_escribir;
			reg_a_d = fake_a_d;
		reg_cs = fake_cs;
		reg_rd = fake_rd;
		reg_wr = fake_wr;
		out_direccion_dato = fake_out_direccion_dato;
		reg_funcion_r_w = fake_funcion_r_w;
		out_flag_capturar_dato = 1'b0;
		end 
		endcase	 
	end
	default: begin
	state_next = espera;
	//reg_addr_RAM = 8'd0;
	reg_cs = 1'd1;
	reg_a_d = 1'd1;
	reg_wr = 1'd1;
	reg_rd = 1'd1;
	reg_funcion_r_w = 1'd0;
	out_direccion_dato = 1'd0;
	fake_a_d = reg_a_d;
	fake_cs= reg_cs;
	fake_rd= reg_rd;
	fake_wr= reg_wr;
	fake_out_direccion_dato= out_direccion_dato;	
	fake_funcion_r_w= reg_funcion_r_w;
	end
	endcase
	
   end






endmodule
