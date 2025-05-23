#!/bin/sh

set -exo pipefail

mkdir libtiledbsoma-build && cd libtiledbsoma-build

cmake \
  -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}" \
  -DOVERRIDE_INSTALL_PREFIX=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DTILEDBSOMA_BUILD_CLI=OFF \
  -DTILEDBSOMA_ENABLE_TESTING=OFF \
  -DSPDLOG_LINK_SHARED=ON \
  ../libtiledbsoma

make -j ${CPU_COUNT}

make install-libtiledbsoma

cd .. && rm -rf libtiledbsoma-build
