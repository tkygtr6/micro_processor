`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/30/2017 04:05:13 PM
// Design Name:
// Module Name: execute
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


module execute(clk, ins, pc, reg1, reg2, wra, result, nextpc);
  input clk;
  input[31:0]ins, pc, reg1, reg2;
  output[4:0]wra;
  output[31:0]result, nextpc;
  wire[5:0]op;
  wire[4:0]shift, operation;
  wire[25:0]addr;
  wire[31:0]dpl_imm, operand2, alu_result, nonbranch, branch, mem_address, dm_r_data;
  wire[3:0]wren;

function[4:0]opr_gen;
  input[5:0]op;
  input[4:0]operation;
  case(op)
    6'd0: opr_gen = operation;
    6'd1: opr_gen = 5'd0;
    6'd4: opr_gen = 5'd8;
    6'd5: opr_gen = 5'd9;
    6'd6: opr_gen = 5'd10;
    default: opr_gen = 5'h1f;
  endcase
endfunction

function [31:0] alu;
  input [4:0] opr, shift;
  input[31:0] operand1, operand2;
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

  assign op = ins[31:26];
  assign shift = ins[10:6];
  assign operation = ins[4:0];
  assign dpl_imm = {{16{ins[15]}}, ins[15:0]};
  assign alu_result = alu(opr_gen(op, operation), shift, reg1, operand2);
  assign mem_address = (reg1 + dpl_imm) >>> 2;
  assign wren = wrengen(op);
  data_mem data_mem_body0(mem_address[7:0], clk, reg2[7:0], wren[0], dm_r_data[7:0]);
  data_mem data_mam_body1(mem_address[7:0], clk, reg2[15:8], wren[1], dm_r_data[15:8]);
  data_mem data_mem_body2(mem_address[7:0], clk, reg2[23:16], wren[2], dm_r_data[23:16]);
  data_mem data_mem_body3(mem_address[7:0], clk, reg2[31:24], wren[3], dm_r_data[31:24]);

  assign wra = wreg(op, ins[20:16], ins[15:11]);
  assign result = calc(op, alu_result, dpl_imm, dm_r_data, pc);

  assign addr = ins[25:0];
  assign nonbranch = pc + 32'd1;
  assign branch = nonbranch + dpl_imm;
  assign nextpc = npc(op, reg1, reg2, branch, nonbranch, addr);

endmodule
