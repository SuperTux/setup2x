#!/bin/bash

. `dirname "$0"`/common || exit 1

PKG="curl"
MARKER="$BASEDIR/.${PKG}_is_built"
if [ -e "$MARKER" ]; then
	echo "$PKG seems to be already build, remove $MARKER to rebuild"
	exit 0
fi

CURL_VERSION="7.18.1"
CURL_FILE="$DOWNLOAD_DIR/curl-$CURL_VERSION.tar.bz2"
URL="http://curl.haxx.se/download/curl-$CURL_VERSION.tar.bz2"
CONFIGURE_FLAGS="--prefix=$PREFIX --without-ssl --without-libssh2 --disable-crypto-auth --disable-cookies --disable-ldap --disable-ldaps --disable-dict --disable-telnet --disable-tftp --disable-manual --disable-ipv6 --disable-ares --disable-sspi"
download "$URL" "$CURL_FILE"
execute tar -xf "$CURL_FILE"
execute pushd curl-"$CURL_VERSION"
execute "$BASEDIR/configure2x" $CONFIGURE_FLAGS
execute make
execute make install
execute popd
touch $MARKER
