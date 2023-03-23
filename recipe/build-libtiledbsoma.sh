#!/bin/sh

set -exo pipefail

mkdir libtiledbsoma-build && cd libtiledbsoma-build

cmake \
  -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}" \
  -DOVERRIDE_INSTALL_PREFIX=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  ../libtiledbsoma

make -j ${CPU_COUNT}

make install-libtiledbsoma
