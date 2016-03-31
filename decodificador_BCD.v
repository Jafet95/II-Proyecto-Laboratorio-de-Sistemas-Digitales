`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    20:33:59 03/28/2016 
// Design Name: 
// Module Name:    decodificador_BCD 
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
module decodificador_BCD
(
input wire [7:0] count_data, //Valores de 8 bits correspondientes datos de la hora, fecha y timer
output reg [3:0] digit0, digit1//Decodifica en binario el valor en dos dígitos decimales
);

always@*
begin
case(count_data)
8'd0: begin digit1 = 4'b0000; digit0 = 4'b0000; end
8'd1: begin digit1 = 4'b0000; digit0 = 4'b0001; end
8'd2: begin digit1 = 4'b0000; digit0 = 4'b0010; end
8'd3: begin digit1 = 4'b0000; digit0 = 4'b0011; end
8'd4: begin digit1 = 4'b0000; digit0 = 4'b0100; end
8'd5: begin digit1 = 4'b0000; digit0 = 4'b0101; end
8'd6: begin digit1 = 4'b0000; digit0 = 4'b0110; end
8'd7: begin digit1 = 4'b0000; digit0 = 4'b0111; end
8'd8: begin digit1 = 4'b0000; digit0 = 4'b1000; end
8'd9: begin digit1 = 4'b0000; digit0 = 4'b1001; end

8'd10: begin digit1 = 4'b0001; digit0 = 4'b0000; end
8'd11: begin digit1 = 4'b0001; digit0 = 4'b0001; end
8'd12: begin digit1 = 4'b0001; digit0 = 4'b0010; end
8'd13: begin digit1 = 4'b0001; digit0 = 4'b0011; end
8'd14: begin digit1 = 4'b0001; digit0 = 4'b0100; end
8'd15: begin digit1 = 4'b0001; digit0 = 4'b0101; end
8'd16: begin digit1 = 4'b0001; digit0 = 4'b0110; end
8'd17: begin digit1 = 4'b0001; digit0 = 4'b0111; end
8'd18: begin digit1 = 4'b0001; digit0 = 4'b1000; end
8'd19: begin digit1 = 4'b0001; digit0 = 4'b1001; end

8'd20: begin digit1 = 4'b0010; digit0 = 4'b0000; end
8'd21: begin digit1 = 4'b0010; digit0 = 4'b0001; end
8'd22: begin digit1 = 4'b0010; digit0 = 4'b0010; end
8'd23: begin digit1 = 4'b0010; digit0 = 4'b0011; end
8'd24: begin digit1 = 4'b0010; digit0 = 4'b0100; end
8'd25: begin digit1 = 4'b0010; digit0 = 4'b0101; end
8'd26: begin digit1 = 4'b0010; digit0 = 4'b0110; end
8'd27: begin digit1 = 4'b0010; digit0 = 4'b0111; end
8'd28: begin digit1 = 4'b0010; digit0 = 4'b1000; end
8'd29: begin digit1 = 4'b0010; digit0 = 4'b1001; end

8'd30: begin digit1 = 4'b0011; digit0 = 4'b0000; end
8'd31: begin digit1 = 4'b0011; digit0 = 4'b0001; end
8'd32: begin digit1 = 4'b0011; digit0 = 4'b0010; end
8'd33: begin digit1 = 4'b0011; digit0 = 4'b0011; end
8'd34: begin digit1 = 4'b0011; digit0 = 4'b0100; end
8'd35: begin digit1 = 4'b0011; digit0 = 4'b0101; end
8'd36: begin digit1 = 4'b0011; digit0 = 4'b0110; end
8'd37: begin digit1 = 4'b0011; digit0 = 4'b0111; end
8'd38: begin digit1 = 4'b0011; digit0 = 4'b1000; end
8'd39: begin digit1 = 4'b0011; digit0 = 4'b1001; end

8'd40: begin digit1 = 4'b0100; digit0 = 4'b0000; end
8'd41: begin digit1 = 4'b0100; digit0 = 4'b0001; end
8'd42: begin digit1 = 4'b0100; digit0 = 4'b0010; end
8'd43: begin digit1 = 4'b0100; digit0 = 4'b0011; end
8'd44: begin digit1 = 4'b0100; digit0 = 4'b0100; end
8'd45: begin digit1 = 4'b0100; digit0 = 4'b0101; end
8'd46: begin digit1 = 4'b0100; digit0 = 4'b0110; end
8'd47: begin digit1 = 4'b0100; digit0 = 4'b0111; end
8'd48: begin digit1 = 4'b0100; digit0 = 4'b1000; end
8'd49: begin digit1 = 4'b0100; digit0 = 4'b1001; end

8'd50: begin digit1 = 4'b0101; digit0 = 4'b0000; end
8'd51: begin digit1 = 4'b0101; digit0 = 4'b0001; end
8'd52: begin digit1 = 4'b0101; digit0 = 4'b0010; end
8'd53: begin digit1 = 4'b0101; digit0 = 4'b0011; end
8'd54: begin digit1 = 4'b0101; digit0 = 4'b0100; end
8'd55: begin digit1 = 4'b0101; digit0 = 4'b0101; end
8'd56: begin digit1 = 4'b0101; digit0 = 4'b0110; end
8'd57: begin digit1 = 4'b0101; digit0 = 4'b0111; end
8'd58: begin digit1 = 4'b0101; digit0 = 4'b1000; end
8'd59: begin digit1 = 4'b0101; digit0 = 4'b1001; end

8'd60: begin digit1 = 4'b0110; digit0 = 4'b0000; end
8'd61: begin digit1 = 4'b0110; digit0 = 4'b0001; end
8'd62: begin digit1 = 4'b0110; digit0 = 4'b0010; end
8'd63: begin digit1 = 4'b0110; digit0 = 4'b0011; end
8'd64: begin digit1 = 4'b0110; digit0 = 4'b0100; end
8'd65: begin digit1 = 4'b0110; digit0 = 4'b0101; end
8'd66: begin digit1 = 4'b0110; digit0 = 4'b0110; end
8'd67: begin digit1 = 4'b0110; digit0 = 4'b0111; end
8'd68: begin digit1 = 4'b0110; digit0 = 4'b1000; end
8'd69: begin digit1 = 4'b0110; digit0 = 4'b1001; end

8'd70: begin digit1 = 4'b0111; digit0 = 4'b0000; end
8'd71: begin digit1 = 4'b0111; digit0 = 4'b0001; end
8'd72: begin digit1 = 4'b0111; digit0 = 4'b0010; end
8'd73: begin digit1 = 4'b0111; digit0 = 4'b0011; end
8'd74: begin digit1 = 4'b0111; digit0 = 4'b0100; end
8'd75: begin digit1 = 4'b0111; digit0 = 4'b0101; end
8'd76: begin digit1 = 4'b0111; digit0 = 4'b0110; end
8'd77: begin digit1 = 4'b0111; digit0 = 4'b0111; end
8'd78: begin digit1 = 4'b0111; digit0 = 4'b1000; end
8'd79: begin digit1 = 4'b0111; digit0 = 4'b1001; end

8'd80: begin digit1 = 4'b1000; digit0 = 4'b0000; end
8'd81: begin digit1 = 4'b1000; digit0 = 4'b0001; end
8'd82: begin digit1 = 4'b1000; digit0 = 4'b0010; end
8'd83: begin digit1 = 4'b1000; digit0 = 4'b0011; end
8'd84: begin digit1 = 4'b1000; digit0 = 4'b0100; end
8'd85: begin digit1 = 4'b1000; digit0 = 4'b0101; end
8'd86: begin digit1 = 4'b1000; digit0 = 4'b0110; end
8'd87: begin digit1 = 4'b1000; digit0 = 4'b0111; end
8'd88: begin digit1 = 4'b1000; digit0 = 4'b1000; end
8'd89: begin digit1 = 4'b1000; digit0 = 4'b1001; end

8'd90: begin digit1 = 4'b1001; digit0 = 4'b0000; end
8'd91: begin digit1 = 4'b1001; digit0 = 4'b0001; end
8'd92: begin digit1 = 4'b1001; digit0 = 4'b0010; end
8'd93: begin digit1 = 4'b1001; digit0 = 4'b0011; end
8'd94: begin digit1 = 4'b1001; digit0 = 4'b0100; end
8'd95: begin digit1 = 4'b1001; digit0 = 4'b0101; end
8'd96: begin digit1 = 4'b1001; digit0 = 4'b0110; end
8'd97: begin digit1 = 4'b1001; digit0 = 4'b0111; end
8'd98: begin digit1 = 4'b1001; digit0 = 4'b1000; end
8'd99: begin digit1 = 4'b1001; digit0 = 4'b1001; end

default:  begin digit1 = 0; digit0 = 0; end
endcase
end

endmodule
