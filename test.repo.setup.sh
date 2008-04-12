#!/bin/bash
set -x
wd=/home/gallard/gw
# Submodules to create.
submods="suba subb"
# Only do one super.
supers="super"
# Clones of super to create.
# testrepos="testa testb"
testrepos="testa testb"
#
for repo in $testrepos
do
	rm -rf $wd/$repo
	mkdir $wd/$repo
	cd $wd/$repo
	git clone /public/super.git super
	cd super
	for submod in $submods
	do
		git submodule add file:///public/$submod.git
		git submodule init $submod
		git add $submod
		git commit -m "In repo: $repo, add submodule: $submod"
	done
done
