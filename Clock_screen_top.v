`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    16:10:41 03/22/2016 
// Design Name: 
// Module Name:    Clock_screen_top 
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
module Clock_screen_top
(
input wire clk, reset,
output wire hsync,vsync,
output wire [11:0] RGB,
output wire pixel_tick
);

wire [9:0] pixel_x,pixel_y;
wire video_on; 
//wire pixel_tick;
reg [11:0] RGB_reg;
wire [11:0] RGB_next;

//Instanciaciones

timing_generator_VGA Instancia_timing_generator_VGA
(
.clk(clk),
.reset(reset),
.hsync(hsync),
.vsync(vsync),
.video_on(video_on),
.p_tick(pixel_tick),
.pixel_x(pixel_x), 
.pixel_y(pixel_y)
);

generador_figuras Instancia_generador_figuras
(
.video_on(video_on),//señal que indica que se encuentra en la región visible de resolución 640x480
.pixel_x(pixel_x), 
.pixel_y(pixel_y),//coordenadas xy de cada pixel
.fig_RGB(RGB) //12 bpp (4 bits para cada color)
);

endmodule
