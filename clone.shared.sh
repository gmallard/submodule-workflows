#!/bin/bash
set -x
wd=/home/gallard/gw
cd $wd
ruser=gallard@jeb
clone1=supa.cloned.one
clone2=supa.cloned.two
rm -rf $clone1
rm -rf $clone2
#
# Repo One
# ======
#
# - Clone it
#
git clone $GITROOT/supa $clone1
cd $clone1
#
# Initialize a new submodule: add, init, update
#
git submodule add $GITROOT/suba
git submodule init
git submodule update
#
# Commit the submodule and push it
#
git add .
git commit -m "Add a submodule to supermodule"
git pull && git push
#
# Repo Two
# ======
#
#
# - Clone it
#
cd $wd
git clone $GITROOT/supa $clone2
cd $clone2
#
# Initialize existing submodules: init, update
#
git submodule init
git submodule update
set +x

