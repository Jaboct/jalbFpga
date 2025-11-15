#! /bin/bash
# -x

# v_01
verilator -Wall --binary --trace \
  -Wno-PINMISSING -Wno-fatal \
  --top-module soc_tb \
  picorv32.v simple_ram.v uart_mmio.v soc.v soc_tb.v > consoleLog.txt 2>&1


# C compiling
#riscv64-unknown-elf-gcc -Os -march=rv32i -mabi=ilp32 -ffreestanding -fno-builtin -nostdlib -nostartfiles -Wall -Wextra crt0.S main.c -o program.elf -Wl,-Tlink.ld -Wl,--gc-sections

# connvert to hex
#riscv64-unknown-elf-objcopy -O binary program.elf program.bin
#hexdump -ve '1/4 "%08x\n"' program.bin > program.hex


