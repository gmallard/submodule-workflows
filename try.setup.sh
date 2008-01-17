#!/bin/bash
wd=/home/gallard/gw
rm -rf $wd
mkdir $wd
cd $wd
#
mkdir a s
echo "init a"
cd a
git init
echo a >a.txt && git add . && git commit -m "add a.txt"
#
echo "init s"
cd ../s
git init
echo s >s.txt && git add . && git commit -m "add s.txt"
#
echo "first bare clones"
cd ..
git clone --bare a ab
git clone --bare s sb
#
echo "clones of the bare ones"
git clone ab ab.cloned
#
git clone sb sb.clone.one
#
git clone sb sb.clone.two
#
cd sb.clone.one
echo "in sb.clone.one - add submodule"
git submodule add /home/gallard/gw/ab.cloned ab
echo "in sb.clone.one - init submodule"
git submodule init
echo "in sb.clone.one - add submodule commit and push"
git add . && git commit -m "Add submodule" && git push
#
cd ..
cd sb.clone.two
echo "in sb.clone.two - pull"
git pull
echo "in sb.clone.two - submodule init"
git submodule init
echo "in sb.clone.two - submodule update"
git submodule update
echo "in sb.clone.two/ab - checkout master"
cd ab
echo "reset HEAD!!"
git checkout master
