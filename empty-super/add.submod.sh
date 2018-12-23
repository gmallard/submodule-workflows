#!/bin/bash
#
# Copyright (C) 2008-2018 Guy Allard
#
# This file is part of the git Submodules Workflows project.
#
#    The git Submodules Workflows project is free software: you can redistribute it 
#    and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    The git Submodules Workflows project is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with the git Submodules Workflows project.  
#    If not, see <http://www.gnu.org/licenses/>.
#
set -x
#
# Housekeeping: set up working directory for this test.
#
hn=$(dirname $0)
source $hn/../common/setvars
#
wd=$home/$user/gw
umask 002
#
# For Each Testrepo:
# - Make a repo directory, and CD to it
# - Clone the supermodule
# - Then, for each submodule:
# --add the submodule
# -- Commit the result
# Finally:
# Push it all.
#
for repo in $testrepos
do
	mkdir -p $wd/$repo
	cd $wd/$repo
	git clone $public/super.git super
	cd super
	git checkout master
	#
	# The super repo created above is not set up for submodules at all.
	# That needs to be done on an individual submodule basis.
	#
	for submod in $submods
	do
		# Submodule add does:
		# 1) Clones the submodule under the current directory and by default
		#    checks out the master branch.
		# 2) Adds the submodule's clone path to the ".gitmodules" file and adds
		#    this file to the index, ready to be committed.
		# 3) Adds the submodule's current commit ID to the index, ready to be
		#    committed.
		git submodule add $public/$submod.git
		git status
		#
		git commit -m "Added submodule $public/$submod.git."
	done
	#
	# Push the results to the public bare super.
	#
	git push
done
