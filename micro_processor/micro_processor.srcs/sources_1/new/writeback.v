`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/31/2017 01:30:28 PM
// Design Name:
// Module Name: writeback
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


module writeback(clk, rstd, nextpc, pc);
  input clk, rstd;
  input [31:0] nextpc;
  output [31:0] pc;
  reg[31:0] pc;

  always @(negedge rstd or posedge clk)
    begin
      if(rstd == 0)pc <= 32'h00000000;
      else if (clk == 1)pc <= nextpc;
    end
endmodule
