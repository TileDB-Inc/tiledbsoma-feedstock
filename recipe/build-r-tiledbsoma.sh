#!/bin/bash

set -ex

cd apis/r

export DISABLE_AUTOBREW=1

# The $CC and $CXX are set by Conda to things we could not and should not guess.
# All we can do is annotate them:
#
# * add flags;
# * for osx-64, set $CC and $CXX to be wrapper scripts which nonetheless
#   reference (and invoke) the original environment variables;
# * add a couple more that are necessary for C++ 20.

set +x
echo
echo ----------------------------------------------------------------
echo $(basename $0) ORIGINAL VARIABLES:
echo "CC      [$CC]"
echo "CXX     [$CXX]"
echo "CXX20   [$CXX20]"
echo "CXX_STD [$CXX_STD]"
echo ----------------------------------------------------------------
echo
set -x

export         CC="$CC -std=c++20"
export        CXX="$CXX -std=c++20 -fpic -fvisibility-inlines-hidden -fmessage-length=0 -march=nocona -ftree-vectorize -fPIC -fstack-protector-strong -fno-plt -ffunction-sections"
export      CXX20="$CXX"
export    CXX_STD="CXX20"
export CXX20FLAGS="-Wno-deprecated-declarations -Wno-deprecated"

set +x
echo
echo ----------------------------------------------------------------
echo $(basename $0) UPDATED VARIABLES -- BUMP002:
echo "CC      [$CC]"
echo "CXX     [$CXX]"
echo "CXX20   [$CXX20]"
echo "CXX_STD [$CXX_STD]"
echo ----------------------------------------------------------------
echo
set -x

# https://github.com/conda-forge/r-tiledb-feedstock/commit/29cb6816636e7b5b58545e1407a8f0c29ff9dc39
mkdir -p ~/.R
if [[ $target_platform  == osx-64 ]]; then
  export  NN_CC_ORIG=$CC
  export NN_CXX_ORIG=$CXX
  export    CC=$RECIPE_DIR/cc_wrap.sh
  export   CXX=$RECIPE_DIR/cxx_wrap.sh
  export CXX20=$RECIPE_DIR/cxx_wrap.sh
fi

echo      CC="$CC"      >  ~/.R/Makevars
echo     CXX="$CXX"     >> ~/.R/Makevars
echo   CXX20="$CXX20"   >> ~/.R/Makevars
echo CXX_STD="$CXX_STD" >> ~/.R/Makevars

set +x
echo
echo ----------------------------------------------------------------
echo $(basename $0) MAKEVARS:
cat ~/.R/Makevars
echo ----------------------------------------------------------------
echo
set -x

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

set +x
echo
echo ----------------------------------------------------------------
echo TRYING ARROW LOAD
echo ----------------------------------------------------------------
echo
set -x

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

set +x
echo
echo ----------------------------------------------------------------
echo BEFORE R CMD INSTALL
echo ----------------------------------------------------------------
echo
set -x

${R} CMD INSTALL ${R_ARGS_EXTRA} --build . ${R_ARGS}

set +x
echo
echo ----------------------------------------------------------------
echo AFTER R CMD INSTALL
echo ----------------------------------------------------------------
echo
set -x
