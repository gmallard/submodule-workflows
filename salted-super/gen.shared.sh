#!/bin/bash
#
# Copyright (C) 2008 Guy Allard
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
