`timescale 1ns / 1ps
////////////////////////////////////////////////////////
//  
//  This module puts 4 hexadecimal values (from O to F) on the 4-digit 7-segment display unit
//  
//  Inputs/Outputs:  
//  clk: the system clock on the BASYS3 board
//  in3, in2, in1, in0: the input hexadecimal values. in3(left), in2, in1, in0(right)         
//  seg: the signals going to the segments of a digit.
//       seg[6] is CA for the a segment, seg[5] is CB for the b segment, etc
//  an:  anode, 4 bit enable signal, one bit for each digit
//       an[3] is the left-most digit, an[2] is the second-left-most, etc  
//  dp:  digital point
//  
//  Usage for CS224 Lab4-5: 
//  - Give the system clock of BASYS3 and the hexadecimal values you want to display as inputs.
//  - Send outputs to 7-segment display of BASYS3, using the .XDC file
//
//  Note: the an, seg and dp outputs are active-low, for the BASYS3 board
//
//  For correct connections, carefully plan what should be in the .XDC file
//   
////////////////////////////////////////////////////////
module display_controller(

input clk,
input [3:0] in3, in2, in1, in0,
output [6:0]seg, logic dp,
output [3:0] an
);

localparam N = 19;

logic [N-1:0] count = {N{1'b0}};
always@ (posedge clk)
count <= count + 1;

logic [4:0]digit_val;

logic [3:0]digit_en;

logic [6:0] segments;
		
      assign an = ~(digit_val);// AN signals are active low on the BASYS3 board,
                                // and must be enabled in order to display the digit
      assign seg = ~segments;     // segments must be inverted, since the C values are active low
      assign dp = 1;            // makes the dot point always off 
                                // (0 = on, since it is active low)

// the upper 2 bits of count will cycle through the digits and the AN patterns
//  from left to right across the display unit			
	always_comb
	   case (count[N-1:N-2])
                // left most, AN3  
		2'b00: begin digit_en = in3; digit_val = 4'b1000; end  
		2'b01: begin digit_en = in2; digit_val = 4'b0100; end
		2'b10: begin digit_en = in1; digit_val = 4'b0010; end
		2'b11: begin digit_en = in0; digit_val = 4'b0001; end
                // right most, AN0
		default: begin digit_en = 4'bxxxx; digit_val= 4'bxxxx; end
	   endcase

// the hex-to-7-segment decoder
	always_comb
		case (digit_en)
		4'b0000: segments = 7'b111_1110;  // 0
		4'b0001: segments = 7'b011_0000;  // 1
		4'b0010: segments = 7'b110_1101;  // 2
		4'b0011: segments = 7'b111_1001;  // 3
		4'b0100: segments = 7'b011_0011;  // 4
		4'b0101: segments = 7'b101_1011;  // 5
		4'b0110: segments = 7'b101_1111;  // 6
		4'b0111: segments = 7'b111_0000;  // 7
		4'b1000: segments = 7'b111_1111;  // 8
		4'b1001: segments = 7'b111_0011;  // 9
		4'b1010: segments = 7'b111_0111;  // A
		4'b1011: segments = 7'b001_1111;  // b
		4'b1100: segments = 7'b000_1101;  // c
		4'b1101: segments = 7'b011_1101;  // d
		4'b1110: segments = 7'b100_1111;  // E
		4'b1111: segments = 7'b100_0111;  // F
		default: segments = 7'bxxx_xxxx;
		endcase		

endmodule