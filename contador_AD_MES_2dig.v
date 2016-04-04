`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    15:45:17 04/03/2016 
// Design Name: 
// Module Name:    contador_AD_MES_2dig 
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
module contador_AD_MES_2dig
(
input wire clk,
input wire reset,
input wire enUP,
input wire enDOWN,
output reg [3:0] digit0, digit1//Decodifica en binario el valor en dos dígitos decimales
);

localparam N = 4; // Para definir el número de bits del contador (hasta 12->4 bits)
//Declaración de señales
reg [N-1:0] q_act, q_next;
reg enUP_reg, enDOWN_reg;
wire enUP_tick, enDOWN_tick;
wire [N-1:0] count_data;//Se debe sumar 1 por como se interpretan los días (del 1 a 12)

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
		q_act <= 4'b0;
	end
	
	else
	begin
		q_act <= q_next;
	end
end


//Lógica de salida
always@*
begin
	if(enUP_tick)
	begin
	q_next = q_act + 1'b1;
	end
	
	else if(enDOWN_tick)
	begin
	q_next = q_act - 1'b1;
	end
	
	else if(~enUP_tick && q_act == 11)
	begin
	q_next = 4'd0;
	end
	
	else if(~enDOWN_tick && q_act == 0)
	begin
	q_next = 4'd11;
	end
	
	else
	begin
	q_next = q_act;
	end
end

assign count_data = q_act + 1'b1;//Suma 1 a todas las cuentas de 0->11 a 1->12

//Decodificación BCD (2 dígitos)

always@*
begin
case(count_data)

4'd1: begin digit1 = 4'b0000; digit0 = 4'b0001; end
4'd2: begin digit1 = 4'b0000; digit0 = 4'b0010; end
4'd3: begin digit1 = 4'b0000; digit0 = 4'b0011; end
4'd4: begin digit1 = 4'b0000; digit0 = 4'b0100; end
4'd5: begin digit1 = 4'b0000; digit0 = 4'b0101; end
4'd6: begin digit1 = 4'b0000; digit0 = 4'b0110; end
4'd7: begin digit1 = 4'b0000; digit0 = 4'b0111; end
4'd8: begin digit1 = 4'b0000; digit0 = 4'b1000; end
4'd9: begin digit1 = 4'b0000; digit0 = 4'b1001; end

4'd10: begin digit1 = 4'b0001; digit0 = 4'b0000; end
4'd11: begin digit1 = 4'b0001; digit0 = 4'b0001; end
4'd12: begin digit1 = 4'b0001; digit0 = 4'b0010; end

default:  begin digit1 = 0; digit0 = 0; end
endcase
end

endmodule
