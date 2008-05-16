#!/bin/bash

. common

PKG="toolchain"
MARKER="$BASEDIR/.${PKG}_installed"
if [ -e "$MARKER" ]; then
	echo "$PKG seems to be already build, remove $MARKER to rebuild"
	exit 0
fi

FILE="arm-open2x-linux-apps-gcc-4.1.1-glibc-2.3.6_i686_linux.tar.bz2"
URL="http://www.open2x.org/open2x/toolchains/$FILE.zip"
DOWNLOADED="$DOWNLOAD_DIR/$FILE"
download "$URL" "$DOWNLOADED"
execute pushd "$PREFIX"
execute tar -x --strip-components=2 -f "$DOWNLOADED"
execute popd
touch "$MARKER"
