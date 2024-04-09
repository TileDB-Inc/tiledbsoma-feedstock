#!/bin/bash

set -ex

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

# https://conda-forge.org/docs/maintainer/knowledge_base/#newer-c-features-with-old-sdk
if [[ $target_platform == osx-*  ]]; then
  CXXFLAGS="${CXXFLAGS} -D_LIBCPP_DISABLE_AVAILABILITY"
fi

# Unlike most R recipes which are built for one R version per job, this recipe
# with multiple outputs builds for each of the R versions in the same job. Thus
# the compiled files in the source directory need to be cleaned between builds,
# otherwise, the files are only compiled during the first build
R_ARGS_EXTRA="--clean"
# The .Rd files use the `\Sexpr{}` macro to evaluate R code, so the man pages
# can't be installed when cross-compiling for osx-arm64 from osx-amd64
# https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Dynamic-pages
if [[ $target_platform  == osx-arm64 ]]; then
  R_ARGS_EXTRA="$R_ARGS_EXTRA --no-help"
fi

# Ensure the arrow package loads 'standalone' as a proxy for possible issues
# arising when it is loaded to check the R package build
# We call the helper function arrow_info() returning a (classed) list (for
# which it has a default pretty-printer dispatching for the class) and
# assert that the underlying list the expected length)
res=$(Rscript -e 'cat(length(unclass(arrow::arrow_info())) == 6)')
if [ ${res} != "TRUE" ]; then
  echo "*** Aborting build as 'arrow' package may have issues"
  exit 1
fi

${R} CMD INSTALL ${R_ARGS_EXTRA} --build . ${R_ARGS}
