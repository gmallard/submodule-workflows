#!/bin/bash
set -x
#
# Pick up private clone name from command line.
#
p=$1
cd ~/subtut/$p/super
#
# Do work in a submodule.
#
cd a
echo aline $p >>a.txt
git add .
git commit -m "Add a line"
#
# Seems good practice to pull before you push.
#
git pull && git push
#
# Update supermodule
#
cd ..
git add .
git commit -m "update submodule"
git pull && git push
