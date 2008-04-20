#!/bin/bash
#
# This file is part of the git Submodules Workflows project.
#
#    The git Submodules Workflows project is free software: you can redistribute it 
#    and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    Foobar is distributed in the hope that it will be useful,
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

