`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/31/2017 02:38:36 PM
// Design Name:
// Module Name: sim_computer
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


module sim_computer;
  reg clk, rstd;

  initial begin
    rstd = 1;
    #10 rstd = 0;
    #10 rstd = 1;
  end

  initial begin
    clk = 0; forever #50 clk=~clk;
  end

  computer computef3_body(clk, rstd);

endmodule
