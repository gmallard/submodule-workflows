#!/bin/bash
wd=/home/gallard/gw
submods="suba subb"
testrepos="testa testb"
supers="super"
#
for tr in $testrepos
do
	for sp in $supers
	do
		for sm in $submods
		do
			cd $wd/$tr/$sp/$sm
			echo $(pwd)
			git status
		done
	done
done
