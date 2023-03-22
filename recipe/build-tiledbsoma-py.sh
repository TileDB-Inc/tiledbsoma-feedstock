#!/bin/bash

set -ex

cd apis/python

echo "$PKG_VERSION" >> RELEASE-VERSION
$PYTHON -m pip install . -vv
