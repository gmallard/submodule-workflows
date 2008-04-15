#!/bin/bash
set -x
#
# Housekeeping: set up working directory for this test.
#
wd=/home/gallard/gw
rm -rf $wd
mkdir $wd
#
# Location of public read/write area
#
public=/public
#
# List of submodules to create.
#
submods="suba subb"
#
# Only do one super.
#
supers="super"
#
# List of clones of super to create.
#
testrepos="testa testb"
#
# Submodules:
# - Create empty repo
# - Run first commit in it
# - Clone it to a bare repo
# - Move it to the public area
#
for m in $submods
do
	cd $wd
	rm -rf $m
	mkdir $m
	cd $m
	git init
	echo "#" >.gitignore
	git add .gitignore
	git commit -m "First ignore"
	cd ..
	rm -rf $m.bare
	git clone --bare $m $m.git
	rm -rf $public/$m.git
	mv $m.git $public
	rm -rf $m
	#
done
#
# Supermodule(s):
# - Should only be one of these!
# - Create it
# - Run the first commit
# - Add each submodule
# - Commit the adds
# - Clone the super to a bare copy
# - Move the bare clone to the public area
#
for m in $supers
do
	cd $wd
	rm -rf $m
	mkdir $m
	cd $m
	git init
	echo "#" >.gitignore
	git add .gitignore
	git commit -m "First ignore"
	#
	for sm in $submods
	do
		git submodule add file://$public/$sm.git
	done
	git add .
	git commit -m "Add submodules."
	#
	cd ..
	rm -rf $m.bare
	git clone --bare $m $m.git
	rm -rf $public/$m.git
	mv $m.git $public
	rm -rf $m
	#
done
#
# Test repositories:
# - Clone the public supermodule
# - Initialize each submodule
# - Checkout the master branch in each submodule
#
for d in $testrepos
do
	mkdir -p $wd/$d
	cd $wd/$d
	git clone file://$public/super.git super
	cd $wd/$d/super
	git submodule init
	git submodule update
	for sm in $submods
	do
		cd $sm
		git checkout master
		# A 'pull' is not required because we are initializing for this
		# demonstration.
#		git pull
		cd ..
	done
done
#
set +x
