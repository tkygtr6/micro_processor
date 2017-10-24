module top_module(
    sysclk,
    sw,
    led,
    cpu_resetn
    );

    input sysclk, cpu_resetn;
    input [7:0] sw;
    output [7:0] led;

    vendingmachine vendingmachine0(
        .clk(sysclk),
        .sw(sw),
        .led(led),
        .rst(~cpu_resetn)
    );

endmodule
