#!/bin/bash
set -x
gr=/opt/gitroot
# gr=/gr
#
cd $gr
rm -rf suba.bare suba
tar xzvf /home/gallard/suba.bare.tar.gz
mv suba.bare suba
find suba -type d -exec chmod 2775 {} \;
find suba -type f -exec chmod 664 {} \;
#
rm -rf supa.bare supa
tar xzvf /home/gallard/supa.bare.tar.gz
mv supa.bare supa
find supa -type d -exec chmod 2775 {} \;
find supa -type f -exec chmod 664 {} \;
#
set +x

