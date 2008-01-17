#!/bin/bash
wd=/home/gallard/gw
cd $wd
#
# Standard (?????) update sequence 
#
cd sb.clone.one
#
# Pull in super
#
git pull
#
# Update submodule in super
#
git submodule update
cd ab
#
# Checkout branch in submodule
#
git checkout master
#
# Pull in submodule
#
git pull
