#!/usr/bin/env sh
set -eux

dnf install -y systemd-devel

SRC=$PWD/src
OUT=$PWD/out

VERSION=1

export GOBIN=

cd $SRC
source ./build.sh

mkdir -p $OUT/bin $OUT/lib
cp -r $SRC/build/heka/bin/hekad $SRC/build/heka/lib $OUT/

cat <<EOF > $OUT/Dockerfile
FROM scratch

ADD hekad /bin/hekad
ADD lib   /usr/lib/

ENV \
 LD_LIBRARY_PATH=/usr/lib:/lib64 \
 PATH=/bin

ENTRYPOINT [ "/bin/hekad" ]

EOF
