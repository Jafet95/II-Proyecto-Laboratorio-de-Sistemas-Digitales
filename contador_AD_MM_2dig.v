`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    15:45:17 04/03/2016 
// Design Name: 
// Module Name:    contador_AD_MM_2dig 
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
module contador_AD_MM_2dig
(
input wire clk,
input wire reset,
input wire [3:0] en_count,
input wire enUP,
input wire enDOWN,
output wire [7:0] data_MM
);

localparam N = 6; // Para definir el número de bits del contador (hasta 59->6 bits)
//Declaración de señales
reg [N-1:0] q_act, q_next;
wire [N-1:0] count_data;
reg [3:0] digit1, digit0;

//=============================================
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
		q_act <= 6'b0;
	end
	
	else
	begin
		q_act <= q_next;
	end
end


//Lógica de salida
always@*
begin

	if (en_count == 2)
	begin
		if (enUP)
		begin
			if (q_act >= 6'd59) q_next = 6'd0;
			else q_next = q_act + 6'd1;
		end
		
		else if (enDOWN)
		begin
			if (q_act == 6'd0) q_next = 6'd59;
			else q_next = q_act - 6'd1;
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
6'd0: begin digit1 = 4'b0000; digit0 = 4'b0000; end
6'd1: begin digit1 = 4'b0000; digit0 = 4'b0001; end
6'd2: begin digit1 = 4'b0000; digit0 = 4'b0010; end
6'd3: begin digit1 = 4'b0000; digit0 = 4'b0011; end
6'd4: begin digit1 = 4'b0000; digit0 = 4'b0100; end
6'd5: begin digit1 = 4'b0000; digit0 = 4'b0101; end
6'd6: begin digit1 = 4'b0000; digit0 = 4'b0110; end
6'd7: begin digit1 = 4'b0000; digit0 = 4'b0111; end
6'd8: begin digit1 = 4'b0000; digit0 = 4'b1000; end
6'd9: begin digit1 = 4'b0000; digit0 = 4'b1001; end

6'd10: begin digit1 = 4'b0001; digit0 = 4'b0000; end
6'd11: begin digit1 = 4'b0001; digit0 = 4'b0001; end
6'd12: begin digit1 = 4'b0001; digit0 = 4'b0010; end
6'd13: begin digit1 = 4'b0001; digit0 = 4'b0011; end
6'd14: begin digit1 = 4'b0001; digit0 = 4'b0100; end
6'd15: begin digit1 = 4'b0001; digit0 = 4'b0101; end
6'd16: begin digit1 = 4'b0001; digit0 = 4'b0110; end
6'd17: begin digit1 = 4'b0001; digit0 = 4'b0111; end
6'd18: begin digit1 = 4'b0001; digit0 = 4'b1000; end
6'd19: begin digit1 = 4'b0001; digit0 = 4'b1001; end

6'd20: begin digit1 = 4'b0010; digit0 = 4'b0000; end
6'd21: begin digit1 = 4'b0010; digit0 = 4'b0001; end
6'd22: begin digit1 = 4'b0010; digit0 = 4'b0010; end
6'd23: begin digit1 = 4'b0010; digit0 = 4'b0011; end
6'd24: begin digit1 = 4'b0010; digit0 = 4'b0100; end
6'd25: begin digit1 = 4'b0010; digit0 = 4'b0101; end
6'd26: begin digit1 = 4'b0010; digit0 = 4'b0110; end
6'd27: begin digit1 = 4'b0010; digit0 = 4'b0111; end
6'd28: begin digit1 = 4'b0010; digit0 = 4'b1000; end
6'd29: begin digit1 = 4'b0010; digit0 = 4'b1001; end

6'd30: begin digit1 = 4'b0011; digit0 = 4'b0000; end
6'd31: begin digit1 = 4'b0011; digit0 = 4'b0001; end
6'd32: begin digit1 = 4'b0011; digit0 = 4'b0010; end
6'd33: begin digit1 = 4'b0011; digit0 = 4'b0011; end
6'd34: begin digit1 = 4'b0011; digit0 = 4'b0100; end
6'd35: begin digit1 = 4'b0011; digit0 = 4'b0101; end
6'd36: begin digit1 = 4'b0011; digit0 = 4'b0110; end
6'd37: begin digit1 = 4'b0011; digit0 = 4'b0111; end
6'd38: begin digit1 = 4'b0011; digit0 = 4'b1000; end
6'd39: begin digit1 = 4'b0011; digit0 = 4'b1001; end

6'd40: begin digit1 = 4'b0100; digit0 = 4'b0000; end
6'd41: begin digit1 = 4'b0100; digit0 = 4'b0001; end
6'd42: begin digit1 = 4'b0100; digit0 = 4'b0010; end
6'd43: begin digit1 = 4'b0100; digit0 = 4'b0011; end
6'd44: begin digit1 = 4'b0100; digit0 = 4'b0100; end
6'd45: begin digit1 = 4'b0100; digit0 = 4'b0101; end
6'd46: begin digit1 = 4'b0100; digit0 = 4'b0110; end
6'd47: begin digit1 = 4'b0100; digit0 = 4'b0111; end
6'd48: begin digit1 = 4'b0100; digit0 = 4'b1000; end
6'd49: begin digit1 = 4'b0100; digit0 = 4'b1001; end

6'd50: begin digit1 = 4'b0101; digit0 = 4'b0000; end
6'd51: begin digit1 = 4'b0101; digit0 = 4'b0001; end
6'd52: begin digit1 = 4'b0101; digit0 = 4'b0010; end
6'd53: begin digit1 = 4'b0101; digit0 = 4'b0011; end
6'd54: begin digit1 = 4'b0101; digit0 = 4'b0100; end
6'd55: begin digit1 = 4'b0101; digit0 = 4'b0101; end
6'd56: begin digit1 = 4'b0101; digit0 = 4'b0110; end
6'd57: begin digit1 = 4'b0101; digit0 = 4'b0111; end
6'd58: begin digit1 = 4'b0101; digit0 = 4'b1000; end
6'd59: begin digit1 = 4'b0101; digit0 = 4'b1001; end


default:  begin digit1 = 0; digit0 = 0; end
endcase
end

assign data_MM = {digit1,digit0};

endmodule
