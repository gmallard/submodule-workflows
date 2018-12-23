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
# your home directory in /home/opt/public/repos/subtut/public. Let's create the four
# submodule repositories first:
#
umask 002
base=/home/opt/public/repos
rm -rf $base/subtut
#
mkdir -p $base/subtut/private $base/subtut/public
for mod in a b c d; do
    # First the private repository.
    cd $base/subtut/private
    mkdir $mod
    cd $mod
    git init
    echo "module $mod" > $mod.txt
    git add $mod.txt
    git commit -m "Initial commit, public module $mod"
    # Then the public bare repository.
    cd $base/subtut/public
    mkdir $mod.git
    cd $mod.git
    git init --bare
    # Back to the private repo.  Set up origin.
    cd $base/subtut/private
    cd $mod
    git remote add origin $base/subtut/public/$mod.git
    git config branch.master.remote origin
    git config branch.master.merge refs/heads/master
    # And push work so far.
    git push -u origin master
    cd ..
done
#
# Now the super project.  We do not actually add submodules yet.
cd $base/subtut/private
# The private super repository.
mkdir super
cd super
git init
echo hi > super.txt
git add super.txt
git commit -m "Initial commit of empty superproject"
# The public bare super repository.
cd $base/subtut/public
mkdir super.git
cd super.git
git init --bare
# Back to the private repo
cd $base/subtut/private
cd super
git remote add origin $base/subtut/public/super.git
git config branch.master.remote origin
git config branch.master.merge refs/heads/master
#
git push -u origin master
#
# Add the submodules ato the super project and look around.
#
cd $base/subtut/private
cd super
for mod in a b c d; do git submodule add $base/subtut/public/$mod.git $mod; done
cat .gitmodules
#
# Commit the submodules add
#
git commit -m "Add submodules a, b, c, d."
echo "================================================"
#
# Look around
#
ls -a
echo "================================================"
git status
#
# Push the added submodule definitions
#
git push
#
# Now look at it from the perspective of another developer:
#
mkdir $base/subtut/private2
#
# cd !$   # replaced with ....
#
cd $base/subtut/private2
git clone $base/subtut/public/super
cd $base/subtut/private2/super
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
#
# Look at what is in the a submodule.
#
cd a
ls -a
git status
git branch
#
# One major difference between "submodule update" and "submodule add" is that
# "update" checks out a specific commit, rather than the tip of a branch. It's
# like checking out a tag: the head is detached, so you're not working on a
# branch.
#
# Now checkout the working branch, make a change, and oush it.
#
git checkout master
echo "adding a line again" >> a.txt
git commit -a -m "Updated the submodule from within the superproject."
git push
#
# cd back to the base of the super project.
#
cd ..
#
# Add and commit the changed submodule (a in this case).
#
git add a
git commit -m "Changed submodule a"
git show
#
# And push that change to super's public repo.
#
git push
#
# Switch to the other private checkout, pull the changes, and update the
# submodule.  The change to submodule a should be present.
#
cd $base/subtut/private/super
git pull
git submodule update
cat a/a.txt
set +x
