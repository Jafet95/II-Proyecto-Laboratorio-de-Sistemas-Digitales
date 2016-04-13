`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:13:44 04/11/2016 
// Design Name: 
// Module Name:    traducto_addr_rtc_addr_mem_local 
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
module traducto_addr_rtc_addr_mem_local(
	input clk,
	input reset,
	input [7:0]addr_rtc,
	output reg [3:0]addr_mem_local
    );
	 always@(posedge clk , posedge reset) 
	 begin
	 if (reset) addr_mem_local = 4'b1111;
	 else begin
	 case (addr_rtc)
		8'h21: addr_mem_local = 4'b0000;
		8'h22: addr_mem_local = 4'b0001;
		8'h23: addr_mem_local = 4'b0010;
		8'h24: addr_mem_local = 4'b0011;
		8'h25: addr_mem_local = 4'b0100;
		8'h26: addr_mem_local = 4'b0101;
		8'h27: addr_mem_local = 4'b0110;
		8'h41: addr_mem_local = 4'b0111;
		8'h42: addr_mem_local = 4'b1000;
		8'h43: addr_mem_local = 4'b1001;
		default: addr_mem_local = 4'b1111;
		endcase
		end
	 end

endmodule