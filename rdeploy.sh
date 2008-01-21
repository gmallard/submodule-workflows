#!/bin/bash
set -x
gr=/opt/gitroot
# gr=/gr
#
cd $gr
rm -rf suba.bare suba
tar xzvf /home/gallard/suba.bare.tar.gz
mv suba.bare suba

rm -rf supa.bare supa
tar xzvf /home/gallard/supa.bare.tar.gz
mv supa.bare supa
#
set +x

