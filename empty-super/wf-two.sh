#!/bin/bash
set -x
#
umask 002
#
# Pull updates from supermodule
#
git pull
git submodule update
#
# And updates from submodule
#
cd suba
git checkout master
git pull
cd ..

