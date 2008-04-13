#!/bin/bash
set -x
p=$(pwd)
echo $p
#
$p/wf-one.sh testa
$p/wf-two.sh testb
#
$p/wf-one.sh testb
$p/wf-two.sh testa
