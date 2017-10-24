`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 10/24/2017 03:25:09 PM
// Design Name:
// Module Name: testbench
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


module testbench();
  reg clk;
  reg [7:0] sw;
  wire [7:0] led;
  reg reset;

  top_module T0(
    .sysclk(clk),
    .sw(sw),
    .led(led),
    .cpu_resetn(reset)
  );

  initial begin
    clk <= 1'b0;
    reset <= 1'b0;
    sw[1:0] <= 2'b00;
  end

  always #5 begin
    clk <= ~clk;
  end

  task wait_posedge_clk;
      input   n;
      integer n;

      begin
          for(n=n; n>0; n=n-1) begin
              @(posedge clk)
                  ;
          end
      end
  endtask

  initial begin
    wait_posedge_clk(4);
    reset <= 1'b1;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b01;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b00;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b01;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b00;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b01;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b00;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b01;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b00;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b10;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b00;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b10;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b00;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b10;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b00;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b01;

    wait_posedge_clk(5);
    sw[1:0] <= 2'b00;
    
    $finish;
  end
endmodule
