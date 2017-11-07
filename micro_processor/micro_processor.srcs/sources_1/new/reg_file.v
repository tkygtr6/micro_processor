`timescale 1ns / 1ps

module reg_file(clk, rstd, wr, ra1, ra2, wa, wren, rr1, rr2);
  input clk, rstd, wren;
  input [31:0] wr;
  input [4:0] ra1, ra2, wa;
  output[31:0] rr1, rr2;
  reg [31:0]rf[0:31];

  assign rr1 = rf[ra1];
  assign rr2 = rf[ra2];
  always @(negedge rstd or posedge clk)
    if(rstd == 0) rf[0] <= 32'h00000000;
    else if(wren == 0) rf[wa] <= wr;

  // initial $monitor($time, " (reg_file) clk=%d, wr=%h, ra1=%h, ra2=%h, wa=%d, wren=%d, rr1=%h, rr2=%h", clk, wr, ra1, ra2, wa, wren, rr1, rr2);
  // initial $monitor($time, " rf[0]=%d", rf[0]);
  // initial $monitor($time, " rf[1]=%d", rf[1]);
  // initial $monitor($time, " rf[2]=%d", rf[2]);
  // initial $monitor($time, " rf[3]=%d", rf[3]);
  // initial $monitor($time, " rf[4]=%d", rf[4]);
  // initial $monitor($time, " rf[5]=%d", rf[5]);
  // initial $monitor($time, " rf[6]=%d", rf[6]);
  // initial $monitor($time, " rf[7]=%d", rf[7]);
  initial $monitor($time, " rf[8]=%d", rf[8]);
  // initial $monitor($time, " rf[9]=%d", rf[9]);
  initial $monitor($time, " rf[10]=%d", rf[10]);
  // initial $monitor($time, " rf[11]=%d", rf[11]);
  // initial $monitor($time, " rf[12]=%d", rf[12]);
  // initial $monitor($time, " rf[13]=%d", rf[13]);
  // initial $monitor($time, " rf[14]=%d", rf[14]);
  // initial $monitor($time, " rf[15]=%d", rf[15]);
  // initial $monitor($time, " rf[16]=%d", rf[16]);
  // initial $monitor($time, " rf[17]=%d", rf[17]);
  // initial $monitor($time, " rf[18]=%d", rf[18]);
  // initial $monitor($time, " rf[19]=%d", rf[19]);
  // initial $monitor($time, " rf[20]=%d", rf[20]);
  // initial $monitor($time, " rf[21]=%d", rf[21]);
  // initial $monitor($time, " rf[22]=%d", rf[22]);
  // initial $monitor($time, " rf[23]=%d", rf[23]);
  // initial $monitor($time, " rf[24]=%d", rf[24]);
  // initial $monitor($time, " rf[25]=%d", rf[25]);
  // initial $monitor($time, " rf[26]=%d", rf[26]);
endmodule
