#!/bin/bash
wd=/home/gallard/gw
cd $wd
ruser=gallard@jeb
#
for m in suba supa
do
	rm -rf $m
	git clone $GITROOT/$m
done
