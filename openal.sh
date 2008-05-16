#!/bin/bash

. `dirname "$0"`/common || exit 1

PKG="openal"
MARKER="$BASEDIR/.${PKG}_is_built"
if [ -e "$MARKER" ]; then
	echo "$PKG seems to be already build, remove $MARKER to rebuild"
	exit 0
fi

OPENAL_DIR="openal-svn"
CONFIGURE_FLAGS="--prefix=$PREFIX --enable-null --enable-sdl --disable-vorbis --disable-mp3 --disable-smpeg --disable-alsa --disable-oss"
CFLAGS="-D_GNU_SOURCE"
export CFLAGS
execute svn co http://www.openal.org/repos/openal/trunk/OpenAL-Sample/ "$OPENAL_DIR"
execute pushd "$OPENAL_DIR"
execute "./autogen.sh"
execute "$BASEDIR/configure2x" $CONFIGURE_FLAGS
execute make
execute make install
execute popd
touch $MARKER
