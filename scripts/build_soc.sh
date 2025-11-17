#! /bin/bash
# -x

# Change directory the directory of the script (so you can run it from other directories and > consoleLog.txt is always in the same folder as this script)
# (not exactly) Change directory to the project root (parent of scripts/)
cd "$(dirname "$0")"

echo $PWD

# There are 2 build types,
# 1) synthesis / P&R (yosys + nextpnr + icepack) generated bitstream for FPGA
# 2) Simulation (verilator) create C++ executable to simulate your design.

# Original file in ~/workspace/Verilator/jalbPico/build.sh


# v_01
#verilator -Wall --binary --trace \
#  -Wno-PINMISSING -Wno-fatal \
#  --top-module soc_tb \
#  picorv32.v simple_ram.v uart_mmio.v soc.v soc_tb.v > consoleLog.txt 2>&1


# C compiling
#riscv64-unknown-elf-gcc -Os -march=rv32i -mabi=ilp32 -ffreestanding -fno-builtin -nostdlib -nostartfiles -Wall -Wextra crt0.S main.c -o program.elf -Wl,-Tlink.ld -Wl,--gc-sections

# connvert to hex
#riscv64-unknown-elf-objcopy -O binary program.elf program.bin
#hexdump -ve '1/4 "%08x\n"' program.bin > program.hex



#verilator -Wall --binary --trace \
#  -Wno-PINMISSING -Wno-fatal -Wno-DECLFILENAME \
#  --top-module soc_tb \
#  -f ../sim/soc_files.f


# forces it to rebuild every time, i should probly make a 2nd script with this
# with c i have "make clean" as a seperate button.
#rm -rf obj_dir

verilator -Wall --binary --trace \
  -Wno-PINMISSING -Wno-fatal -Wno-DECLFILENAME \
  --top-module picorv32_tb \
  -f ../sim/soc_files.f


#  > consoleLog.txt 2>&1
# Removed so the output can get sent to consoleTemp.txt for my IDE.

