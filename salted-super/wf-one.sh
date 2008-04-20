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
# Do work in a submodule
#
cd suba
echo aline  submod:  $repo  user: $USER >>a.txt
git add .
git commit -m "Add a line in repo: $repo, user $USER"
git pull && git push
#
# Update supermodule
#
cd ..
git add .
git commit -m "update submodule $repo, user $USER"
git pull && git push
