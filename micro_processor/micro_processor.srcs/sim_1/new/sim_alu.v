`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/30/2017 02:05:13 PM
// Design Name:
// Module Name: sim_alu
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


module sim_alu;
  reg[4:0] opr, shift;
  reg[31:0] operand1, operand2, result;

function [31:0] alu;
  input [4:0] opr, shift;
  input [31:0] operand1, operand2;
  case(opr)
    5'd0: alu = operand1 + operand2;
    5'd1: alu = operand1 - operand2;
    5'd8: alu = operand1 & operand2;
    5'd9: alu = operand1 | operand2;
    5'd10: alu = operand1 ^ operand2;
    5'd11: alu = ~(operand1 & operand2);
    5'd16: alu = operand1 << shift;
    5'd17: alu = operand1 >> shift;
    5'd18: alu = operand1 >>> shift;
    default: alu = 32'hffffffff;
  endcase
endfunction

initial begin
  opr = 0; shift = 0;
  operand1 = 32'h00000000; operand2 = 32'h00000000;
  result = alu(opr, shift, operand1, operand2);

  #100 operand1 = 32'h00000000; operand2 = 32'h00000001;
  result = alu(opr, shift, operand1, operand2);
  end
endmodule
