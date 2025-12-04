#! /bin/bash

# make
# then run each executable.
# and maybe do some automated waveform tests, if that is possible.


./obj_dir/sim_default
./obj_dir/sim_nop


# now make sure the outputs files are created
# they are created in the file i run the script from
# ./wave_default.vcd
# ./wave_nop.vcd

# Right now i wont store them in git, i might want to later.





