#!/bin/bash
wd=/home/gallard/gw
rm -rf $wd
mkdir $wd
cd $wd
#
mkdir a s
echo init a
cd a
git init
echo a >a.txt && git add . && git commit -m "add a.txt"
#
echo init s
cd ../s
git init
echo s >s.txt && git add . && git commit -m "add s.txt"
#
echo first clones
cd ..
git clone --bare a ab
git clone --bare s sb
#
echo init sbc1
git clone sb sbc1
cd sbc1
git submodule add $wd/ab
git submodule init
git add .
git commit -m "add submodule"
git push
#
cd ..
echo init sbc2
git clone sb sbc2
cd sbc2
git submodule init
git submodule update
cd ab
#
git checkout master
echo "add line in sbc2"
echo aa >> a.txt && git add . && git commit -m "Add a line"
cd ..
git add . && git commit -m "Change submodule"
#
cd ab
echo push subdir ab
git push
cd ..
echo push main
git push
#
cd ../sbc1
echo pull main
git pull
echo submod update
git submodule update
cd ab
echo "checkout master in ab"
git checkout master
echo "pull in ab"
git pull
#
