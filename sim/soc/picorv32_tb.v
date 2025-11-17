`timescale 1ns/1ps


module picorv32_tb;

	// Initialize DUT (Device Under Test)
	reg clk = 0;
	reg resetn = 0;

	// this is passed to PicoRV, what does it use it for?
	wire trap;


	// for picorv32 the memory bus MUST be set up.
	// these are "simple stubs" for now.

	wire		mem_valid;
	wire		mem_instr;
	wire		mem_ready = 1'b0;

	wire [31:0]	mem_addr;
	wire [31:0]	mem_wdata;
	wire [3:0]	mem_wstrb;
	wire [31:0]	mem_rdata;

	// CPU instance
	picorv32 #(
		.ENABLE_MUL(0),
		.ENABLE_DIV(0),
		.ENABLE_IRQ(0),
		.ENABLE_COUNTERS(0)
	) dut (
		.clk		(clk),
		.resetn		(resetn),
		.trap		(trap),
		.mem_valid	(mem_valid),
		.mem_instr	(mem_instr),
		.mem_ready	(mem_ready),
		.mem_addr	(mem_addr),
		.mem_wdata	(mem_wdata),
		.mem_wstrb	(mem_wstrb),
		.mem_rdata	(mem_rdata),
	);

	// Clocks
	// every 5 ns invert the clock reg.
	always #5 clk = ~clk;

	initial begin
		$display("Starting picorv32 solo test");
		#20 resetn = 1;
		#200 $finish;
	end

endmodule


/*
TODO

learn what trap is, write down what parts of the memory bus are necessary to get picorv up and running.
link to the official documentation for both of these.

instantialising picorv, what is up with ENABLE_MUL and stuff like that.
so my implemntation disables muliplication, division, IRQ? counters???
*/


















