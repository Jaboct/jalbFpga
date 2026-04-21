`timescale 1ns/1ps


module picorv32_tb;

	// Produces a waveform file that shows all the values.
	initial begin
		$dumpfile("out/wave.vcd");   // the output file
		$dumpvars(0, picorv32_tb); // dump everything in the picorv32_tb hierarchy
	end

/*
	initial begin
		for (i = 0; i < 256; i = i + 1)
			mem[i] = 32'h00000013;
	end
*/

	// Initialize DUT (Device Under Test)
	reg clk = 0;
	reg resetn = 0;

	// goes high when the CPU executes an EBREAK instruction, meaning the program has intentionally stopped / reached its end.
	// does exit() cause trap to go high?
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

	always @(posedge clk) begin
		if (trap) begin
			$display("CPU TRAP DETECTED — TEST PASSED");
			$finish;
		end
	end

endmodule


/*
instantialising picorv:
what is up with ENABLE_MUL and stuff like that.
so my implemntation disables muliplication, division, IRQ? counters???
*/


















