#!/bin/bash
set -x
#
# Housekeeping: set up working directory for this test.
#
here=$(dirname $0)
. $here/../common/setvars
#
wd=$home/$user/gw
umask 002
#
# Testrepo:
# - Clone the supermodu;e
# - For each submodule
# --add the submodule
# --init the submodule
# --commit the result
# --push the result to the public supermodule
#
for repo in $testrepos
do
	mkdir -p $wd/$repo
	cd $wd/$repo
	git clone $public/super.git super
	cd super
	for submod in $submods
	do
		git submodule add file://$public/$submod.git
		git submodule init $submod
		git add $submod
		git commit -m "In repo: $repo, add submodule: $submod"
		git pull && git push
	done
done
