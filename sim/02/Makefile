

VFLAGS = -Wall --trace -I../../rtl/common
VERILATOR = verilator
OUT := out

.DEFAULT_GOAL := all

all: build

build:
	mkdir -p $(OUT)
	$(VERILATOR) $(VFLAGS) --binary \
		-Wno-PINMISSING -Wno-fatal -Wno-DECLFILENAME \
		--top-module tb_picorv32_system \
		--build \
		-Mdir out/obj_dir \
		-o ../sim \
		-f files.f

# rename to Vtb_picorv32_system?


run: build
	./out/sim

view:
	gtkwave out/wave.vcd





