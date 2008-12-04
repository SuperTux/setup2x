#!/bin/bash

. `dirname "$0"`/common || exit 1

PKG="vorbis"
MARKER="$BASEDIR/.${PKG}_is_built"
if [ -e "$MARKER" ]; then
	echo "$PKG seems to be already build, remove $MARKER to rebuild"
	exit 0
fi

VORBIS_DIR="libvorbis-1.2.0"
VORBIS_FILE="$VORBIS_DIR.tar.gz"
CFLAGS="-D_GNU_SOURCE"
export CFLAGS
download "http://downloads.xiph.org/releases/vorbis/libvorbis-1.2.0.tar.gz" "download/$VORBIS_FILE"
execute tar -xf "download/$VORBIS_FILE"
execute pushd "$VORBIS_DIR"
#execute "./autogen.sh"
execute "$BASEDIR/configure2x" $CONFIGURE_FLAGS
execute make
execute make install
execute popd
touch $MARKER
