`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/26/2017 02:59:02 PM
// Design Name:
// Module Name: sim_fetch
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


module sim_fetch;
  reg clk, rst;
  reg [31:0] pc;
  wire [31:0] ins;

  initial begin
    clk=0; forever #50 clk =!clk;
  end

  initial begin
    rst = 1;
    #10 rst = 0;
    #20 rst = 1;
  end

  always @(negedge rst or posedge clk)
    begin
      if (rst == 0)pc <= 0;
      else if(clk == 1)pc <= pc + 1;
    end

  initial
    $monitor($stime, "\rst = %b, clk = %b, pc= %d, ins=%b", rst, clk, pc, ins);

  fetch fetch_body(pc, ins);
endmodule
