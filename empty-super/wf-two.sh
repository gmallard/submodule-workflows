#!/bin/bash
set -x
repo=$1
wd=/home/gallard/gw
cd $wd/$repo/super
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