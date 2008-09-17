#!/bin/bash

. `dirname "$0"`/common || exit 1

PKG="ogg"
MARKER="$BASEDIR/.${PKG}_is_built"
if [ -e "$MARKER" ]; then
	echo "$PKG seems to be already build, remove $MARKER to rebuild"
	exit 0
fi

OGG_DIR="libogg-1.1.3"
OGG_FILE="$OGG_DIR.tar.gz"
CONFIGURE_FLAGS=""
CFLAGS="-D_GNU_SOURCE"
export CFLAGS
download "http://downloads.xiph.org/releases/ogg/libogg-1.1.3.tar.gz" "download/$OGG_FILE"
execute tar -xf "download/$OGG_FILE"
execute pushd "$OGG_DIR"
#execute "./autogen.sh"
execute "$BASEDIR/configure2x" $CONFIGURE_FLAGS
execute make
execute make install
execute popd
touch $MARKER
