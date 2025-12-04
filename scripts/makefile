

VFLAGS = -Wall --trace
VERILATOR = verilator


.DEFAULT_GOAL := all



all: build-default build-nop


build-default:
	$(VERILATOR) $(VFLAGS) --binary \
		-Wno-PINMISSING -Wno-fatal -Wno-DECLFILENAME \
		--top-module picorv32_tb \
		--build -o sim_default \
		-f ../sim/soc_files.f

build-nop:
	$(VERILATOR) $(VFLAGS) --binary \
		-Wno-PINMISSING -Wno-fatal -Wno-DECLFILENAME \
		--top-module picorv32_tb \
		-DTEST_NOP \
		--build -o sim_nop \
		-f ../sim/soc_files.f


#clean:
#	rm -rf obj_dir






