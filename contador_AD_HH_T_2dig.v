`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    15:45:17 04/03/2016 
// Design Name: 
// Module Name:    contador_AD_HH_T_2dig
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
module contador_AD_HH_T_2dig
(
input wire clk,
input wire reset,
input wire [3:0] en_count,
input wire enUP,
input wire enDOWN,
output reg [3:0] digit1, digit0
);

localparam N = 5; // Para definir el número de bits del contador (hasta 23->5 bits)
//Declaración de señales
reg [N-1:0] q_act, q_next;
reg enUP_reg, enDOWN_reg;
wire enUP_tick, enDOWN_tick;
wire [N-1:0] count_data;

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
		q_act <= 5'b0;
	end
	
	else
	begin
		q_act <= q_next;
	end
end


//Lógica de salida
always@*
begin
	if(enUP_tick && en_count == 10)
	begin
	q_next = q_act + 1'b1;
	end
	
	else if(enDOWN_tick && en_count == 10)
	begin
	q_next = q_act - 1'b1;
	end
	
	else if(~enUP_tick && q_act == 23 && en_count == 10)
	begin
	q_next = 5'd0;
	end
	
	else if(~enDOWN_tick && q_act == 0 && en_count == 10)
	begin
	q_next = 5'd23;
	end
	
	else
	begin
	q_next = q_act;
	end
end

assign count_data = q_act;

//Decodificación BCD (2 dígitos)

always@*
begin
case(count_data)
5'd0: begin digit1 = 4'b0000; digit0 = 4'b0000; end
5'd1: begin digit1 = 4'b0000; digit0 = 4'b0001; end
5'd2: begin digit1 = 4'b0000; digit0 = 4'b0010; end
5'd3: begin digit1 = 4'b0000; digit0 = 4'b0011; end
5'd4: begin digit1 = 4'b0000; digit0 = 4'b0100; end
5'd5: begin digit1 = 4'b0000; digit0 = 4'b0101; end
5'd6: begin digit1 = 4'b0000; digit0 = 4'b0110; end
5'd7: begin digit1 = 4'b0000; digit0 = 4'b0111; end
5'd8: begin digit1 = 4'b0000; digit0 = 4'b1000; end
5'd9: begin digit1 = 4'b0000; digit0 = 4'b1001; end

5'd10: begin digit1 = 4'b0001; digit0 = 4'b0000; end
5'd11: begin digit1 = 4'b0001; digit0 = 4'b0001; end
5'd12: begin digit1 = 4'b0001; digit0 = 4'b0010; end
5'd13: begin digit1 = 4'b0001; digit0 = 4'b0011; end
5'd14: begin digit1 = 4'b0001; digit0 = 4'b0100; end
5'd15: begin digit1 = 4'b0001; digit0 = 4'b0101; end
5'd16: begin digit1 = 4'b0001; digit0 = 4'b0110; end
5'd17: begin digit1 = 4'b0001; digit0 = 4'b0111; end
5'd18: begin digit1 = 4'b0001; digit0 = 4'b1000; end
5'd19: begin digit1 = 4'b0001; digit0 = 4'b1001; end

5'd20: begin digit1 = 4'b0010; digit0 = 4'b0000; end
5'd21: begin digit1 = 4'b0010; digit0 = 4'b0001; end
5'd22: begin digit1 = 4'b0010; digit0 = 4'b0010; end
5'd23: begin digit1 = 4'b0010; digit0 = 4'b0011; end

default:  begin digit1 = 0; digit0 = 0; end
endcase
end

endmodule
