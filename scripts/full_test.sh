#! /bin/bash

rm obj_dir/sim_default
rm obj_dir/sim_nop

rm wave_default.vcd
rm wave_nop.vcd

make

# make sure both exes are made

./obj_dir/sim_default
./obj_dir/sim_nop


diff wave_default.vcd proof/wave_default.vcd >out.txt
# make sure out is 0 bytes

FILESIZE=$(stat -c%s "out.txt")
if [ $FILESIZE -le 0 ]; then
  echo "sim_default is good"
else
  echo "sim_default is bad"
fi


diff wave_nop.vcd proof/wave_nop.vcd >out.txt

FILESIZE=$(stat -c%s "out.txt")
if [ $FILESIZE -le 0 ]; then
  echo "sim_nop is good"
else
  echo "sim_nop is bad"
fi















