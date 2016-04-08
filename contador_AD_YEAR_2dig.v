`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    15:45:17 04/03/2016 
// Design Name: 
// Module Name:    contador_AD_YEAR_2dig 
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
module contador_AD_YEAR_2dig
(
input wire clk,
input wire reset,
input wire [3:0] en_count,
input wire enUP,
input wire enDOWN,
output reg [3:0] digit1, digit0
);

localparam N = 7; // Para definir el número de bits del contador (hasta 99->7 bits)
//Declaración de señales
reg [N-1:0] q_act, q_next;
reg enUP_reg, enDOWN_reg;
wire enUP_tick, enDOWN_tick;
wire [N-1:0] count_data;

// Bits del contador para generar una señal periódica de (2^N)*10ns
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


//Descripción del comportamiento
always@(posedge btn_pulse, posedge reset)
begin	
	
	if(reset)
	begin
		q_act <= 7'b0;
	end
	
	else
	begin
		q_act <= q_next;
	end
end


//Lógica de salida

always@*
begin

	if (en_count == 4)
	begin
		if (enUP)
		begin
			if (q_act >= 7'd99) q_next = 7'd0;
			else q_next = q_act + 7'd1;
		end
		
		else if (enDOWN)
		begin
			if (q_act == 7'd0) q_next = 7'd99;
			else q_next = q_act - 7'd1;
		end
		else q_next = q_act;
	end
	else q_next = q_act;
	
end

assign count_data = q_act;

//Decodificación BCD (2 dígitos)

always@*
begin
case(count_data)
7'd0: begin digit1 = 4'b0000; digit0 = 4'b0000; end
7'd1: begin digit1 = 4'b0000; digit0 = 4'b0001; end
7'd2: begin digit1 = 4'b0000; digit0 = 4'b0010; end
7'd3: begin digit1 = 4'b0000; digit0 = 4'b0011; end
7'd4: begin digit1 = 4'b0000; digit0 = 4'b0100; end
7'd5: begin digit1 = 4'b0000; digit0 = 4'b0101; end
7'd6: begin digit1 = 4'b0000; digit0 = 4'b0110; end
7'd7: begin digit1 = 4'b0000; digit0 = 4'b0111; end
7'd8: begin digit1 = 4'b0000; digit0 = 4'b1000; end
7'd9: begin digit1 = 4'b0000; digit0 = 4'b1001; end

7'd10: begin digit1 = 4'b0001; digit0 = 4'b0000; end
7'd11: begin digit1 = 4'b0001; digit0 = 4'b0001; end
7'd12: begin digit1 = 4'b0001; digit0 = 4'b0010; end
7'd13: begin digit1 = 4'b0001; digit0 = 4'b0011; end
7'd14: begin digit1 = 4'b0001; digit0 = 4'b0100; end
7'd15: begin digit1 = 4'b0001; digit0 = 4'b0101; end
7'd16: begin digit1 = 4'b0001; digit0 = 4'b0110; end
7'd17: begin digit1 = 4'b0001; digit0 = 4'b0111; end
7'd18: begin digit1 = 4'b0001; digit0 = 4'b1000; end
7'd19: begin digit1 = 4'b0001; digit0 = 4'b1001; end

7'd20: begin digit1 = 4'b0010; digit0 = 4'b0000; end
7'd21: begin digit1 = 4'b0010; digit0 = 4'b0001; end
7'd22: begin digit1 = 4'b0010; digit0 = 4'b0010; end
7'd23: begin digit1 = 4'b0010; digit0 = 4'b0011; end
7'd24: begin digit1 = 4'b0010; digit0 = 4'b0100; end
7'd25: begin digit1 = 4'b0010; digit0 = 4'b0101; end
7'd26: begin digit1 = 4'b0010; digit0 = 4'b0110; end
7'd27: begin digit1 = 4'b0010; digit0 = 4'b0111; end
7'd28: begin digit1 = 4'b0010; digit0 = 4'b1000; end
7'd29: begin digit1 = 4'b0010; digit0 = 4'b1001; end

7'd30: begin digit1 = 4'b0011; digit0 = 4'b0000; end
7'd31: begin digit1 = 4'b0011; digit0 = 4'b0001; end
7'd32: begin digit1 = 4'b0011; digit0 = 4'b0010; end
7'd33: begin digit1 = 4'b0011; digit0 = 4'b0011; end
7'd34: begin digit1 = 4'b0011; digit0 = 4'b0100; end
7'd35: begin digit1 = 4'b0011; digit0 = 4'b0101; end
7'd36: begin digit1 = 4'b0011; digit0 = 4'b0110; end
7'd37: begin digit1 = 4'b0011; digit0 = 4'b0111; end
7'd38: begin digit1 = 4'b0011; digit0 = 4'b1000; end
7'd39: begin digit1 = 4'b0011; digit0 = 4'b1001; end

7'd40: begin digit1 = 4'b0100; digit0 = 4'b0000; end
7'd41: begin digit1 = 4'b0100; digit0 = 4'b0001; end
7'd42: begin digit1 = 4'b0100; digit0 = 4'b0010; end
7'd43: begin digit1 = 4'b0100; digit0 = 4'b0011; end
7'd44: begin digit1 = 4'b0100; digit0 = 4'b0100; end
7'd45: begin digit1 = 4'b0100; digit0 = 4'b0101; end
7'd46: begin digit1 = 4'b0100; digit0 = 4'b0110; end
7'd47: begin digit1 = 4'b0100; digit0 = 4'b0111; end
7'd48: begin digit1 = 4'b0100; digit0 = 4'b1000; end
7'd49: begin digit1 = 4'b0100; digit0 = 4'b1001; end

7'd50: begin digit1 = 4'b0101; digit0 = 4'b0000; end
7'd51: begin digit1 = 4'b0101; digit0 = 4'b0001; end
7'd52: begin digit1 = 4'b0101; digit0 = 4'b0010; end
7'd53: begin digit1 = 4'b0101; digit0 = 4'b0011; end
7'd54: begin digit1 = 4'b0101; digit0 = 4'b0100; end
7'd55: begin digit1 = 4'b0101; digit0 = 4'b0101; end
7'd56: begin digit1 = 4'b0101; digit0 = 4'b0110; end
7'd57: begin digit1 = 4'b0101; digit0 = 4'b0111; end
7'd58: begin digit1 = 4'b0101; digit0 = 4'b1000; end
7'd59: begin digit1 = 4'b0101; digit0 = 4'b1001; end

7'd60: begin digit1 = 4'b0110; digit0 = 4'b0000; end
7'd61: begin digit1 = 4'b0110; digit0 = 4'b0001; end
7'd62: begin digit1 = 4'b0110; digit0 = 4'b0010; end
7'd63: begin digit1 = 4'b0110; digit0 = 4'b0011; end
7'd64: begin digit1 = 4'b0110; digit0 = 4'b0100; end
7'd65: begin digit1 = 4'b0110; digit0 = 4'b0101; end
7'd66: begin digit1 = 4'b0110; digit0 = 4'b0110; end
7'd67: begin digit1 = 4'b0110; digit0 = 4'b0111; end
7'd68: begin digit1 = 4'b0110; digit0 = 4'b1000; end
7'd69: begin digit1 = 4'b0110; digit0 = 4'b1001; end

7'd70: begin digit1 = 4'b0111; digit0 = 4'b0000; end
7'd71: begin digit1 = 4'b0111; digit0 = 4'b0001; end
7'd72: begin digit1 = 4'b0111; digit0 = 4'b0010; end
7'd73: begin digit1 = 4'b0111; digit0 = 4'b0011; end
7'd74: begin digit1 = 4'b0111; digit0 = 4'b0100; end
7'd75: begin digit1 = 4'b0111; digit0 = 4'b0101; end
7'd76: begin digit1 = 4'b0111; digit0 = 4'b0110; end
7'd77: begin digit1 = 4'b0111; digit0 = 4'b0111; end
7'd78: begin digit1 = 4'b0111; digit0 = 4'b1000; end
7'd79: begin digit1 = 4'b0111; digit0 = 4'b1001; end

7'd80: begin digit1 = 4'b1000; digit0 = 4'b0000; end
7'd81: begin digit1 = 4'b1000; digit0 = 4'b0001; end
7'd82: begin digit1 = 4'b1000; digit0 = 4'b0010; end
7'd83: begin digit1 = 4'b1000; digit0 = 4'b0011; end
7'd84: begin digit1 = 4'b1000; digit0 = 4'b0100; end
7'd85: begin digit1 = 4'b1000; digit0 = 4'b0101; end
7'd86: begin digit1 = 4'b1000; digit0 = 4'b0110; end
7'd87: begin digit1 = 4'b1000; digit0 = 4'b0111; end
7'd88: begin digit1 = 4'b1000; digit0 = 4'b1000; end
7'd89: begin digit1 = 4'b1000; digit0 = 4'b1001; end

7'd90: begin digit1 = 4'b1001; digit0 = 4'b0000; end
7'd91: begin digit1 = 4'b1001; digit0 = 4'b0001; end
7'd92: begin digit1 = 4'b1001; digit0 = 4'b0010; end
7'd93: begin digit1 = 4'b1001; digit0 = 4'b0011; end
7'd94: begin digit1 = 4'b1001; digit0 = 4'b0100; end
7'd95: begin digit1 = 4'b1001; digit0 = 4'b0101; end
7'd96: begin digit1 = 4'b1001; digit0 = 4'b0110; end
7'd97: begin digit1 = 4'b1001; digit0 = 4'b0111; end
7'd98: begin digit1 = 4'b1001; digit0 = 4'b1000; end
7'd99: begin digit1 = 4'b1001; digit0 = 4'b1001; end

default:  begin digit1 = 0; digit0 = 0; end
endcase
end

endmodule
