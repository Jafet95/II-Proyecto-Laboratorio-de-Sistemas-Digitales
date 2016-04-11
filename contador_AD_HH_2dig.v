`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    21:28:51 04/04/2016 
// Design Name: 
// Module Name:    contador_AD_HH_2dig 
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
module contador_AD_HH_2dig
(
input wire clk, 
input wire reset,
input wire [3:0]en_count,
input wire enUP,
input wire enDOWN,
output reg AM_PM,
output wire [7:0] data_HH//Dígitos BCD ya concatenados hacia los registros(8 bits)
);                             


localparam N = 5; // Para definir el número de bits del contador (hasta 23->5 bits)
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

	if (en_count == 3)
	begin
		if (enUP)
		begin
			if (q_act >= 5'd23) q_next = 5'd0;
			else q_next = q_act + 5'd1;
		end
		
		else if (enDOWN)
		begin
			if (q_act == 5'd0) q_next = 5'd23;
			else q_next = q_act - 5'd1;
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
		5'd0: begin digit1 = 4'b0000; digit0 = 4'b0000; AM_PM = 0; end
		5'd1: begin digit1 = 4'b0000; digit0 = 4'b0001; AM_PM = 0; end
		5'd2: begin digit1 = 4'b0000; digit0 = 4'b0010; AM_PM = 0; end
		5'd3: begin digit1 = 4'b0000; digit0 = 4'b0011; AM_PM = 0; end
		5'd4: begin digit1 = 4'b0000; digit0 = 4'b0100; AM_PM = 0; end
		5'd5: begin digit1 = 4'b0000; digit0 = 4'b0101; AM_PM = 0; end
		5'd6: begin digit1 = 4'b0000; digit0 = 4'b0110; AM_PM = 0; end
		5'd7: begin digit1 = 4'b0000; digit0 = 4'b0111; AM_PM = 0; end
		5'd8: begin digit1 = 4'b0000; digit0 = 4'b1000; AM_PM = 0; end
		5'd9: begin digit1 = 4'b0000; digit0 = 4'b1001; AM_PM = 0; end

		5'd10: begin digit1 = 4'b0001; digit0 = 4'b0000; AM_PM = 0; end
		5'd11: begin digit1 = 4'b0001; digit0 = 4'b0001; AM_PM = 0; end
		5'd12: begin digit1 = 4'b0001; digit0 = 4'b0010; AM_PM = 0; end
		5'd13: begin digit1 = 4'b0001; digit0 = 4'b0011; AM_PM = 0; end
		5'd14: begin digit1 = 4'b0001; digit0 = 4'b0100; AM_PM = 0; end
		5'd15: begin digit1 = 4'b0001; digit0 = 4'b0101; AM_PM = 0; end
		5'd16: begin digit1 = 4'b0001; digit0 = 4'b0110; AM_PM = 0; end
		5'd17: begin digit1 = 4'b0001; digit0 = 4'b0111; AM_PM = 0; end
		5'd18: begin digit1 = 4'b0001; digit0 = 4'b1000; AM_PM = 0; end
		5'd19: begin digit1 = 4'b0001; digit0 = 4'b1001; AM_PM = 0; end

		5'd20: begin digit1 = 4'b0010; digit0 = 4'b0000; AM_PM = 0; end
		5'd21: begin digit1 = 4'b0010; digit0 = 4'b0001; AM_PM = 0; end
		5'd22: begin digit1 = 4'b0010; digit0 = 4'b0010; AM_PM = 0; end
		5'd23: begin digit1 = 4'b0010; digit0 = 4'b0011; AM_PM = 0; end
		default:  begin digit1 = 0; digit0 = 0; AM_PM = 0; end
	endcase	
end

assign data_HH = {digit1,digit0};

/*
input wire formato_hora;
input wire [7:0] data_HH;//Los 8 bits en BCD de horas de la hora provenientes del registro
output wire [7:0] dato_HH;//Los 8 bits en BCD concatenados de las horas de la hora hacia el control VGA
output reg AM_PM;
reg [3:0] digit1_HH, digit0_HH;

always@*
begin
	if(formato_hora)//12 hrs (Traduce a formato 12 hrs)
	begin
		case(data_HH)
		8'd0: begin digit1_HH = 4'b0000; digit0_HH = 4'b0000; AM_PM = 0; end//00 BCD en 8 bits
		8'd1: begin digit1_HH = 4'b0000; digit0_HH = 4'b0001; AM_PM = 0; end//01 BCD en 8 bits
		8'd2: begin digit1_HH = 4'b0000; digit0_HH = 4'b0010; AM_PM = 0; end//02 BCD en 8 bits
		8'd3: begin digit1_HH = 4'b0000; digit0_HH = 4'b0011; AM_PM = 0; end//03 BCD en 8 bits
		8'd4: begin digit1_HH = 4'b0000; digit0_HH = 4'b0100; AM_PM = 0; end//04 BCD en 8 bits
		8'd5: begin digit1_HH = 4'b0000; digit0_HH = 4'b0101; AM_PM = 0; end//05 BCD en 8 bits
		8'd6: begin digit1_HH = 4'b0000; digit0_HH = 4'b0110; AM_PM = 0; end//06 BCD en 8 bits
		8'd7: begin digit1_HH = 4'b0000; digit0_HH = 4'b0111; AM_PM = 0; end//07 BCD en 8 bits
		8'd8: begin digit1_HH = 4'b0000; digit0_HH = 4'b1000; AM_PM = 0; end//08 BCD en 8 bits
		8'd9: begin digit1_HH = 4'b0000; digit0_HH = 4'b1001; AM_PM = 0; end//09 BCD en 8 bits
		8'd16: begin digit1_HH = 4'b0001; digit0_HH = 4'b0000; AM_PM = 0; end//10 BCD en 8 bits
		8'd17: begin digit1_HH = 4'b0001; digit0_HH = 4'b0001; AM_PM = 0; end//11 BCD en 8 bits
		
		8'd18: begin digit1_HH = 4'b0001; digit0_HH = 4'b0010; AM_PM = 1; end//12 BCD en 8 bits
		8'd19: begin digit1_HH = 4'b0001; digit0_HH = 4'b0011; AM_PM = 1; end//13 BCD en 8 bits
		8'd20: begin digit1_HH = 4'b0001; digit0_HH = 4'b0100; AM_PM = 1; end//14 BCD en 8 bits
		8'd21: begin digit1_HH = 4'b0001; digit0_HH = 4'b0101; AM_PM = 1; end//15 BCD en 8 bits
		8'd22: begin digit1_HH = 4'b0001; digit0_HH = 4'b0110; AM_PM = 1; end//16 BCD en 8 bits
		8'd23: begin digit1_HH = 4'b0001; digit0_HH = 4'b0111; AM_PM = 1; end//17 BCD en 8 bits
		8'd24: begin digit1_HH = 4'b0001; digit0_HH = 4'b1000; AM_PM = 1; end//18 BCD en 8 bits
		8'd25: begin digit1_HH = 4'b0001; digit0_HH = 4'b1001; AM_PM = 1; end//19 BCD en 8 bits
		8'd32: begin digit1_HH = 4'b0010; digit0_HH = 4'b0000; AM_PM = 1; end//20 BCD en 8 bits
		8'd33: begin digit1_HH = 4'b0010; digit0_HH = 4'b0001; AM_PM = 1; end//21 BCD en 8 bits
		8'd34: begin digit1_HH = 4'b0010; digit0_HH = 4'b0010; AM_PM = 1; end//22 BCD en 8 bits
		8'd35: begin digit1_HH = 4'b0010; digit0_HH = 4'b0011; AM_PM = 1; end//23 BCD en 8 bits
		default:  begin digit1 = 0; digit0 = 0; AM_PM = 0; end
		endcase
	end
	
	else //24 hrs (Transfiere el dato simplemente)
	begin
		digit1_HH = data_HH[7:4];
		digit0_HH = data_HH[3:0];
		AM_PM = 0;
	end
end

assign dato_HH = {digit1_HH,digit0_HH};
*/
endmodule
