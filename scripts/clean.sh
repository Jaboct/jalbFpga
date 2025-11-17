#! /bin/bash
# -x

# Change directory the directory of the script (so you can run it from other directories and > consoleLog.txt is always in the same folder as this script)
# (not exactly) Change directory to the project root (parent of scripts/)
cd "$(dirname "$0")"

echo $PWD

echo "deleting /obj_dir/"

rm -rf obj_dir



