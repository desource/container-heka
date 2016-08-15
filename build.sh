#!/usr/bin/env sh
set -eux

dnf install -y systemd-devel

SRC=$PWD/src
OUT=$PWD/out
GLIBC=$PWD/glibc

export GOBIN=

cd $SRC
source ./build.sh

mkdir -p $OUT/bin $OUT/lib
cp -r $SRC/build/heka/bin/hekad $SRC/build/heka/lib $OUT/

cp \
    $GLIBC/libc.so.* \
    $GLIBC/dlfcn/libdl.so.* \
    $GLIBC/nptl/libpthread.so.* \
    $GLIBC/elf/ld-linux-x86-64.so.* \
    $GLIBC/math/libm.so* \
    $GLIBC/nss/libnss_files.so.* \
    $GLIBC/resolv/libnss_dns.so.* \
    $OUT/lib

cat <<EOF > $OUT/Dockerfile
FROM scratch

ADD hekad /bin/hekad
ADD lib   /usr/lib/

ENV \
 LD_LIBRARY_PATH=/lib:/usr/lib \
 PATH=/bin

ENTRYPOINT [ "/bin/hekad" ]

EOF
