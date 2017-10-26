`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/26/2017 04:10:31 PM
// Design Name:
// Module Name: sim_mem
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


module test_mem;
  reg [7:0] address;
  reg clk, wren;
  reg [31:0] ra, wa; // unknown
  reg [31:0] write_data;
  wire [31:0] read_data;

  initial begin
    clk = 0; forever #50 clk = ~clk;
  end

  initial begin
    #40   address = 0;  write_data = 8'h21; wren = 0;
    #100  address = 1;  write_data = 8'h43; wren = 0;
    #100  address = 2;  write_data = 8'h65; wren = 1;
    #100  address = 2;  write_data = 8'h87; wren = 0;
    #100  address = 3;  write_data = 8'ha9; wren = 0;
    #100  address = 0;  wren = 1;
    #100  address = 1;  wren = 1;
    #100  address = 2;  wren = 1;
    #100  address = 3;  wren = 1;
  end

//  initial $monitor($stime, "address=%d, clk=%d, write_data=%h, wren=%d, read_data=%h",
//          , address, clk, write_data, wren, read_data);
  initial $monitor($time, "clk=%d", clk);
  data_mem data_mem_body(address, clk, write_data, wren, read_data);
endmodule
