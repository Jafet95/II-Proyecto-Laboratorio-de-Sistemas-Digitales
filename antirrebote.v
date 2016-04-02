`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    11:03:28 04/02/2016 
// Design Name: 
// Module Name:    debounce 
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

module antirrebote
(
input wire clk, reset,
input wire sw,//Entrada original de botón, switch
output reg db//Entrada sin rebote de botón, switch
);

// Declaración de estados simbólica
localparam  [1:0]
zero = 2'b00,
wait_one = 2'b01,
one = 2'b10,
wait_zero = 2'b11;


// Bits del contador para generar una señal periódica de (2^N)*10ns
localparam N =24;

// Declaración de señales
reg [N-1:0] q_reg;
reg [N-1:0] q_next;
wire m_tick;
reg [1:0] state_reg, state_next;


//Descripción del comportamiento

//=============================================
// Contador para generar un pulso de(2^N)*10ns
//=============================================
always @(posedge clk, posedge reset)
begin
    if (reset) q_reg <= 0;
	 else q_reg <= q_next;
end
always@*
begin
q_next = q_reg + 1'b1;
end
// Pulso de salida
assign m_tick = (q_reg == 0) ? 1'b1 : 1'b0;//Tiempo que se espera para asegurar el dato de entrada

//=============================================
// FSM antirrebote
//=============================================
// Registros de estado
always @(posedge clk, posedge reset)
  if (reset)
     state_reg <= zero;
  else
     state_reg <= state_next;

// Lógica de estado siguiente y salida
   
always @*
   begin
	state_next = state_reg;  // default state: the same
   db = 1'b0;               // default output: 0
	
	case(state_reg)
	
	zero:
	begin
		if(sw)
		begin
		state_next = wait_one;
		end
	end
		
	wait_one:
	begin
		if(m_tick)
		begin
		state_next = one;
		end
		
		else
		begin
		state_next = wait_one;
		end
	end
	
	one:
	begin
	db = 1'b1;
		if(~sw)
		begin
		state_next = wait_zero;
		end
	end
	
	wait_zero:
	begin
		if(m_tick)
		begin
		state_next = zero;
		end
		
		else
		begin
		state_next = wait_one;
		end
	end	
	
	endcase
   end

endmodule
