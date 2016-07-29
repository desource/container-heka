#!/usr/bin/env sh
set -eux

BASE=$PWD
SRC=$PWD/src
OUT=$PWD/heka-build

export GOBIN=

cd $SRC
source ./build.sh

mkdir -p $OUT/builds/heka/
cp ./heka/bin/hekad $OUT/builds/heka/
