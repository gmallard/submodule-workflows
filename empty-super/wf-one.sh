#!/bin/bash
set -x
#
# Pick up private clone name from command line.
#
repo=$1
wd=/home/gallard/gw
cd $wd/$repo/super/suba
#
# Do work in a submodule
#
echo aline  submod:  $repo >>a.txt
git add .
git commit -m "Add a line in $repo"
git pull && git push
#
# Update supermodule
#
cd ..
git add .
git commit -m "update submodule in $repo"
git pull && git push
