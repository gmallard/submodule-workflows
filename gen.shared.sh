#!/bin/bash
wd=/home/gallard/gw
mkdir $wd
cd $wd
ruser=gallard@jeb
rgr=/opt/gitroot
#
for m in suba supa
do
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
	git clone --bare $m $m.bare
	touch $m.bare/git-daemon-export-ok
	find $m.bare -type d -exec chmod 2775 {} \;
	find $m.bare -type f -exec chmod 644 {} \;
	rm $m.bare.tar.gz
	tar czvf $m.bare.tar.gz $m.bare
	#
	ssh $ruser rm -f ~/$m.bare.tar.gz
	scp $m.bare.tar.gz $ruser:~
	#
done
