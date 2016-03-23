`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    11:22:27 03/22/2016 
// Design Name: 
// Module Name:    generador_figuras 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Este módulo debe encargarse de generar recuadros que encierran a la hora, fecha, timer,
//así como la figura de "ring" para el timer.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module generador_figuras
(
input wire video_on,//señal que indica que se encuentra en la región visible de resolución 640x480
input wire [9:0] pixel_x, pixel_y,//coordenadas xy de cada pixel
output reg [11:0] fig_RGB //12 bpp (4 bits para cada color)
);

//Declaración de constantes y señales

//Coordenas xy de la región visible
localparam MAX_X = 640;
localparam MAX_Y = 480;

//Límites del recuadro para la hora (320x120)
localparam BOX_H_XL = 160; //Límite izquierdo
localparam BOX_H_XR = 479; //Límite derecho
//localparam BOX_H_YSIZE = 120; //Tamaño vertical
localparam BOX_H_YT = 80;// Límite superior
localparam BOX_H_YB = 199;//Límite inferior

//Límites del recuadro para la fecha (250x120)
localparam BOX_F_XL = 50;//Límite izquierdo
localparam BOX_F_XR = 299;//Límite derecho
localparam BOX_F_YT = 280;//Límite superior
localparam BOX_F_YB = 399;//Límite inferior

//Límites del recuadro para el timer (250x120)
localparam BOX_T_XL = 340;//Límite izquierdo
localparam BOX_T_XR = 589;//Límite derecho
localparam BOX_T_YT = 280;//Límite superior
localparam BOX_T_YB = 399;//Límite inferior

//Límites del recuadro para de alarma "ring" (40x40)
localparam BOX_RING_XL = 550;//Límite izquierdo
localparam BOX_RING_XR = 589;//Límite derecho
localparam BOX_RING_YT = 80;// Límite superior
localparam BOX_RING_YB = 119;//Límite inferior

//Señales de salida de los objetos
wire BOX_H_on, BOX_F_on, BOX_T_on, BOX_RING_on;
wire [11:0] BOX_H_RGB, BOX_F_RGB, BOX_T_RGB, BOX_RING_RGB;

/*Para rellenar con píxeles dentro de los límites 
de los objetos*/

//Recuadro HORA
assign BOX_H_on = (BOX_H_XL<=pixel_x)&&(pixel_x<=BOX_H_XR)
						&&(BOX_H_YT<=pixel_y)&&(pixel_y<=BOX_H_YB);

assign BOX_H_RGB = 12'h0AA;//Turquesa oscuro

//Recuadro FECHA
assign BOX_F_on = (BOX_F_XL<=pixel_x)&&(pixel_x<=BOX_F_XR)
						&&(BOX_F_YT<=pixel_y)&&(pixel_y<=BOX_F_YB);

assign BOX_F_RGB = 12'h0AA;//Turquesa oscuro

//Recuadro TIMER
assign BOX_T_on = (BOX_T_XL<=pixel_x)&&(pixel_x<=BOX_T_XR)
						&&(BOX_T_YT<=pixel_y)&&(pixel_y<=BOX_T_YB);

assign BOX_T_RGB = 12'h0AA;//Turquesa oscuro

//Recuadro RING
assign BOX_RING_on = (BOX_RING_XL<=pixel_x)&&(pixel_x<=BOX_RING_XR)
						&&(BOX_RING_YT<=pixel_y)&&(pixel_y<=BOX_RING_YB);

assign BOX_RING_RGB = 12'hF00;//Rojo puro

//Multiplexar la salida RGB
always @*
begin	
	if(~video_on)
		fig_RGB = 12'b0;//fondo negro
	
	else
		if (BOX_H_on) fig_RGB = BOX_H_RGB;
		else if (BOX_F_on) fig_RGB = BOX_F_RGB;
		else if (BOX_T_on) fig_RGB = BOX_T_RGB;
		else if (BOX_RING_on) fig_RGB = BOX_RING_RGB;
		else fig_RGB = 12'b0;//fondo negro
end
		
endmodule
