#!/bin/bash
set -x
#
umask 002
#
# Housekeeping.
#
user=gallard
group=git
#
# Location of public read/write area
#
public=/public/repos
#
# List of submodules to create.
#
submods="suba subb"
#
# Only do one super.
#
supers="super"
#
# Test repository:
# - Clone the public supermodule
# - Initialize each submodule
# - Checkout the master branch in each submodule
#
git clone file://$public/super.git
cd super
git submodule init
git submodule update
for sm in $submods
do
	cd $sm
	git checkout master
	# Not necessary for first workflow, do it anyway.
	git pull
	cd ..
done
cd ..

