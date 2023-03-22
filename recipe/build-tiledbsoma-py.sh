#!/bin/bash

set -ex

cd apis/python

echo "1.1.1" >> RELEASE-VERSION
$PYTHON -m pip install . -vv
