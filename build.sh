#!/usr/bin/env sh
set -eux

dnf install -y systemd-devel

SRC=$PWD/src
OUT=$PWD/out
# GLIBC=$PWD/glibc

export GOBIN=

cd $SRC
source ./build.sh

mkdir -p $OUT/bin $OUT/etc $OUT/lib $OUT/usr
cp -r $SRC/build/heka/bin/hekad $OUT/bin
cp -r $SRC/build/heka/lib $OUT/usr

cat <<EOF > $OUT/etc/passwd
root:x:0:0:root:/:/dev/null
nobody:x:65534:65534:nogroup:/:/dev/null
EOF

cat <<EOF > $OUT/etc/group
root:x:0:
nogroup:x:65534:
EOF

cat <<EOF > $OUT/Dockerfile
FROM scratch

ENV \
  LD_LIBRARY_PATH=/lib64:/usr/lib \
  PATH=/bin

ADD bin /bin
ADD etc /etc
ADD usr /usr

ENTRYPOINT [ "/bin/hekad" ]

EOF
