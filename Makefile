

VFLAGS = -Wall --trace
VERILATOR = verilator


.DEFAULT_GOAL := all

all: build-00
#all: build-tb-00

# build-real

#build-default build-nop

### TODO, run the makefiles in each child directory.
# have runetime commands where i can list specific ones i want to make, like "01" or "01 02 05", or like "all".

# this should pass down the VFLAGS and other vars above.
#proof00:
#	$(MAKE) -C sim/00

build-00:
	$(VERILATOR) $(VFLAGS) --binary \
		-Wno-PINMISSING -Wno-fatal -Wno-DECLFILENAME \
		--top-module picorv32_tb \
		--build -o sim_default \
		-f sim/00/files.f


build-default:
	$(VERILATOR) $(VFLAGS) --binary \
		-Wno-PINMISSING -Wno-fatal -Wno-DECLFILENAME \
		--top-module picorv32_tb \
		--build -o sim_default \
		-f ../sim/soc_files_00.f

build-nop:
	$(VERILATOR) $(VFLAGS) --binary \
		-Wno-PINMISSING -Wno-fatal -Wno-DECLFILENAME \
		--top-module picorv32_tb \
		-DTEST_NOP \
		--build -o sim_nop \
		-f ../sim/soc_files_00.f


build-tb-00:
	$(VERILATOR) $(VFLAGS) --binary \
		-Wno-PINMISSING -Wno-fatal -Wno-DECLFILENAME \
		--top-module tb_picorv32_system \
		--build -o sim_real \
		-f ../sim/soc_files.f

# rename to Vtb_picorv32_system



build-system:
	$(VERILATOR) $(VFLAGS) --binary \
		-Wno-PINMISSING -Wno-fatal -Wno-DECLFILENAME \
		--top-module picorv32_system \
		--build -o sim_syste, \
		-f ../sim/soc_files.f

#		-f ../sim/verilator_waivers.vlt


#clean:
#	rm -rf obj_dir






