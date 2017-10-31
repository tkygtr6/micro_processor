`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/31/2017 01:33:07 PM
// Design Name:
// Module Name: sim_writeback
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


module sim_writeback;
  reg clk, rstd;
  reg [31:0] nextpc;
  wire [31:0] pc;

  initial begin
    clk = 0; forever #50 clk = ~clk;
  end

  initial begin
    rstd = 1;
    #10 rstd = 0;
    #10 rstd = 1;
  end

  initial begin
    #30 nextpc = 0'h00000001;
    #100 nextpc = 0'h12345678;
    #100 nextpc = 0'h87654321;
    #100 nextpc = 0'hffffffff;
  end

  writeback writeback_body(clk, rstd, nextpc, pc);

endmodule
