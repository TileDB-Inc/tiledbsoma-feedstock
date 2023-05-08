#!/bin/bash

set -ex

cd apis/r

export DISABLE_AUTOBREW=1

# https://conda-forge.org/docs/maintainer/knowledge_base.html#newer-c-features-with-old-sdk
if [[ $target_platform  == osx-64 ]]; then
  CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

export CXX17FLAGS="-Wno-deprecated-declarations -Wno-deprecated"

${R} CMD INSTALL --build . ${R_ARGS}
