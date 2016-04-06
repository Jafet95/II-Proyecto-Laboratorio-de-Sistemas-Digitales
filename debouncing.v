`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:53:05 04/05/2016 
// Design Name: 
// Module Name:    debouncing 
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
module debouncing
(
input wire clk,
input wire reset,
input wire [3:0] sw,//4 interruptores
input wire [3:0] btn,//4 botones
output wire [3:0] sw_db,//debounce
output wire [3:0] btn_db//debounce
);

antirrebote Instancia_antirrebote_SW0//SW0: config mode
(
.clk(clk), .reset(reset),
.sw(sw[0]),//Entrada original de botón, switch
.db(sw_db[0])//Entrada sin rebote de botón, switch
);

antirrebote Instancia_antirrebote_SW1//SW1: config mode
(
.clk(clk), .reset(reset),
.sw(sw[1]),//Entrada original de botón, switch
.db(sw_db[1])//Entrada sin rebote de botón, switch
);

antirrebote Instancia_antirrebote_SW2//SW2: formato hora
(
.clk(clk), .reset(reset),
.sw(sw[2]),//Entrada original de botón, switch
.db(sw_db[2])//Entrada sin rebote de botón, switch
);

antirrebote Instancia_antirrebote_SW3//SW3: Para generar timer_end
(
.clk(clk), .reset(reset),
.sw(sw[3]),//Entrada original de botón, switch
.db(sw_db[3])//Entrada sin rebote de botón, switch
);


antirrebote Instancia_antirrebote_BTN0//UP
(
.clk(clk), .reset(reset),
.sw(btn[0]),//Entrada original de botón, switch
.db(btn_db[0])//Entrada sin rebote de botón, switch
);

antirrebote Instancia_antirrebote_BTN1//DOWN
(
.clk(clk), .reset(reset),
.sw(btn[1]),//Entrada original de botón, switch
.db(btn_db[1])//Entrada sin rebote de botón, switch
);

antirrebote Instancia_antirrebote_BTN2//LEFT
(
.clk(clk), .reset(reset),
.sw(btn[2]),//Entrada original de botón, switch
.db(btn_db[2])//Entrada sin rebote de botón, switch
);

antirrebote Instancia_antirrebote_BTN3//RIGHT
(
.clk(clk), .reset(reset),
.sw(btn[3]),//Entrada original de botón, switch
.db(btn_db[3])//Entrada sin rebote de botón, switch
);

endmodule
