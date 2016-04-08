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
output wire [7:0] count_data//Para interpretar el dia de la semana a escribir (3-bits: 7 d�as)
);

localparam N = 3; // Para definir el n�mero de bits del contador (hasta 7->3 bits)
//Declaraci�n de se�ales
reg [N-1:0] q_act, q_next;
reg enUP_reg, enDOWN_reg;
wire enUP_tick, enDOWN_tick;

// Bits del contador para generar una se�al peri�dica de (2^N)*10ns
localparam N_bits =24;//~4Hz

reg [N_bits-1:0] btn_pulse_reg;
reg btn_pulse;

always @(posedge clk, posedge reset)
begin
	if (reset)begin btn_pulse_reg <= 0; btn_pulse <= 0; end
	
	else
	begin
		if (btn_pulse_reg == 24'd12999999)
			begin
			btn_pulse_reg <= 0;
			btn_pulse <= ~btn_pulse;
			end
		else
			btn_pulse_reg <= btn_pulse_reg + 1'b1;
	end
end	
//____________________________________________________________________________________________________________

//Descripci�n del comportamiento
always@(posedge btn_pulse, posedge reset)
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


//L�gica de salida

always@*
begin

	if (en_count == 7)
	begin
		if (enUP)
		begin
			if (q_act >= 3'd6) q_next = 3'd0;
			else q_next = q_act + 3'd1;
		end
		
		else if (enDOWN)
		begin
			if (q_act == 3'd0) q_next = 3'd6;
			else q_next = q_act - 3'd1;
		end
		else q_next = q_act;
	end
	else q_next = q_act;
	
end

assign count_data = q_act + 3'b1;//Suma 1 a todas las cuentas de 0->6 a 1->7

endmodule
