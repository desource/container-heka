#!/usr/bin/env sh
set -eux

SRC=$PWD/src
OUT=$PWD/out

VERSION=1

export GOBIN=

cd $SRC
source ./build.sh

mkdir -p $OUT/bin
cp ./heka/bin/hekad $OUT/bin/hekad

cat <<EOF > $OUT/Dockerfile
FROM scratch

ADD bin/hekad /bin/hekad

ENTRYPOINT [ "/bin/hekad" ]

EOF
