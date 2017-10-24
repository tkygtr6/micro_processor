`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2016/09/13 18:05:11
// Design Name:
// Module Name: vendingmachine
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

`define S0 2'b00 // first state
`define S1 2'b01 // recieved 50 yen
`define S2 2'b10 // recieved 100 yen

module vendingmachine(
    clk,
    sw,
    led,
    rst
    );

    input clk, rst;
    input [7:0] sw; // sw[0] = 50 yen, sw[1] = 100 yen
    output [7:0] led;

    reg [1:0] oldSw; // MSB is allocated to sw[1], LSB is allocated to sw[0]
    reg [1:0] currentState;
    reg[1:0] ledreg;

    assign led[1:0] = ledreg;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
          currentState <=`S0;
          oldSw <= 2'b00;
          ledreg <= 2'b00;
        end else begin
            case(currentState)
              `S0 : begin // 0 yen
                if(sw[0] == 1'b1 && oldSw[0] != sw[0]) begin
                  currentState <= `S1;
                  ledreg <= 2'b00;
                end
                else if(sw[1] == 1'b1 && oldSw[1] != sw[1]) begin
                  currentState <= `S2;
                  ledreg <= 2'b00;
                end
              end
              `S1 : begin // 50 yen
                if(sw[0] == 1'b1 && oldSw[0] != sw[0])
                begin
                  currentState <= `S2;
                  ledreg <= 2'b00;
                end
                else if(sw[1] == 1'b1 && oldSw[1] != sw[1]) begin
                  currentState <= `S0;
                  ledreg <= 2'b01;
                end
              end
              `S2 : begin // 100 yen
                if(sw[0] == 1'b1 && oldSw[0] != sw[0])
                begin
                  currentState <= `S0;
                  ledreg <= 2'b01;
                end
                else if(sw[1] == 1'b1 && oldSw[1] != sw[1]) begin
                  currentState <= `S0;
                  ledreg <= 2'b11;
                end
              end
              default : begin
                currentState <= currentState;
              end
            endcase
            oldSw <= sw[1:0];
        end
    end
endmodule
