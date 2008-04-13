#!/bin/bash
set -x
wd=/home/gallard/gw
rm -rf $wd
mkdir $wd
# Submodules to create.
submods="suba subb"
#
for submod in $submods
do
	cd $wd
	rm -rf $submod
	mkdir $submod
	cd $submod
	# git init --shared=group
	git init
	echo "#" >.gitignore
	git add .gitignore
	git commit -m "First ignore"
	cd ..
	rm -rf $submod.bare
	git clone --bare $submod $submod.git
	rm -rf /public/$submod.git
	mv $submod.git /public
	rm -rf $submod
	#
done
