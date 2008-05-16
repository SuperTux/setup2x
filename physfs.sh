#!/bin/bash

. `dirname "$0"`/common || exit 1

PKG="physfs"
MARKER="$BASEDIR/.${PKG}_is_built"
if [ -e "$MARKER" ]; then
	echo "$PKG seems to be already build, remove $MARKER to rebuild"
	exit 0
fi

PHYSFS_VERSION="1.0.1"
PHYSFS_FILE="$DOWNLOAD_DIR/physfs-$PHYSFS_VERSION.tar.gz"
download "http://icculus.org/physfs/downloads/physfs-$PHYSFS_VERSION.tar.gz" "$PHYSFS_FILE"
execute tar -xf "$PHYSFS_FILE"
execute pushd physfs-"$PHYSFS_VERSION"
execute "$BASEDIR/configure2x" --prefix=/opt/open2x
execute make
execute make install
execute popd
touch $MARKER
