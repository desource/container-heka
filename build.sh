#!/usr/bin/env sh
set -eux

BASE=$PWD
SRC=$PWD/src
OUT=$PWD/heka-build

export GOBIN=

cd $SRC
source ./build.sh

cp build/heka/bin/hekad $OUT/

