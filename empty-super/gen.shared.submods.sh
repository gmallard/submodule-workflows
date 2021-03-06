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
rm -rf $public/*
#
umask 002
wd=$home/$user/gw
rm -rf $wd
mkdir -p $wd
#
# Submodules:
# - Initialize a submodule repository
# - Run the first commit
# - Make a bare clone
# - Move the clone to the public area
#
for submod in $submods
do
	cd $wd
	rm -rf $submod
	mkdir $submod
	cd $submod
	git init
	echo "#" >.gitignore
	git add .gitignore
	git commit -m "First ignore"
	pushd $public
	git init --bare $submod.git
	popd
	git remote add origin $public/$submod.git
	git push -u origin master
	#
done
#
rm -rf $wd/*
set +x
