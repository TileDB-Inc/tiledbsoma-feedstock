#!/bin/bash

set -ex

cd apis/python

echo "$PKG_VERSION" >> RELEASE-VERSION
export TILEDBSOMA_PATH="${PREFIX}"
$PYTHON setup.py install --single-version-externally-managed --record record.txt
