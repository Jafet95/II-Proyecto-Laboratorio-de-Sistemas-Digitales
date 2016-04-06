`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    15:45:17 04/03/2016 
// Design Name: 
// Module Name:    contador_AD_dia_semana 
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
module contador_AD_dia_semana
(
input wire clk,
input wire reset,
input wire [3:0]en_count,
input wire enUP,
input wire enDOWN,
output wire [7:0] count_data//Para interpretar el dia de la semana a escribir (3-bits: 7 días)
);

localparam N = 3; // Para definir el número de bits del contador (hasta 7->3 bits)
//Declaración de señales
reg [N-1:0] q_act, q_next;
reg enUP_reg, enDOWN_reg;
wire enUP_tick, enDOWN_tick;

//Detección de flancos
always@(posedge clk)
begin
enUP_reg <= enUP;
enDOWN_reg <= enDOWN;
end

assign enUP_tick = ~enUP_reg & enUP;
assign enDOWN_tick = ~enDOWN_reg & enDOWN;

//Descripción del comportamiento
always@(posedge clk)
begin	
	
	if(reset)
	begin
		q_act <= 3'b0;
	end
	
	else
	begin
		q_act <= q_next;
	end
end


//Lógica de salida
always@*
begin
	if(enUP_tick && en_count == 7)
	begin
	q_next = q_act + 1'b1;
	end
	
	else if(enDOWN_tick && en_count == 7)
	begin
	q_next = q_act - 1'b1;
	end
	
	else if(~enUP_tick && q_act == 6 && en_count == 7)
	begin
	q_next = 3'd0;
	end
	
	else if(~enDOWN_tick && q_act == 0 && en_count == 7)
	begin
	q_next = 3'd6;
	end
	
	else
	begin
	q_next = q_act;
	end
end

assign count_data = q_act + 1'b1;//Suma 1 a todas las cuentas de 0->6 a 1->7

endmodule
