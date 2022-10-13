#!/usr/bin/env bash
set -e
THREADS=${THREADS:=""}
CWD="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DIR="irrlicht"
GIT_URL="https://github.com/minetest/$DIR"
VERSION="master"
FFF=("include" "lib" "$DIR" "share")
[ ! -z "$MKN_CLEAN" ] && (( $MKN_CLEAN == 1 )) && for f in ${FFF[@]}; do rm -rf $CWD/$f; done
[ ! -d "$CWD/$DIR" ] && git clone --depth 1 $GIT_URL -b $VERSION $DIR --recursive
cd $CWD/$DIR
rm -rf build && mkdir build && cd build

cmake .. \
  -DCMAKE_INSTALL_PREFIX=$CWD \
  -DCMAKE_CXX_FLAGS="-g0 -O3 -march=native -mtune=native" \
  -DCMAKE_BUILD_TYPE=Release # -DBUILD_SHARED_LIBS=ON

make VERBOSE=1 -j$THREADS && make install
cd .. && rm -rf build
