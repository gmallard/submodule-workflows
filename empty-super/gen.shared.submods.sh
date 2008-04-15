#!/bin/bash
set -x
#
# Housekeeping:
# Initialize working directory for this demonstration
#
wd=/home/gallard/gw
rm -rf $wd
mkdir $wd
#
# Define the public read/writable area
#
public=/public
#
# List of submodules to create.
#
submods="suba subb"
#
# Submodules:
# - Initialize a submodule repository
# - Run the first commit
# - Make a bare clone
# - Move the clone to the public area
#
for submod in $submods
do
	cd $wd
	rm -rf $submod
	mkdir $submod
	cd $submod
	git init
	echo "#" >.gitignore
	git add .gitignore
	git commit -m "First ignore"
	cd ..
	rm -rf $submod.bare
	git clone --bare $submod $submod.git
	rm -rf $public/$submod.git
	mv $submod.git $public
	rm -rf $submod
done
set +x
