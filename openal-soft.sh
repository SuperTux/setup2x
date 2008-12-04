#!/bin/bash

. `dirname "$0"`/common || exit 1

PKG="openal-soft"
MARKER="$BASEDIR/.${PKG}_is_built"
if [ -e "$MARKER" ]; then
	echo "$PKG seems to be already build, remove $MARKER to rebuild"
	exit 0
fi

export CC="$COMPILER_PREFIX/bin/$TARGET-gcc"
export CXX="$COMPILER_PREFIX/bin/$TARGET-g++"
#export GCC_EXEC_PREFIX="$TARGET"
export PKG_CONFIG_PATH="$COMPILER_PREFIX/lib/pkgconfig:$PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"

CMAKE_FLAGS="-DDEBUG=on"
INCLUDE2X="$PREFIX/include"
INCLUDEL2X="$COMPILER_PREFIX/../usr/include"
LIB2X="$PREFIX/lib"
LIBL2X="$COMPILER_PREFIX/../usr/lib"
CMAKE_FLAGS=""
CMAKE_FLAGS="$CMAKE_FLAGS -DGENERATE_MESSAGESPOT=off"
CMAKE_FLAGS="$CMAKE_FLAGS -DGENERATE_WRAPPER=off"
CMAKE_FLAGS="$CMAKE_FLAGS -DCMAKE_CXX_COMPILER=$CXX"
CMAKE_FLAGS="$CMAKE_FLAGS -DCMAKE_C_COMPILER=$CC"
CFLAGS="-I$INCLUDEL2X -I$INCLUDEL2X"
CMAKE_FLAGS="$CMAKE_FLAGS -DCMAKE_CXX_FLAGS=$CFLAGS"
CMAKE_FLAGS="$CMAKE_FLAGS -DCMAKE_C_FLAGS=$CFLAGS"
CMAKE_FLAGS="$CMAKE_FLAGS -DCMAKE_INSTALL_PREFIX=$PREFIX"
CMAKE_FLAGS="$CMAKE_FLAGS -DHAVE_FESETROUND=0"
CMAKE_FLAGS="$CMAKE_FLAGS --enable-null --enable-sdl --disable-vorbis --disable-mp3 --disable-smpeg --disable-alsa --disable-oss"

AL_VERSION="1.6.372"
AL_FILE="$DOWNLOAD_DIR/openal-soft-$AL_VERSION.tar.bz2"
download "http://kcat.strangesoft.net/openal-releases/openal-soft-$AL_VERSION.tar.bz2" "$AL_FILE"
execute tar -xf "$AL_FILE"
execute pushd "openal-soft-$AL_VERSION"
execute cmake $CMAKE_FLAGS .
execute make -j 2
execute make install
execute popd "openal-soft-$AL_VERSION"
