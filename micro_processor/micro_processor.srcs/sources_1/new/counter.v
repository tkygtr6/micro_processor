`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 11/13/2017 02:32:45 PM
// Design Name:
// Module Name: counter
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


module counter(clk, rstd, halt);
  input clk, rstd, halt;
  reg[31:0] counter, counter_fin;

  always @(negedge rstd or posedge clk or posedge halt)
    if(rstd == 0) begin
      counter = 32'h00000000;
      counter_fin = 32'h00000000;
    end else if (halt == 1) begin
      // counter = counter + 32'h00000001;
      counter_fin = counter;
    end else begin
      counter = counter + 32'h00000001;
    end

endmodule
