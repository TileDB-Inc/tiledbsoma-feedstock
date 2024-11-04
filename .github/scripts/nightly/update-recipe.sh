#!/bin/bash
set -eux

# append the date (.devYYYYMMDD) to version string
# has to follow conda recipe rules (no dashes) and PEP 440 (enforced by setuptools)
# https://peps.python.org/pep-0440/
# https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html?highlight=recipe%20meta.yaml#package-version
the_date="$(date +%Y%m%d)"
sed -i \
  s/"{% set version = \"\(.*\)\" %}"/"{% set version = \"\\1.dev${the_date}\" %}"/ \
  recipe/meta.yaml

# Use Git URL as source
sed -i \
  s/"url: https:\/\/github.com\/single-cell-data\/TileDB-SOMA\/archive\/{{ version }}.tar.gz"/"git_url: https:\/\/github.com\/single-cell-data\/TileDB-SOMA.git"/ \
  recipe/meta.yaml

# Build the latest commit on "main" branch
sed -i \
  s/"sha256: .\+"/"git_rev: main\n  git_depth: -1"/ \
  recipe/meta.yaml

# (Temporary) Bump somacore
sed -i \
  s/"somacore ==.\+"/"somacore ==1.0.23"/ \
  recipe/meta.yaml

git --no-pager diff recipe/meta.yaml
