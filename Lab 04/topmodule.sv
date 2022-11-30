`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2022 16:56:38
// Design Name: 
// Module Name: topmodule
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module topmodule(input logic clk, reset,clear, clk_button,
	     output logic [6:0]seg,
	     output logic [3:0]an,
	     output logic dp,	     
	     output memwrite);    
	     
	     logic[31:0] writedata, dataadr;
	     logic[31:0] pc, instr, readdata;
	     logic clk_new, reset_new;

   // instantiate processor and memories 
   top new_top(clk_new, reset_new,writedata, dataadr,pc, instr, readdata,memwrite);
   display_controller disp(clk,writedata[7:4],writedata[3:0] ,dataadr[7:4],dataadr[3:0], seg, dp,an );
   pulse_controller clkres(clk, reset, 1'b0,reset_new);
   pulse_controller clkbut(clk, clk_button, 1'b0,clk_new);
   

endmodule


