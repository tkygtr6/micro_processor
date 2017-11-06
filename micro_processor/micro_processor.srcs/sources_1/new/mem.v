`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/26/2017 04:11:21 PM
// Design Name:
// Module Name: mem
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

module data_mem(address, clk, write_data, wren, read_data);
  input[7:0] address;
  input clk, wren;
  input [7:0] write_data;
  output [7:0] read_data;
  reg [7:0] d_mem[0:255];

  always @ (posedge clk)
    if(wren == 0) d_mem[address]<=write_data;
  assign read_data=d_mem[address];

// initial $monitor($time, "d_mem[64]=%d", d_mem[64]);
// initial $monitor($time, "d_mem[65]=%d", d_mem[65]);
// initial $monitor($time, "d_mem[66]=%d", d_mem[66]);
// initial $monitor($time, "d_mem[67]=%d", d_mem[67]);
// initial $monitor($time, "d_mem[68]=%d", d_mem[68]);
// initial $monitor($time, "d_mem[72]=%d", d_mem[72]);
// initial $monitor($time, "d_mem[76]=%d", d_mem[76]);
// initial $monitor($time, "d_mem[77]=%d", d_mem[77]);
// initial $monitor($time, "d_mem[78]=%d", d_mem[78]);
// initial $monitor($time, "d_mem[79]=%d", d_mem[79]);
// initial $monitor($time, "d_mem[80]=%d", d_mem[80]);
// initial $monitor($time, "d_mem[84]=%d", d_mem[84]);
// initial $monitor($time, "d_mem[88]=%d", d_mem[88]);
// initial $monitor($time, "d_mem[92]=%d", d_mem[92]);
// initial $monitor($time, "d_mem[96]=%d", d_mem[96]);

// initial $monitor($time, "d_mem[126]=%d", d_mem[126]);
// initial $monitor($time, "d_mem[127]=%d", d_mem[127]);
// initial $monitor($time, "d_mem[128]=%d", d_mem[128]);
// initial $monitor($time, "d_mem[129]=%d", d_mem[129]);
// initial $monitor($time, "d_mem[130]=%d", d_mem[130]);
// initial $monitor($time, "d_mem[131]=%d", d_mem[131]);
// initial $monitor($time, "d_mem[132]=%d", d_mem[132]);
// initial $monitor($time, "d_mem[133]=%d", d_mem[133]);
// initial $monitor($time, "d_mem[520]=%d", d_mem[520]);
endmodule
