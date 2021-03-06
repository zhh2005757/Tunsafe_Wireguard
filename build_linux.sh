#!/bin/sh
set -e

RELARGS="-O3 -DNDEBUG"
DBGARGS="-g -D_DEBUG"
CURARGS="$RELARGS"

CLANGPP="clang++-6.0"
if [ -x /opt/rh/llvm-toolset-6.0/root/usr/bin/clang++ ]; then
	CLANGPP="/opt/rh/llvm-toolset-6.0/root/usr/bin/clang++"
fi

$CLANGPP -c -march=skylake-avx512 crypto/poly1305/poly1305-x64-linux.s crypto/chacha20/chacha20-x64-linux.s
$CLANGPP -I . $CURARGS -DWITH_NETWORK_BSD=1 -mssse3 -pthread -lrt -o tunsafe \
tunsafe_amalgam.cpp \
crypto/aesgcm/aesni_gcm-x64-linux.s \
crypto/aesgcm/aesni-x64-linux.s \
crypto/aesgcm/ghash-x64-linux.s \
chacha20-x64-linux.o \
poly1305-x64-linux.o \
