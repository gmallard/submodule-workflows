#!/bin/bash
set -x
#
# Housekeeping:
# Initialize working directory for this demonstration
#
wd=/home/gallard/gw
#
# Define the public read/writable area
#
public=/public
#
# Submodules to create.
#
submods="suba subb"
#
# Only do one super.
#
supers="super"
#
# Clones of super to create.
# Only one for this exmaple.
#
testrepos="testb"
#
# Testrepo:
# -Clone the supermodule
# -For each submodule
# --initialize the submodule
# --update the submodule
#
for repo in $testrepos
do
	mkdir -p $wd/$repo
	cd $wd/$repo
	git clone /public/super.git super
	cd super
	for submod in $submods
	do
		git submodule init $submod
		git submodule update $submod
	done
done
