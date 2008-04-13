#!/bin/bash
set -x
wd=/home/gallard/gw
# Submodules to create.
submods="suba subb"
# Only do one super.
supers="super"
# Clones of super to create.
# Only one for this exmaple.
testrepos="testb"
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
