`timescale 1ns/1ps


module picorv32_tb;

	// Produces a waveform file that shows all the values.
	initial begin
	`ifdef TEST_NOP
		$dumpfile("wave_nop.vcd");   // the output file
	`else
		$dumpfile("wave_default.vcd");   // the output file
	`endif
		$dumpvars(0, testbench); // dump everything in the testbench hierarchy
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
	`ifdef TEST_NOP
		reg		mem_ready = 1'b0;
	`else
		wire		mem_ready = 1'b0;
	`endif

	wire [31:0]	mem_addr;
	wire [31:0]	mem_wdata;
	wire [3:0]	mem_wstrb;
//	wire [31:0]	mem_rdata;
	reg [31:0]	mem_rdata;



	`ifdef TEST_NOP
	// Combinational fake memory: always ready, always return NOP on reads.
	always @* begin
		mem_ready = 1'b1;           // Always ready to answer
		if (mem_valid && mem_wstrb == 4'b0000) begin
			// Read access (instruction or data)
			mem_rdata = 32'h00000013;   // RISC-V NOP
		end else begin
			// Writes or idle; read data doesn’t matter
			mem_rdata = 32'h00000013;
		end
	end
	`endif

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
TODO

write down what parts of the memory bus are necessary to get picorv up and running.


instantialising picorv, what is up with ENABLE_MUL and stuff like that.
so my implemntation disables muliplication, division, IRQ? counters???
*/


















