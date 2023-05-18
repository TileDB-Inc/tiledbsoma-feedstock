#!/bin/bash

set -ex

find $PREFIX -type f -name '*soma*'
find $PREFIX -type f -name '*arrow*'

cd apis/r

export DISABLE_AUTOBREW=1

# https://github.com/conda-forge/r-tiledb-feedstock/commit/29cb6816636e7b5b58545e1407a8f0c29ff9dc39
if [[ $target_platform  == osx-64 ]]; then
  export NN_CXX_ORIG=$CXX
  export NN_CC_ORIG=$CC
  export CXX=$RECIPE_DIR/cxx_wrap.sh
  export CC=$RECIPE_DIR/cc_wrap.sh
  mkdir -p ~/.R
  echo CC=$RECIPE_DIR/cc_wrap.sh > ~/.R/Makevars
  echo CXX=$RECIPE_DIR/cxx_wrap.sh >> ~/.R/Makevars
  echo CXX17=$RECIPE_DIR/cxx_wrap.sh >> ~/.R/Makevars
fi

export CXX17FLAGS="-Wno-deprecated-declarations -Wno-deprecated"

which ${R}
${R} --version

${R} CMD INSTALL --build . ${R_ARGS}
