`timescale 1ns/1ps

module tb_picorv32_system;

	reg		clk;
	reg		resetn;
	reg [31:0]	gpio_in;
	wire [31:0]	gpio_out;	// why is this a wire vs reg?

	picorv32_system soc (
		.clk		(clk),
		.resetn		(resetn),
		.gpio_in	(gpio_in),
		.gpio_out	(gpio_out)
	);

	// 48 MHz is the max clock rate of my FPGAs internal oscillator.
	// 1/48e+06 = 20.833e-09
	initial begin
		clk = 1'b0;
		forever #20.833 clk = ~clk;
	end

	initial begin
		gpio_in = 32'b0;
		resetn = 1'b0;

		$dumpfile("out/wave.vcd");
		$dumpvars(0, tb_picorv32_system);

		// hold reset low to sim the board startup
		#100;
		resetn = 1'b1;

		// set runtime, long enough to sim the program
		#5000;

		$display("gpio_out = 0x%08x", gpio_out);
		$finish;
	end
endmodule




