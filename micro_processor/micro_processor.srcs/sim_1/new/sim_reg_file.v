`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/31/2017 01:56:07 PM
// Design Name:
// Module Name: sim_reg_file
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


module sim_reg_file;
  reg clk, rstd, wren;
  reg[4:0] ra1, ra2, wa;
  wire[31:0] rr1, rr2;
  reg[31:0] wr;

  initial begin
    clk = 0; forever #50 clk = ~clk;
  end

  initial begin
  rstd = 1;
  #30 rstd = 0;
  #40 rstd = 1;
  #10 wren = 0; ra1 = 1; ra2 = 2; wa = 3; wr = 32'haaaaaaaa;
  #100 ra1 = 3; ra2 = 3; wa = 4; wr = 32'h55555555;
  #100 ra1 = 4; ra2 = 5; wa = 5; wr = 32'h12345678;
  #100 ra1 = 5; ra2 = 4; wa = 6; wr = 32'h87654321;
  #100 ra1 = 6; ra2 = 0; wa = 1; wr = 32'h11111111;
  #100 ra1 = 1; ra2 = 6; wa = 2; wr = 32'h22222222;
  #100 ra1 = 1; ra2 = 2; wa = 7; wr = 32'h77777777;
  #100 wren = 1; ra1 = 1; ra2 = 2; wa = 8; wr = 32'haaaaaaaa;
  #100 ra1 = 3; ra2 = 4; wa = 9; wr = 32'h11111111;
  #100 ra1 = 5; ra2 = 6; wa = 10; wr = 32'hbbbbbbbb;
  #100 ra1 = 7; ra2 = 8; wa = 11; wr = 32'hcccccccc;
  #100 ra1 = 9; ra2 = 10; wa = 11; wr = 32'hdddddddd;
  end

  reg_file rf_body(clk, rstd, wr, ra1, ra2, wa, wren, rr1, rr2);

endmodule
