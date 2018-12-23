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
umask 002
rm -rf $public/*
#
wd=$home/$user/gw
rm -rf $wd
mkdir -p $wd
#
# Submodules:
# - Create empty repo
# - Run first commit in it
# - Create a bare repo
# - Add that as a remote
# - Push it to the remote
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
	pushd $public
	git init --bare $m.git
	popd
	git remote add origin $public/$m.git
	git push -u origin master
	#
done
#
# Supermodule(s):
# - Should only be one of these!
# - Create it
# - Run the first commit
# - Add each submodule
# - Commit the adds
# - Create a bare repo
# - Add that as a remote
# - Push the super to the remote
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
		git submodule add $public/$sm.git
	done
	git add .
	git commit -m "Add submodules."
	#
	pushd $public
	git init --bare $m.git
	popd
	git remote add origin $public/$m.git
	git push -u origin master
	#
done
#
set +x
