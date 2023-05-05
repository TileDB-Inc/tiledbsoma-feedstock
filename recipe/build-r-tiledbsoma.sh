#!/bin/bash

set -ex

cd apis/r

export DISABLE_AUTOBREW=1

export CXX17FLAGS="-Wno-deprecated-declarations -Wno-deprecated"

${R} CMD INSTALL --build . ${R_ARGS}
