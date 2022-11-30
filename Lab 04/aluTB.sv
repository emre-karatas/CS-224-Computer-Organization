`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.11.2022 16:54:37
// Design Name: 
// Module Name: aluTB
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

module alu_tb();
    // initial variables
    logic[31:0] a, b, result;
    logic[2:0] alucont;
    logic zero;

    // initialize the device
    alu dut(a, b, alucont, result, zero);

    initial
    begin
        a = 4; b = 6; alucont = 3'b000; #10; //and
        assert(result === 4) else $error("and failed.");
        a = 6; b = 4; alucont = 3'b001; #10; //or
        assert(result === 6) else $error("or failed.");
        a = 1; b = 7; alucont = 3'b010; #10; //add
        assert(result === 8) else $error("addition failed.");
        a = 10; b = 8; alucont = 3'b110; #10; //subtract
        assert(result === 2) else $error("subtraction failed.");
        a = 18; b = 18; alucont = 3'b110; #10; //subtract
        assert(result === 0) else $error("subtraction failed.");
        a = 3; b = 8; alucont = 3'b110; #10; //subtract
        assert(result === -5) else $error("subtraction failed.");
        a = 18; b = 19; alucont = 3'b111; #10; //set less than
        assert(result === 1) else $error("set less than failed.");
        a = 19; b = 18; alucont = 3'b111; #10; //set less than
        assert(result === 0) else $error("set less than failed.");
    end
endmodule