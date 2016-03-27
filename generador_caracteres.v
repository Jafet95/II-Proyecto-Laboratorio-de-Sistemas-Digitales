`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    18:28:34 03/22/2016 
// Design Name: 
// Module Name:    Generador_Caracteres 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: Este módulo se encarga de generar el texto que se requiere en la imagen del monitor.
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module generador_caracteres
(
input wire clk,
input wire [3:0] digit0_HH, digit1_HH, digit0_MM, digit1_MM, digit0_SS, digit1_SS,//
digit0_DAY, digit1_DAY, digit0_MES, digit1_MES, digit0_YEAR, digit1_YEAR,//
digit0_HH_T, digit1_HH_T, digit0_MM_T, digit1_MM_T, digit0_SS_T, digit1_SS_T,//Decenas y unidades para los números en pantalla (18 inputs de 3 bits)
input wire AM_PM,//Entrada para conocer si en la información de hora se despliega AM o PM
input wire [2:0] dia_semana,//Para interpretar el dia de la semana a escribir (3-bits: 7 días)
input wire [1:0] funcion,//2-bits: cuatro estados del modo configuración
input wire [1:0] cursor_location,//Marca la posición del cursor en modo configuración
input wire [9:0] pixel_x, pixel_y,//Coordenada de cada pixel
output wire text_on, //10 "textos" en total en pantalla (bandera de indica que se debe escribir texto)
output reg [11:0] text_RGB //12 bpp (4 bits para cada color)
);

//Declaración de señales

//Font ROM (caracteres 8x16)
wire [10:0] rom_addr; //ASCII 7-bits + Fila 4-bits
reg [6:0] char_addr; //ASCII 7-bits
reg [3:0] row_addr; //Direccion de fila del patrón de caracter en particular
reg [2:0] bit_addr; //Columna del pixel particular de un patrón de caracter
wire [7:0] font_word;//Fila de pixeles del patrón de caracter en particular
wire font_bit;//1 pixel del font_word específicado por bit_addr

//Direcciones "auxiliares" para cada uno de los 9 textos a mostrar
reg [6:0] char_addr_HORA, char_addr_digHORA, char_addr_digFECHA, char_addr_DIA, char_addr_TIMER, char_addr_digTIMER, char_addr_RING, char_addr_AMPM, char_addr_LOGO, char_addr_cursor;
wire [3:0] row_addr_HORA, row_addr_digHORA, row_addr_digFECHA, row_addr_DIA, row_addr_TIMER,row_addr_digTIMER, row_addr_RING, row_addr_AMPM, row_addr_LOGO, row_addr_cursor;
wire [2:0] bit_addr_HORA, bit_addr_digHORA, bit_addr_digFECHA, bit_addr_DIA, bit_addr_TIMER, bit_addr_digTIMER, bit_addr_RING, bit_addr_AMPM, bit_addr_LOGO, bit_addr_cursor; 
wire HORA_on, digHORA_on, digFECHA_on, DIA_on, TIMER_on, digTIMER_on, RING_on, AMPM_on, LOGO_on;
reg cursor_on;
	
//Instanciación de la font ROM
font_rom Instancia_font_unit
(.clk(clk), .addr(rom_addr), .data(font_word));

//Descripción de comportamiento

//1.Palabra HORA (tamaño de fuente 32x64)
assign HORA_on = (pixel_y[9:6]==0)&&(pixel_x[9:5]>=8)&&(pixel_x[9:5]<=11);//Entre cuales coordenadas se encuentra HORA
assign row_addr_HORA = pixel_y[5:2];
assign bit_addr_HORA = pixel_x[4:2];

always@*
begin
	
	case(pixel_x[6:5])
	2'b00: char_addr_HORA = 7'h48;//H
	2'b01: char_addr_HORA = 7'h4f;//O
	2'b10: char_addr_HORA = 7'h52;//R
	2'b11: char_addr_HORA = 7'h41;//A
	endcase
	
end

//2.Dígitos para representar la HORA(tamaño de fuente 32x64)
assign digHORA_on = (pixel_y[9:6]==2)&&(pixel_x[9:5]>=7)&&(pixel_x[9:5]<=14);
assign row_addr_digHORA = pixel_y[5:2];
assign bit_addr_digHORA = pixel_x[4:2];

always@*
begin

	case(pixel_x[7:5])
	3'b000: char_addr_digHORA = {3'b011, digit1_HH};//(decenas hrs)
	3'b001: char_addr_digHORA = {3'b011, digit0_HH};//(unidades hrs)
	3'b010: char_addr_digHORA = 7'h3a;//:
	3'b011: char_addr_digHORA = {3'b011, digit1_MM};//(decenas min)
	3'b100: char_addr_digHORA = {3'b011, digit0_MM};//(unidades min)
	3'b101: char_addr_digHORA = 7'h3a;//:
	3'b110: char_addr_digHORA = {3'b011, digit1_SS};//(decenas s)
	3'b111: char_addr_digHORA = {3'b011, digit0_SS};//(decenas s)
	endcase
	
end

//3.Dígitos para representar la FECHA(tamaño de fuente 16x32)
assign digFECHA_on = (pixel_y[9:5]==11)&&(pixel_x[9:4]>=8)&&(pixel_x[9:4]<=15);
assign row_addr_digFECHA = pixel_y[4:1];
assign bit_addr_digFECHA = pixel_x[3:1];

always@*
begin
	case(pixel_x[6:4])
	3'b000: char_addr_digFECHA = {3'b011, digit1_DAY};//(decenas DIA)
	3'b001: char_addr_digFECHA = {3'b011, digit0_DAY};//(unidades DIA)
	3'b010: char_addr_digFECHA = 7'h2f;//"/"
	3'b011: char_addr_digFECHA = {3'b011, digit1_MES};//(decenas MES)
	3'b100: char_addr_digFECHA = {3'b011, digit0_MES};//(unidades MES)
	3'b101: char_addr_digFECHA = 7'h2f;//"/"
	3'b110: char_addr_digFECHA = {3'b011, digit1_YEAR};//(decenas AÑO)
	3'b111: char_addr_digFECHA = {3'b011, digit0_YEAR};//(decenas AÑO)
	endcase	
end

//4.Día de la semana(tamaño de fuente 16x32)
assign DIA_on = (pixel_y[9:5]==13)&&(pixel_x[9:4]>=8)&&(pixel_x[9:4]<=16);
assign row_addr_DIA = pixel_y[4:1];
assign bit_addr_DIA = pixel_x[3:1];

//El día de la semana se interpreta con un número de 3 bits del 0 al 6 (7 días)
always@*
begin
	case(pixel_x[7:4])
	
	4'h0: //Primera letra
	begin
	case(dia_semana)
	3'b000: char_addr_DIA = 7'h4c;//L
	3'b001: char_addr_DIA = 7'h4d;//M
	3'b010: char_addr_DIA = 7'h4d;//M
	3'b011: char_addr_DIA = 7'h4a;//J
	3'b100: char_addr_DIA = 7'h56;//V
	3'b101: char_addr_DIA = 7'h53;//S
	3'b110: char_addr_DIA = 7'h44;//D
	3'b111: char_addr_DIA = 7'h00;//Espacio en blanco
	default: char_addr_DIA = 7'h00;//Espacio en blanco
	endcase
	end
	
	4'h1: //Segunda letra
	begin
	case(dia_semana)
	3'b000: char_addr_DIA = 7'h55;//U
	3'b001: char_addr_DIA = 7'h41;//A
	3'b010: char_addr_DIA = 7'h49;//I
	3'b011: char_addr_DIA = 7'h55;//U
	3'b100: char_addr_DIA = 7'h49;//I
	3'b101: char_addr_DIA = 7'h41;//A
	3'b110: char_addr_DIA = 7'h4f;//O
	3'b111: char_addr_DIA = 7'h00;//Espacio en blanco
	default: char_addr_DIA = 7'h00;//Espacio en blanco
	endcase
	end
	
	4'h2: //Tercera letra
	begin
	case(dia_semana)
	3'b000: char_addr_DIA = 7'h4e;//N
	3'b001: char_addr_DIA = 7'h52;//R
	3'b010: char_addr_DIA = 7'h45;//E
	3'b011: char_addr_DIA = 7'h45;//E
	3'b100: char_addr_DIA = 7'h45;//E
	3'b101: char_addr_DIA = 7'h42;//B
	3'b110: char_addr_DIA = 7'h4d;//M
	3'b111: char_addr_DIA = 7'h00;//Espacio en blanco
	default: char_addr_DIA = 7'h00;//Espacio en blanco
	endcase
	end
	
	4'h3: //Cuarta letra
	begin
	case(dia_semana)
	3'b000: char_addr_DIA = 7'h45;//E
	3'b001: char_addr_DIA = 7'h54;//T
	3'b010: char_addr_DIA = 7'h52;//R
	3'b011: char_addr_DIA = 7'h56;//V
	3'b100: char_addr_DIA = 7'h52;//R
	3'b101: char_addr_DIA = 7'h41;//A
	3'b110: char_addr_DIA = 7'h49;//I
	3'b111: char_addr_DIA = 7'h00;//Espacio en blanco
	default: char_addr_DIA = 7'h00;//Espacio en blanco
	endcase
	end

	4'h4: //Quinta letra
	begin
	case(dia_semana)
	3'b000: char_addr_DIA = 7'h53;//S
	3'b001: char_addr_DIA = 7'h45;//E
	3'b010: char_addr_DIA = 7'h43;//C
	3'b011: char_addr_DIA = 7'h45;//E
	3'b100: char_addr_DIA = 7'h4e;//N
	3'b101: char_addr_DIA = 7'h46;//D
	3'b110: char_addr_DIA = 7'h4e;//N
	3'b111: char_addr_DIA = 7'h00;//Espacio en blanco
	default: char_addr_DIA = 7'h00;//Espacio en blanco
	endcase
	end
	
	4'h5: //Sexta letra
	begin
	case(dia_semana)
	3'b000: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b001: char_addr_DIA = 7'h53;//S
	3'b010: char_addr_DIA = 7'h4f;//O
	3'b011: char_addr_DIA = 7'h53;//S
	3'b100: char_addr_DIA = 7'h45;//E
	3'b101: char_addr_DIA = 7'h4f;//O
	3'b110: char_addr_DIA = 7'h47;//G
	3'b111: char_addr_DIA = 7'h00;//Espacio en blanco
	default: char_addr_DIA = 7'h00;//Espacio en blanco
	endcase
	end
	
	4'h6: //Séptima letra
	begin
	case(dia_semana)
	3'b000: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b001: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b010: char_addr_DIA = 7'h4c;//L
	3'b011: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b100: char_addr_DIA = 7'h53;//S
	3'b101: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b110: char_addr_DIA = 7'h4f;//O
	3'b111: char_addr_DIA = 7'h00;//Espacio en blanco
	default: char_addr_DIA = 7'h00;//Espacio en blanco
	endcase
	end
	
	4'h7: //Octava letra
	begin
	case(dia_semana)
	3'b000: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b001: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b010: char_addr_DIA = 7'h45;//E
	3'b011: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b100: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b101: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b110: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b111: char_addr_DIA = 7'h00;//Espacio en blanco
	default: char_addr_DIA = 7'h00;//Espacio en blanco
	endcase
	end
	
	4'h8: //Novena letra
	begin
	case(dia_semana)
	3'b000: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b001: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b010: char_addr_DIA = 7'h53;//S
	3'b011: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b100: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b101: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b110: char_addr_DIA = 7'h00;//Espacio en blanco
	3'b111: char_addr_DIA = 7'h00;//Espacio en blanco
	default: char_addr_DIA = 7'h00;//Espacio en blanco
	endcase
	end
	
	default: char_addr_DIA = 7'h00;//Espacio en blanco
	endcase	
end

//5.Palabra TIMER(tamaño de fuente 16x32)
assign TIMER_on = (pixel_y[9:5]==13)&&(pixel_x[9:4]>=27)&&(pixel_x[9:4]<=31);
assign row_addr_TIMER = pixel_y[4:1];
assign bit_addr_TIMER = pixel_x[3:1];

always@*
begin
	case(pixel_x[6:4])
	3'b000: char_addr_TIMER = 7'h54;//T
	3'b001: char_addr_TIMER = 7'h49;//I
	3'b010: char_addr_TIMER = 7'h4d;//M
	3'b011: char_addr_TIMER = 7'h45;//E
	3'b100: char_addr_TIMER = 7'h52;//R
	default: char_addr_TIMER = 7'h00;//Espacio en blanco
	endcase	
end

//6.Dígitos para la cuenta del TIMER(tamaño de fuente 16x32)
assign digTIMER_on = (pixel_y[9:5]==11)&&(pixel_x[9:4]>=26)&&(pixel_x[9:4]<=33);
assign row_addr_digTIMER = pixel_y[4:1];
assign bit_addr_digTIMER = pixel_x[3:1];

always@*
begin
	case(pixel_x[6:4])
	3'b000: char_addr_digTIMER = {3'b011, digit1_HH_T};//(decenas DIA)
	3'b001: char_addr_digTIMER = {3'b011, digit0_HH_T};//(unidades DIA)
	3'b010: char_addr_digTIMER = 7'h3a;//:
	3'b011: char_addr_digTIMER = {3'b011, digit1_MM_T};//(decenas MES)
	3'b100: char_addr_digTIMER = {3'b011, digit0_MM_T};//(unidades MES)
	3'b101: char_addr_digTIMER = 7'h3a;//:
	3'b110: char_addr_digTIMER = {3'b011, digit1_SS_T};//(decenas AÑO)
	3'b111: char_addr_digTIMER = {3'b011, digit0_SS_T};//(decenas AÑO)
	endcase	
end

//7.Palabra RING(tamaño de fuente 32x64)
assign RING_on = (pixel_y[9:6]==2)&&(pixel_x[9:5]>=16)&&(pixel_x[9:5]<=19);
assign row_addr_RING = pixel_y[5:2];
assign bit_addr_RING = pixel_x[4:2];

always@*
begin
	
	case(pixel_x[6:5])
	2'b00: char_addr_RING = 7'h52;//R
	2'b01: char_addr_RING = 7'h49;//I
	2'b10: char_addr_RING = 7'h4e;//N
	2'b11: char_addr_RING = 7'h47;//G
	endcase
	
end

//8.Palabra AM o PM(tamaño de fuente 16x32)
assign AMPM_on = (pixel_y[9:5]==1)&&(pixel_x[9:4]>=26)&&(pixel_x[9:4]<=27);
assign row_addr_AMPM = pixel_y[4:1];
assign bit_addr_AMPM = pixel_x[3:1];

always@*
begin
	case(pixel_x[4])
	
	1'b0:
	begin
	case(AM_PM)//AM_PM = 0: se escribe AM
	1'b0: char_addr_AMPM = 7'h41;//A
	1'b1: char_addr_AMPM = 7'h50;//P
	endcase
	end
	
	1'b1: char_addr_AMPM = 7'h4d;//M
	endcase	
end

//9.Texto RTC DISPLAY v1.0(tamaño de fuente 8x16)(16 caracteres)
assign LOGO_on = (pixel_y[9:4]==0)&&(pixel_x[9:3]<=15);
assign row_addr_LOGO = pixel_y[3:0];
assign bit_addr_LOGO = pixel_x[2:0];

always@*
begin
	case(pixel_x[7:4])
	4'h0: char_addr_LOGO = 7'h52;//R
	4'h1: char_addr_LOGO = 7'h54;//T
	4'h2: char_addr_LOGO = 7'h43;//C
	4'h3: char_addr_LOGO = 7'h00;//Espacio
	4'h4: char_addr_LOGO = 7'h44;//D
	4'h5: char_addr_LOGO = 7'h49;//I
	4'h6: char_addr_LOGO = 7'h53;//S
	4'h7: char_addr_LOGO = 7'h50;//P
	4'h8: char_addr_LOGO = 7'h4c;//L
	4'h9: char_addr_LOGO = 7'h41;//A
	4'ha: char_addr_LOGO = 7'h59;//Y
	4'hb: char_addr_LOGO = 7'h00;//Espacio
	4'hc: char_addr_LOGO = 7'h56;//v
	4'hd: char_addr_LOGO = 7'h31;//1
	4'he: char_addr_LOGO = 7'h2e;//.
	4'hf: char_addr_LOGO = 7'h30;//0
	endcase	
end

//10.Flecha cursor(tamaño de fuente 16x32)(posición variable)
always@*
begin
	case(funcion)//Evalúa que se está configurando (0: modo normal, 1: config.hora, 2: config.fecha, 3: config.timer)
	
	2'h0: 
	begin
	char_addr_cursor = 7'h00;//Espacio en blanco
	cursor_on = (pixel_y[9:5]==6)&&(pixel_x[9:4]<=25)&&(pixel_x[9:4]<=28);
	end
	
	2'h1://Hora
	begin
	char_addr_cursor = 7'h1e;//flecha hacia arriba
	case(cursor_location)//(0: Los dos dígitos a la derecha, 1: Los dos dígitos intermedios, 2: Los dos dígitos a la izquierda)
	2'h0: cursor_on = (pixel_y[9:5]==6)&&(pixel_x[9:4]<=25)&&(pixel_x[9:4]<=28);//4 flechas
	2'h1: cursor_on = (pixel_y[9:5]==6)&&(pixel_x[9:4]<=19)&&(pixel_x[9:4]<=22);
	2'h2: cursor_on = (pixel_y[9:5]==6)&&(pixel_x[9:4]<=13)&&(pixel_x[9:4]<=16);
	default: cursor_on = (pixel_y[9:5]==6)&&(pixel_x[9:4]<=25)&&(pixel_x[9:4]<=28);
	endcase
	end
	
	2'h2://Fecha
	begin
	char_addr_cursor = 7'h1e;//flecha hacia arriba
	case(cursor_location)//(0: primeros dos dígitos a la derecha, 1: dos dígitos intermedios, 2: últimos dos dígitos a la izquierda)
	2'h0: cursor_on = (pixel_y[9:5]==11)&&(pixel_x[9:4]<=14)&&(pixel_x[9:4]<=15);//2 flechas
	2'h1: cursor_on = (pixel_y[9:5]==11)&&(pixel_x[9:4]<=11)&&(pixel_x[9:4]<=12);
	2'h2: cursor_on = (pixel_y[9:5]==11)&&(pixel_x[9:4]<=8)&&(pixel_x[9:4]<=9);
	default: cursor_on = (pixel_y[9:5]==11)&&(pixel_x[9:4]<=14)&&(pixel_x[9:4]<=15);
	endcase
	end
	
	2'h3://Timer
	begin
	char_addr_cursor = 7'h1e;//flecha hacia arriba
	case(cursor_location)//(0: primeros dos dígitos a la derecha, 1: dos dígitos intermedios, 2: últimos dos dígitos a la izquierda)
	2'h0: cursor_on = (pixel_y[9:5]==11)&&(pixel_x[9:4]<=32)&&(pixel_x[9:4]<=33);//2 flechas
	2'h1: cursor_on = (pixel_y[9:5]==11)&&(pixel_x[9:4]<=29)&&(pixel_x[9:4]<=30);
	2'h2: cursor_on = (pixel_y[9:5]==11)&&(pixel_x[9:4]<=26)&&(pixel_x[9:4]<=27);
	default: cursor_on = (pixel_y[9:5]==11)&&(pixel_x[9:4]<=13)&&(pixel_x[9:4]<=16);
	endcase
	end
	
	endcase
end

assign row_addr_cursor = pixel_y[4:1];
assign bit_addr_cursor = pixel_x[3:1];


//Multiplexar las direcciones para font ROM y salida RBG
always @*
begin

text_RGB = 12'b0;//Fondo negro
	
	if(HORA_on)
		begin
		char_addr = char_addr_HORA;
      row_addr = row_addr_HORA;
      bit_addr = bit_addr_HORA;
			if(font_bit) text_RGB = 12'h2F2; //Verde
		end
	
	else if(digHORA_on)
		begin
		char_addr = char_addr_digHORA;
      row_addr = row_addr_digHORA;
      bit_addr = bit_addr_digHORA;
			if(font_bit) text_RGB = 12'hFFF; //Blanco
		end

	else if(digFECHA_on)
		begin
		char_addr = char_addr_digFECHA;
      row_addr = row_addr_digFECHA;
      bit_addr = bit_addr_digFECHA;
			if(font_bit) text_RGB = 12'hFFF; //Blanco
		end
	
	else if(DIA_on)
		begin
		char_addr = char_addr_DIA;
      row_addr = row_addr_DIA;
      bit_addr = bit_addr_DIA;
			if(font_bit) text_RGB = 12'h2F2; //Verde
		end
		
	else if(TIMER_on)
		begin
		char_addr = char_addr_TIMER;
      row_addr = row_addr_TIMER;
      bit_addr = bit_addr_TIMER;
			if(font_bit) text_RGB = 12'h2F2; //Verde
		end

	else if(digTIMER_on)
		begin
		char_addr = char_addr_digTIMER;
      row_addr = row_addr_digTIMER;
      bit_addr = bit_addr_digTIMER;
			if(font_bit) text_RGB = 12'hFFF; //Blanco
		end

	else if (RING_on)
		begin
		char_addr = char_addr_RING;
      row_addr = row_addr_RING;
      bit_addr = bit_addr_RING;
			if(font_bit) text_RGB = 12'hF11; //Rojo
		end
	
	else if (AMPM_on)
		begin
		char_addr = char_addr_AMPM;
      row_addr = row_addr_AMPM;
      bit_addr = bit_addr_AMPM;
			if(font_bit) text_RGB = 12'hFFF; //Blanco
		end

	else if (LOGO_on)
		begin 
		char_addr = char_addr_LOGO;
      row_addr = row_addr_LOGO;
      bit_addr = bit_addr_LOGO;
			if(font_bit) text_RGB = 12'hF11; //Blanco
		end
	
	else
		begin 
		char_addr = char_addr_cursor;
      row_addr = row_addr_cursor;
      bit_addr = bit_addr_cursor;
			if(font_bit) text_RGB = 12'hF11; //Blanco
		end	

end

assign text_on = HORA_on|digHORA_on|digFECHA_on|DIA_on|TIMER_on|digTIMER_on|RING_on|AMPM_on|LOGO_on|cursor_on;//10 bloques de texto en total

//Interfaz con la font ROM
assign rom_addr = {char_addr, row_addr};
assign font_bit = font_word[~bit_addr];

endmodule
/*
Nota: Los 10 textos a mostrar son
1.La palabra HORA
2.Los dígitos para la hora
3.Los números de la fecha
4.El día de la semana
5.La palabra TIMER
6.Los dígitos para la cuenta del timer
7.La palabra RING
8.AM o PM
9.RTC DISPLAY v1.0
10.Una flecha que hace de cursor para el modo configuración (posición variable)
*/