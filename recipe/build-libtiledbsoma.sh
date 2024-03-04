#!/bin/sh

set -exo pipefail

# https://conda-forge.org/docs/maintainer/knowledge_base/#newer-c-features-with-old-sdk
if [[ $target_platform == osx-*  ]]; then
  CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

mkdir libtiledbsoma-build && cd libtiledbsoma-build

cmake \
  -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}" \
  -DOVERRIDE_INSTALL_PREFIX=OFF \
  -DCMAKE_BUILD_TYPE=Release \
  -DTILEDBSOMA_BUILD_CLI=OFF \
  -DTILEDBSOMA_ENABLE_TESTING=OFF \
  ../libtiledbsoma

make -j ${CPU_COUNT}

make install-libtiledbsoma

cd .. && rm -rf libtiledbsoma-build
