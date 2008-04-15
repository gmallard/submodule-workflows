#!/bin/bash
set -x
#
# Pick up private clone name from command line.
#
p=$1
cd ~/subtut/$p/super
#
# Pull updates from supermodule
#
git pull
git submodule update
#
# And updates from submodule
#
cd a
git checkout master
git pull
