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
# Submodules to create.
#
submods="suba subb"
#
# Only do one super.
#
supers="super"
#
# List of clones of super to create.
# Only one for this exmaple!
#
testrepos="testa"
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
