`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/26/2017 01:40:04 PM
// Design Name:
// Module Name: cpu
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


module fetch(pc, ins);
  input [31:0] pc;
  output [31:0] ins;
  reg [31:0] ins_mem [0:255];
  wire [31:0] pc_bit2, pc_bit3;
  initial $readmemb("/home/denjo/micro_processor/micro_processor/micro_processor.srcs/sources_1/new/assembly/sample3.bin",ins_mem);
  assign ins = ins_mem[pc>>2];
  assign pc_bit2 = pc >> 2;
  assign pc_bit3 = pc >>> 2;

  // initial $monitor($time, " pc=%h ins=%b ins_mem=%b", pc, ins, ins_mem[0]);
endmodule
