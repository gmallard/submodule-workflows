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
# This is almost a direct cut and paste from the submodule example given at:
# http://git.or.cz/gitwiki/GitSubmoduleTutorial
#
# Most comments in the code are also cut and paste from the commentary
# at that location.
#
# ---------------------------------------------------------------------------------------------------------------
#
# Submodules maintain their own identity; the submodule support just stores the 
# submodule repository location and commit ID, so other developers who 
# clone the superproject can easily clone all the submodules at the same revision.
#
# For the purposes of the tutorial, the public repositories will be published under 
# your home directory in ~/subtut/public. Let's create the four public 
# submodule repositories first:
#
rm -rf ~/subtut
mkdir ~/subtut ~/subtut/public
cd ~/subtut/public
for mod in a b c d; do
    mkdir $mod
    cd $mod
    git init
    echo "module $mod" > $mod.txt
    git add $mod.txt
    git commit -m "Initial commit, public module $mod"
    cd ..
	git clone --bare $mod $mod.git
done
#
# Now create the public superproject; we won't actually add the submodules yet.
#
mkdir super
cd super
git init
echo hi > super.txt
git add super.txt
git commit -m "Initial commit of empty superproject"
cd ..
git clone --bare super super.git
#
# Check out the superproject somewhere private and add all the submodules.
#
mkdir ~/subtut/private
cd ~/subtut/private
git clone ~/subtut/public/super.git
cd super
#
for mod in a b c d; do git submodule add ~/subtut/public/$mod.git $mod; done
ls -a
#
# The "git submodule add" command does a couple of things:
#
#     * It clones the submodule under the current directory and by default checks out the master branch.
#     * It adds the submodule's clone path to the ".gitmodules" file and adds this file to the index, ready to be committed.
#     * It adds the submodule's current commit ID to the index, ready to be committed. 
#
cat .gitmodules
#
git status
#
# Let's take a quick poke around one of the submodule checkouts.
#
cd a
ls -a
#
git branch
#
# It looks just like a regular checkout:
#
cat .git/config
#
# Commit the superproject and publish it:
#
cd ..
git commit -m "Add submodules a, b, c, d."
git push
#
# Now look at it from the perspective of another developer:
#
mkdir ~/subtut/private2
#
# cd !$   # replaced with ....
#
cd ~/subtut/private2
git clone ~/subtut/public/super.git super
cd ~/subtut/private2/super
ls -a
#
# The submodule directories are there, but they're empty:
#
ls -a a
git submodule status
#
# Pulling down the submodules is a two-step process. First run "git submodule init" 
# to add the submodule repository URLs to .git/config:
#
git submodule init
git config -l
#
# Now use "git submodule update" to clone the repositories and check out the 
# commits specified in the superproject.
#
git submodule update
cd a
ls -a
#
# One major difference between "submodule update" and "submodule add" is that 
# "update" checks out a specific commit, rather than the tip of a branch. It's 
# like checking out a tag: the head is detached, so you're not working 
# on a branch.
#
git branch
#
# If you want to make a change within a submodule, you should first check out a 
# branch, make your changes, publish the change within the submodule, and 
# then update the superproject to reference the new commit:
#
git branch
git checkout master
echo "adding a line again" >> a.txt
git commit -a -m "Updated the submodule from within the superproject."
git push
cd ..
git add a
git commit -m "Updated submodule a."
git show | cat
git push
#
# Switch back to the other private checkout; the new change should be visible.
# 
cd ~/subtut/private/super
git pull
#
# Here we run in to trouble.  The commands in the tutorial are:
#
# git submodule update
# cat a/a.txt
#
# However that yeilds incorrect results:  the new change is in fact not
# visible.
#
# The following does work:
#
# git submodule update --init
# cat a/a.txt
git submodule update --init
cat a/a.txt
#
# The following also works (but is probably not correct use):
#
# - cd to the submodule directory
# - checkout the master brnach
# - run pull
# 
# cd a
# git checkout master
# git pull
#
# Display the file with the new change.
#
# cat a.txt
set +x
