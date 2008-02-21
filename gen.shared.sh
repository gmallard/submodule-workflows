#!/bin/bash
set -x
wd=/home/gallard/gw
rm -rf $wd
mkdir $wd
#
for m in suba subb
do
	cd $wd
	rm -rf $m
	mkdir $m
	cd $m
	# git init --shared=group
	git init
	echo "#" >.gitignore
	git add .gitignore
	git commit -m "First ignore"
	cd ..
	rm -rf $m.bare
	git clone --bare $m $m.git
	rm -rf /public/$m.git
	mv $m.git /public
	#
done
for m in super
do
	cd $wd
	rm -rf $m
	mkdir $m
	cd $m
	# git init --shared=group
	git init
	echo "#" >.gitignore
	git add .gitignore
	git commit -m "First ignore"
	#
	git submodule add file:///public/suba.git
	git submodule add file:///public/subb.git
	git add .
	git commit -m "Add submodules."
	#
	cd ..
	rm -rf $m.bare
	git clone --bare $m $m.git
	rm -rf /public/$m.git
	mv $m.git /public
	#
done
#
for d in testa testb
do
	mkdir -p $wd/$d
	cd $wd/$d
	git clone file:///public/super.git super
	cd $wd/$d/super
	git submodule init
	git submodule update
done
#
set +x
