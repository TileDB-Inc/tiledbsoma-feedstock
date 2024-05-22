#!/bin/bash

set -ex

cd apis/python

echo
echo "PKG_VERSION IS <<$PKG_VERSION>>"
echo
echo "$PKG_VERSION" >> RELEASE-VERSION

export TILEDB_PATH=$PREFIX
export TILEDBSOMA_PATH=$PREFIX
$PYTHON -m pip install --no-deps --no-build-isolation . -vv

$PYTHON setup.py clean --all
