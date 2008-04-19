#!/bin/bash
set -x
#
# Housekeeping.
#
here=$(dirname $0)
. $here/../common/setvars
#
git clone $public/super.git super
cd super
for submod in $submods
do
	git submodule init $submod
	git submodule update $submod
	cd $submod
	git checkout master
	cd ..
done
