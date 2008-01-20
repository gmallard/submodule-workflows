#!/bin/bash
set -x
gr=/opt/gitroot
#
cd $gr
rm -rf suba.bare supa
tar xzvf ~/suba.bare.tar.gz
mv suba.bare suba
#
rm -rf supa.bare supa
tar xzvf ~/supa.bare.tar.gz
mv supa.bare supa
#
set +x

