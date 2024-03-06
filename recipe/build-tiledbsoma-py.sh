#!/bin/bash

set -ex

cd apis/python

echo "$PKG_VERSION" >> RELEASE-VERSION

export TILEDB_PATH=$PREFIX
export TILEDBSOMA_PATH=$PREFIX
$PYTHON -m pip install --no-deps --no-build-isolation . -vv

$PYTHON setup.py clean --all
