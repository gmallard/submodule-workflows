#!/bin/bash
set -x
wd=/home/gallard/gw
rm -rf $wd
mkdir $wd
# Only do one super.
supers="super"
#
for super in $supers
do
	cd $wd
	rm -rf $super
	mkdir $super
	cd $super
	# git init --shared=group
	git init
	echo "#" >.gitignore
	git add .gitignore
	git commit -m "First ignore"
	#
	cd ..
	rm -rf $super.bare
	git clone --bare $super $super.git
	rm -rf /public/$super.git
	mv $super.git /public
	rm -rf $super
	#
done
