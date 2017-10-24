`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2016/09/13 17:14:20
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
    reg clk; // input ‚ª reg
    reg [7:0] sw;
    wire [7:0] led; // output ‚Í wire

    wire [3:0] inL, inR;
    wire [4:0] result;
    
    top_module T0( // simulation ‚µ‚½‚¢‚â‚Â‚ð instance ‰»
    .sysclk(clk),
    .sw(sw),
    .led(led)
    );

    assign inL = sw[7:4];
    assign inR = sw[3:0];
    assign result = led[4:0];

    initial begin
        clk <= 1'b0;
        sw <= 8'b0;
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
        sw <= 8'b10101010;
        
        wait_posedge_clk(10);
        sw <= 8'b00001111;
        wait_posedge_clk(10);
        sw <= 8'b00110110;
        wait_posedge_clk(10);
        sw <= 8'b01010101;

        $finish;
    end
    
endmodule
