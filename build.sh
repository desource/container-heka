#!/usr/bin/env sh
set -eux

BASE=$PWD
SRC=$PWD/src
OUT=$PWD/heka-build

VERSION=1

export GOBIN=

cd $SRC
source ./build.sh

mkdir -p $OUT/builds/heka/${VERSION}
cp ./heka/bin/hekad $OUT/builds/heka/${VERSION}
