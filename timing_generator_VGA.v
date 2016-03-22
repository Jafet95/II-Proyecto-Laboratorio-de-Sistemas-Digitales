`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    11:45:21 03/21/2016 
// Design Name: 
// Module Name:    timing_generator_VGA 
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
module timing_generator_VGA
(
input wire clk,reset,
output wire hsync,vsync,video_on,p_tick,
output wire [9:0] pixel_x, pixel_y
);

//Declaración de constantes

//Parámetros para VGA 640x480 
localparam HD = 640;//área de despliegue horizontal
localparam HF = 48;// borde izquierdo horizontal
localparam HB = 16;//borde derecho horizontal
localparam HR = 96;//retraso horizontal
localparam VD = 480;//área de despliegue vertical
localparam VF = 10;//borde superior vertical
localparam VB = 33;//borde inferior vertical
localparam VR = 2;//retraso vertical

//Contadores

//Contador para la división de frecuencia (100 MHz a 25 MHz)
//reg mod2_reg;
//wire mod2_next;

reg cuenta, CV;

//Contadores de "timing" vertical y horizontal
reg[9:0] h_count_reg, h_count_next;
reg[9:0] v_count_reg, v_count_next;
reg h_sync_reg, v_sync_reg;
wire h_sync_next, v_sync_next;

//Señales de status
wire h_end, v_end; 
wire pixel_tick;

//Definición de comportamiento

//Registros
always @(posedge clk, posedge reset)
begin
if(reset)
	begin
	//mod2_reg <= 1'b0;
	h_count_reg <= 0;
	v_count_reg <= 0;
	h_sync_reg <= 1'b0;
	v_sync_reg <= 1'b0;
	end

else
	begin
	//mod2_reg <= mod2_next;
	h_count_reg <= h_count_next;
	v_count_reg <= v_count_next;
	h_sync_reg <= h_sync_next;
	v_sync_reg <= v_sync_next;		
	end
end

//Para generar 25 MHz

always@(posedge clk, posedge reset)
begin

	if(reset)
	begin
	cuenta <= 0; 
	CV <= 0;
	end
	
	else
	begin
		if (cuenta == 1'b1)
			begin
			cuenta <= 0;
			CV <= ~CV;
			end
		else
			cuenta <= cuenta + 1'b1;
	end
end	
//assign mod2_next = ~mod2_reg;
assign pixel_tick = CV;


//Definición señales de status

//Final del contador horizontal (799)
assign h_end = (h_count_reg == (HD+HF+HB+HR-1));

//Final contador vertical (524)
assign v_end = (v_count_reg == (VD+VF+VB+VR-1));

//Lógicas de estado siguiente de los contadores

//Contador horizontal
always@(negedge pixel_tick)
begin
	//if(pixel_tick) //pulso de 25 MHz	
		if(h_end)
		h_count_next = 0;
	
		else
		h_count_next = h_count_reg + 1'b1;
	
/*	else
	h_count_next = h_count_reg; //Mantiene la cuenta*/
end

//Contador vertical
always@(negedge pixel_tick)
begin
	//if(pixel_tick & h_end) //pulso de 25 MHz y final de fila
	if(h_end) //pulso de 25 MHz y final de fila
		
		if(v_end)
		v_count_next = 0;
	
		else
		v_count_next = v_count_reg + 1'b1;
	
	else
	v_count_next = v_count_reg; //Mantiene la cuenta
end

/*h_sync_next puesto en bajo para generar retraso
entre la cuentas 656 y 751*/
assign h_sync_next = (h_count_reg >= (HD+HB)&&
							 h_count_reg <=(HD+HB+HR-1));

/*v_sync_next puesto en bajo para generar retraso
entre la cuentas 490 y 491*/
assign v_sync_next = (v_count_reg >= (VD+VB)&&
							 v_count_reg <=(VD+VB+VR-1));

//Asignación de salidas

//Para generar señal video on/off
assign video_on = (h_count_reg < HD) && (v_count_reg < VD); //Para mantener una forma de saber si el pixel está en la región visible
assign hsync = ~h_sync_reg;
assign vsync = ~v_sync_reg;
assign pixel_x = h_count_reg; //Coordenada x
assign pixel_y = v_count_reg; //Coordenada y
assign p_tick = pixel_tick; //Ayuda a coordinar la creación de imágenes (módulo de generación de píxeles)

endmodule

/*Notas: 
1. La frecuencia del "timing" vertical
define el tiempo de refresco de la pantalla
(30 fps, 60 fps,etc)
2. 25 MHz es la frecuencia de escritura de cada
píxel (pixel_clk)
3.video_on debe tener un período igual al que corresponde escribir sobre la región visible*/
