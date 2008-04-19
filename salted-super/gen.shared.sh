#!/bin/bash
set -x
#
# Housekeeping: set up working directory for this test.
#
here=$(dirname $0)
. $here/../common/setvars
#
wd=$home/$user/gw
rm -rf $wd
mkdir $wd
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
chown -R $user.$group $public/*
find $public -type d -exec chmod 2775 {} \;
find $public -type f -exec chmod 664 {} \;
#
set +x
