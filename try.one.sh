#!/bin/bash
wd=/home/gallard/gw
cd $wd
#
# Standard (?????) work sequence 
#
cd sb.clone.one
cd ab
#
# Hack, hack, hack in submodule
#
echo fb >fb.txt && git add . && git commit -m "work in one/ab 01"
echo fbb >>fb.txt && git add . && git commit -m "work in one/ab 02"
echo fbbb >>fb.txt && git add . && git commit -m "work in one/ab 03"
#
# Obtain upstream changes
#
git pull
#
# Push submodule
#
git push
cd ..
#
# Commit supermodule
#
git add .
git commit -m "update submodule"
#
# Obtain upstream changes
#
git pull
#
# Push supermodule
#
git push
