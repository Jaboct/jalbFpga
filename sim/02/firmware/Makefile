# Makefile
RISCV   ?= riscv64-unknown-elf
CFLAGS  := -Os -march=rv32i -mabi=ilp32 -ffreestanding -fno-builtin -nostdlib -nostartfiles -Wall -Wextra
LDFLAGS := -Wl,-Tlink.ld -Wl,--gc-sections

all: program.hex

program.elf: crt0.S main.c link.ld
	$(RISCV)-gcc $(CFLAGS) crt0.S main.c -o $@ $(LDFLAGS)

# Option A: direct "verilog" format (lines of hex; widely used for $readmemh)
program.hex: program.elf
	$(RISCV)-objcopy -O verilog $< $@


# Option B: flat 32-bit words (if your RAM expects *only* words, no @addr lines)
# program.hex: program.elf
#	$(RISCV)-objcopy -O binary $< program.bin
#	hexdump -ve '1/4 "%08x\n"' program.bin > $@

clean:
	rm -f program.elf program.hex program.bin




