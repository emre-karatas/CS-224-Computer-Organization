`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.11.2022 12:47:34
// Design Name: 
// Module Name: topTB
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

module topTB();
// initial variables
logic[31:0] writeData, dataadr, pc, instr,readData;
logic clk, reset, memWrite;
// device under test
top dut(clk, reset, writeData, dataadr, pc, instr,readData,memWrite);
initial
    begin
        clk = 0;
        reset = 1;
        #20ns; reset = 0; // reset signal after 20ns
    end
always
    begin
        #10; clk = ~clk;  // clock rising edge every 10 ns
    end
endmodule

