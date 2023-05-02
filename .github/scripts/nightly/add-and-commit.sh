#!/bin/bash
set -eux

git config --local user.name "GitHub Actions"
git config --local user.email "runneradmin@github.com"
git commit -am "Nightly build"

