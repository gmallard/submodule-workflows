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
umask 002
hn=$(dirname $0)
source $hn/../common/setvars
#
# Do work in each submodule
#
for m in $submods;do
    echo "wf-one $m"
    cd $m
    git checkout master
    git pull
    echo a new line from submod: $m user: $USER >>$m.txt
    git add .
    git commit -m "Add a line in repo: $m, user $USER"
    git push
    cd ..
done
#
# Add the work to the super module and push it.
#
git pull
git add .
git commit -m "update supermodule $m, user $USER"
git push
