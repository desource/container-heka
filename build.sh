#!/usr/bin/env sh
set -eux

## TODO: move out of here
dnf -y install golang

BASE=$PWD
SRC=$PWD/src
OUT=$PWD/heka-build

cd $SRC
source ./build.sh

mkdir $OUT
cp build/heka/bin/hekad $OUT/

