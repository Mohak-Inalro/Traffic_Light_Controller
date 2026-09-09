`timescale 1ns/1ps

module testbench;

    reg clk;
    reg reset;
    wire out;

    traffic_light_controller dut (
        .clk(clk),
        .reset(reset),
        .out(out)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        #10;
        reset = 0;

        #350;

        $finish;
    end

    always @(posedge clk) begin
        $display("Time=%0t | Counter=%0d | Timer_done=%b | State=%b | Out=%b",
                 $time,
                 dut.tx.counter,
                 dut.tx.timer_done,
                 dut.fx.state,
                 out);
    end

endmodule
