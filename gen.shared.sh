#!/bin/bash
wd=/home/gallard/gw
cd $wd
ruser=gallard@jeb
rgr=/opt/gitroot
#
for m in suba supa
do
	rm -rf $m
	mkdir $m
	cd $m
	git init
	echo "#" >.gitignore
	git add .gitignore
	git commit -m "First ignore"
	cd ..
	git clone --bare $m $m.bare
	touch $m.bare/git-daemon-export-ok
	rm $m.bare.tar.gz
	tar czvf $m.bare.tar.gz $m.bare
	#
	ssh $ruser rm -rf ~/$m.bare.tar.gz
	scp $m.bare.tar.gz $ruser:~
	ssh $ruser rm -rf $rgr/$m
	#
done
