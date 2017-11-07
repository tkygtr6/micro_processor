`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/31/2017 02:26:37 PM
// Design Name:
// Module Name: computer
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


module computer(clk, rstd);
  input clk, rstd;
  wire[31:0] pc, ins, reg1, reg2, result, nextpc;
  wire[4:0] wra;
  wire[3:0] wren;
  wire halt;

    fetch fetch_body(pc, ins);
    execute execute_body(clk, ins, pc, reg1, reg2, wra, result, nextpc, halt);
    writeback writeback_body(clk, rstd, nextpc, pc);
    reg_file rf_body(clk, rstd, result, ins[25:21], ins[20:16], wra, (~| wra), reg1, reg2);
    counter counter_body(clk, rstd, halt);

    initial $monitor($time, "halt = %b", halt);

    // initial $monitor($time, "rstd=%d, clk=%d, pc=%h, ins=%b, wra=%h, reg1=%h, reg2=%h", rstd, clk, pc, ins, wra, reg1, reg2);

endmodule

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
