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
# Only do one super.
#
supers="super"
#
# Supermodule:
# - Initialize it
# - Run first commit
# - Clone a bare copy
# - Move the bare copy to the public area
#
for super in $supers
do
	cd $wd
	rm -rf $super
	mkdir $super
	cd $super
	git init
	echo "#" >.gitignore
	git add .gitignore
	git commit -m "First ignore"
	cd ..
	rm -rf $super.bare
	git clone --bare $super $super.git
	rm -rf $public/$super.git
	mv $super.git $public
	rm -rf $super
	#
done
