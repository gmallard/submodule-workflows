#!/bin/bash
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
