`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Jafet Chaves Barrantes
// 
// Create Date:    21:25:31 04/04/2016 
// Design Name: 
// Module Name:    contadores_configuracion 
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
module contadores_configuracion
(
input wire clk, 
input wire reset,
input wire enUP,
input wire enDOWN,
input wire enLEFT,
input wire enRIGHT,
input wire [2:0] config_mode,//Cuatro estados del modo configuración
output wire [7:0] btn_data_SS, btn_data_MM, btn_data_HH, btn_data_YEAR, btn_data_MES, btn_data_DAY,
btn_data_SS_T, btn_data_MM_T, btn_data_HH_T,//Decenas y unidades para los números en pantalla(configuración)
output wire AM_PM,//Entrada para conocer si en la información de hora se despliega AM o PM
output wire [7:0] dia_semana,//Para interpretar el dia de la semana a escribir (3-bits: 7 días)*****
output wire [1:0] cursor_location//Marca la posición del cursor en modo configuración
);

localparam N = 2;//Bits del contador de desplazamiento horizontal

reg [N-1:0] q_act, q_next;
reg enLEFT_reg, enRIGHT_reg;
wire enLEFT_tick, enRIGHT_tick;
wire [N-1:0] count_horizontal;
reg [3:0]enable_counters;//10 contadores en total de hora, fecha, timer

//Detección de flancos
always@(posedge clk)
begin
enLEFT_reg <= enLEFT;
enRIGHT_reg <= enRIGHT;
end

assign enLEFT_tick = ~enLEFT_reg & enLEFT;
assign enRIGHT_tick = ~enRIGHT_reg & enRIGHT;

//Contador horizontal
//Descripción del comportamiento
always@(posedge clk)
begin	
	
	if(reset)
	begin
		q_act <= 2'b0;
	end
	
	else
	begin
		q_act <= q_next;
	end
end

//Lógica de salida
always@*
begin
	if(enLEFT_tick)
	begin
	q_next = q_act + 1'b1;
	end
	
	else if(enRIGHT_tick)
	begin
	q_next = q_act - 1'b1;
	end
	
	else if(enLEFT_tick && q_act == 2 && config_mode == 1)
	begin
	q_next = 5'd0;
	end
	
	else if(enRIGHT_tick && q_act == 0 && config_mode == 1)
	begin
	q_next = 5'd2;
	end
	
	else if(enLEFT_tick && q_act == 2 && config_mode == 4)
	begin
	q_next = 5'd0;
	end
	
	else if(enRIGHT_tick && q_act == 0 && config_mode == 4)
	begin
	q_next = 5'd2;
	end	
	
	else
	begin
	q_next = q_act;
	end
end

assign count_horizontal = q_act;

//Instancias contadores de hora, fecha y timer

contador_AD_SS_2dig Instancia_contador_SS//Segundos de la hora
(
.clk(clk),
.reset(reset),
.en_count(enable_counters),
.enUP(enUP),
.enDOWN(enDOWN),
.data_SS(btn_data_SS)
);

contador_AD_MM_2dig Instancia_contador_MM//Minutos de la hora
(
.clk(clk),
.reset(reset),
.enUP(enUP),
.enDOWN(enDOWN),
.en_count(enable_counters),
.data_MM(btn_data_MM)
);

contador_AD_HH_2dig Instancia_contador_HH//Horas de la hora
(
.clk(clk), 
.reset(reset),
.en_count(enable_counters),
.enUP(enUP),
.enDOWN(enDOWN),
.AM_PM(AM_PM),
.data_HH(btn_data_HH)
);   

contador_AD_YEAR_2dig Instancia_contador_YEAR//Años de la fecha
(
.clk(clk),
.reset(reset),
.enUP(enUP),
.en_count(enable_counters),
.enDOWN(enDOWN),
.data_YEAR(btn_data_YEAR)
);

contador_AD_MES_2dig Instancia_contador_MES//Meses de la fecha
(
.clk(clk),
.reset(reset),
.en_count(enable_counters),
.enUP(enUP),
.enDOWN(enDOWN),
.data_MES(btn_data_MES)
);

contador_AD_DAY_2dig Instancia_contador_DAY//Día de la fecha
(
.clk(clk),
.reset(reset),
.en_count(enable_counters),
.enUP(enUP),
.enDOWN(enDOWN),
.data_DAY(btn_data_DAY)
);

contador_AD_dia_semana Instancia_contador_dia_semana//Día de la semana
(
.clk(clk),
.reset(reset),
.en_count(enable_counters),
.enUP(enUP),
.enDOWN(enDOWN),
.count_data(dia_semana)//Para interpretar el dia de la semana a escribir (3-bits: 7 días)
);

contador_AD_SS_T_2dig Instancia_contador_SS_T//Segundos del timer
(
.clk(clk),
.reset(reset),
.en_count(enable_counters),
.enUP(enUP),
.enDOWN(enDOWN),
.data_SS_T(btn_data_SS_T)
);

contador_AD_MM_T_2dig Instancia_contador_MM_T//Minutos del timer
(
.clk(clk),
.reset(reset),
.en_count(enable_counters),
.enUP(enUP),
.enDOWN(enDOWN),
.data_MM_T(btn_data_MM_T)
);

contador_AD_HH_T_2dig Instancia_contador_HH_T //Horas del timer
(
.clk(clk),
.reset(reset),
.en_count(enable_counters),
.enUP(enUP),
.enDOWN(enDOWN),
.data_HH_T(btn_data_HH_T)
);

//Lógica de activación de cada contador dependiendo del modo configuración y la cuenta horizontal
always@*

	case(config_mode)//Evalúa que se está configurando (0: modo normal, 1: config.hora, 2: config.fecha, 3: config.timer)

	3'd0://Modo normal no habilita ningún contador
	begin
	enable_counters = 4'b0;
	end
	
	3'd1:
	begin
		case(count_horizontal)
		
		2'd0: enable_counters = 4'd1;//SS
		2'd1: enable_counters = 4'd2;//MM
		2'd2: enable_counters = 4'd3;//HH
		default: enable_counters = 4'd0;
	
		endcase
	end
	3'd2:
		case(count_horizontal)
		
		2'd0: enable_counters = 4'd4;//Año 
		2'd1: enable_counters = 4'd5;//Mes
		2'd2: enable_counters = 4'd6;//Día
		2'd3: enable_counters = 4'd7;//Día de la semana
		
		endcase
	3'd4:
		case(count_horizontal)
		
		2'd0: enable_counters = 4'd8;//SS_T
		2'd1: enable_counters = 4'd9;//MM_T
		2'd2: enable_counters = 4'd10;//HH_T
		default: enable_counters = 4'd0;
		
		endcase
	default: enable_counters = 4'b0;
	endcase

assign cursor_location = count_horizontal;
endmodule
