#!/bin/bash

set -ex

cd apis/python

echo "$PKG_VERSION" >> RELEASE-VERSION
$PYTHON setup.py install --single-version-externally-managed --record record.txt --libtiledbsoma="${PREFIX}"

$PYTHON setup.py clean --all
