
module picorv32_system (
	input wire	clk,
	input wire	resetn,

	input  wire [15:0] gpio_in,
	output wire [15:0] gpio_out
);

	// PicoRV32 interface wires
	wire		mem_valid;
	wire		mem_instr;
	wire		mem_ready;

	wire [31:0]	mem_addr;
	wire [31:0]	mem_wdata;
	wire [31:0]	mem_rdata;

	wire [3:0]	mem_wstrb;


	// Instantiate the CPU Core
	picorv32 #(
		.ENABLE_COUNTERS(0),
		.ENABLE_COUNTERS64(0),
		.ENABLE_MUL(0),
		.ENABLE_DIV(0),
		.ENABLE_FAST_MUL(0),
		.ENABLE_IRQ(0),
		.ENABLE_IRQ_QREGS(0),
		.PROGADDR_RESET(32'h00000000)
	) cpu (
		.clk		(clk),
		.resetn		(resetn),
		.mem_valid	(mem_valid),
		.mem_instr	(mem_instr),
		.mem_ready	(mem_ready),
		.mem_addr	(mem_addr),
		.mem_wdata	(mem_wdata),
		.mem_wstrb	(mem_wstrb),
		.mem_rdata	(mem_rdata),
		.irq		(32'b0)
	);


	// Address decoding (BUS)
	// 0x0000_0000 : 0x0000_FFFF = RAM	// simple_ram.v WORDS = 1024. word is 4 bytes, so its 4 kBytes.
						// but this right here is 16^4 = 64 kB, so they are incongruent. TODO
	wire ram_sel		= mem_valid && (mem_addr < 32'h0001_0000);
	wire gpio_out_sel	= mem_valid && (mem_addr == 32'h1000_0000);
	wire gpio_in_sel	= mem_valid && (mem_addr == 32'h1000_0004);

	// in C when i write, it will toggle high the wire "gpio_out_sel".
	// *(volatile uint32_t *)0x10000000 = 0x00000001;

	// i need uart out to usb?


/* read from the CPU out to the modules port
	always @(posedge clk) begin
		if (!resetn)
			gpio_out <= 32'b0;
		else if (gpio_out_sel && |mem_wstrb)
			gpio_out <= mem_wdata;
	end
*/


	wire [31:0]	ram_rdata;
	wire		ram_ready;
	simple_ram ram (
		clk,

		mem_valid,
		mem_addr,
		mem_wdata,
		mem_wstrb,
		ram_rdata,
		ram_ready
	);



	assign mem_ready =
	        ram_ready ||
		gpio_out_sel ||
		gpio_in_sel;


	// for writing to the cpu
	// if ram is ready, write from ram data
	// if gpio in is selected write that,
	// idk why we would write gpio out to the cpu, its an output...
	assign mem_rdata =
		ram_ready	? ram_rdata :
		gpio_in_sel	? gpio_in   :
		gpio_out_sel	? gpio_out  :
		32'b0;





endmodule



