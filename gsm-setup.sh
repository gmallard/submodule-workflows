#!/bin/bash
set -x
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
done

# Now create the public superproject; we won't actually add the submodules yet.

mkdir super
cd super
git init
echo hi > super.txt
git add super.txt
git commit -m "Initial commit of empty superproject"

# Check out the superproject somewhere private and add all the submodules.

mkdir ~/subtut/private
cd ~/subtut/private
git clone ~/subtut/public/super
cd super

for mod in a b c d; do git submodule add ~/subtut/public/$mod; done
ls -a

# The "git submodule add" command does a couple of things:

#     * It clones the submodule under the current directory and by default checks out the master branch.
#     * It adds the submodule's clone path to the ".gitmodules" file and adds this file to the index, ready to be committed.
#     * It adds the submodule's current commit ID to the index, ready to be committed. 

cat .gitmodules

git status

# Let's take a quick poke around one of the submodule checkouts.

cd a
ls -a

git branch

# It looks just like a regular checkout:

cat .git/config

# Commit the superproject and publish it:

cd ..
git commit -m "Add submodules a, b, c, d."
git push

# Now look at it from the perspective of another developer:

mkdir ~/subtut/private2
cd ~/subtut/private2
# cd !$
git clone ~/subtut/public/super
cd ~/subtut/private2/super

# Pulling down the submodules is a two-step process. First run "git submodule init" to add the submodule repository URLs to .git/config:

git submodule init
git config -l

# Now use "git submodule update" to clone the repositories and check out the commits specified in the superproject.

git submodule update
cd a
ls -a

git branch
git checkout master
echo "adding a line again" >> a.txt
git commit -a -m "Updated the submodule from within the superproject."

echo "adding yet another" >> a.txt
git commit -a -m "Updated the submodule from within the superproject again."

git push
cd ..
git add a
git commit -m "Updated submodule a."
git show | cat
git push

# Switch back to the other private checkout; the new change should be visible.

cd ~/subtut/private/super
git pull
git submodule update
cat a/a.txt

#

set +x
