#!/bin/bash
set -x
#
umask 002
#
# Housekeeping: set up working directory for this test.
#
here=$(dirname $0)
. $here/../common/setvars
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

