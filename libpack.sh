#!/bin/bash

. common

PKG="open2x-libpack"
MARKER="$BASEDIR/.${PKG}_installed"
if [ -e "$MARKER" ]; then
	echo "$PKG seems to be already build, remove $MARKER to rebuild"
	exit 0
fi

FILE="open2x-libpack-20071903-gcc-4.1.1-glibc-2.3.6.tar.bz2"
URL="http://www.open2x.org/open2x/toolchains/$FILE.zip"
DOWNLOADED="$DOWNLOAD_DIR/$FILE"
download "$URL" "$DOWNLOADED"
execute pushd "$PREFIX"
execute tar -xf "$DOWNLOADED"
execute popd
touch "$MARKER"
