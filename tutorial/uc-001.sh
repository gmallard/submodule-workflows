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
# Find out where we are
#
p=$(pwd)
echo $p
#
# Run:
# - Work that changes files in work flow one
# - Pull those changes in work flow two
#
$p/wf-one.sh private
$p/wf-two.sh private2
#
# Run the above work sequence again, but from the other direction.
#
$p/wf-one.sh private2
$p/wf-two.sh private
#
# Repeat the above sequence as many times as you like.
#
