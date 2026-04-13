
module simple_ram #(
	parameter WORDS = 1024	// a word is 4 bytes or 32 bits.
) (
	input  wire        clk,

	// PicoRV32 memory bus
	input  wire        mem_valid,
	input  wire [31:0] mem_addr,
	input  wire [31:0] mem_wdata,
	input  wire [3:0]  mem_wstrb,

//	output wire [31:0] mem_rdata,
//	output wire        mem_ready

	output reg [31:0] rdata,
	output reg        ready
);

	// actual RAM allocation
	// 32-bit words.
	reg [31:0] mem [0:WORDS-1];


	initial begin
		$readmemh("firmware_words.hex", mem);
	end

/*
	// For simulations: preload program (one 32-bit hex per line)
	initial begin
		if ($test$plusargs("PRELOAD")) begin
			$display("Loading program.hex into RAM...");
			$readmemh("program.hex", mem);
		end
	end
*/

	// Address bits [31:2] = word index (word-aligned)
	// grabs 0xXXXX_XXXX_XXXX_XX00
	// as in the last 2 bits are zero'd, so it rounds down to the nearest 4.
	wire [9:0] addr = mem_addr[11:2];
//	reg [31:0] rdata = mem[mem_addr[31:2]];
//	reg [31:0] rdata = mem[addr];


	// the index of mem I used depends on WORDS.
	// for 1024 = 2^10, i shouldnt use all 32 bits, just 10.
	// but mem_arr is necessarily 32 bits, so idk if i need to truncate, or if it doesnt matter


	// Do i need to zero the ram?


	always @(posedge clk) begin
		if ( mem_valid && |mem_wstrb ) begin	// this mem_wstrb check is a little redundant

			// So i want to move the data from mem_wdata to 2 places
			// into mem (rdata) and into mem_rdata? why both, im not sure.
/*
			if ( mem_wstrb[0] ) rdata[ 7: 0] <= mem_wdata[ 7: 0];
			if ( mem_wstrb[1] ) rdata[15: 8] <= mem_wdata[15: 8];
			if ( mem_wstrb[2] ) rdata[23:16] <= mem_wdata[23:16];
			if ( mem_wstrb[3] ) rdata[31:24] <= mem_wdata[31:24];
*/
			if ( mem_wstrb[0] ) mem[addr][ 7: 0] <= mem_wdata[ 7: 0];
			if ( mem_wstrb[1] ) mem[addr][15: 8] <= mem_wdata[15: 8];
			if ( mem_wstrb[2] ) mem[addr][23:16] <= mem_wdata[23:16];
			if ( mem_wstrb[3] ) mem[addr][31:24] <= mem_wdata[31:24];
		end
	end

endmodule


