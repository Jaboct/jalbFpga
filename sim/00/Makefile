

VFLAGS = -Wall --trace
VERILATOR = verilator
OUT := out

.DEFAULT_GOAL := all

all: build
#all: build-tb-00

# build-real

#build-default build-nop

#todo
#ignore = -Wno-PINMISSING -Wno-fatal -Wno-DECLFILENAME

build:
	mkdir -p $(OUT)
	$(VERILATOR) $(VFLAGS) --binary \
		-Wno-PINMISSING -Wno-fatal -Wno-DECLFILENAME \
		--top-module picorv32_tb \
		--build \
		-Mdir out/obj_dir \
		-o ../sim \
		-f files.f

run: build
	./out/sim

view:
	gtkwave out/wave.vcd


