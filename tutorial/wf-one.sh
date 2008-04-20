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
# Pick up private clone name from command line.
#
p=$1
cd ~/subtut/$p/super
#
# Do work in a submodule.
#
cd a
echo aline $p >>a.txt
git add .
git commit -m "Add a line"
#
# Seems good practice to pull before you push.
#
git pull && git push
#
# Update supermodule
#
cd ..
git add .
git commit -m "update submodule"
git pull && git push
