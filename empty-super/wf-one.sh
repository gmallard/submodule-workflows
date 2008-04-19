#!/bin/bash
set -x
#
umask 002
#
# Do work in a submodule
#
cd suba
echo aline  submod:  $repo dir: $(pwd) >>a.txt
git add .
git commit -m "Add a line in $repo"
git pull && git push
#
# Update supermodule
#
cd ..
git add .
git commit -m "update submodule in $repo"
git pull && git push
