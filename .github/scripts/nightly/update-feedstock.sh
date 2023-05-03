#!/bin/bash
set -eux

# Allow uploads on branch "nightly-build"
sed -i \
  s/"upload_on_branch: main"/"upload_on_branch: nightly-build"/ \
  conda-forge.yml

# Use label "nightlies"
sed -i \
  s/"tiledb main"/"tiledb nightlies"/ \
  recipe/conda_build_config.yaml

# Print differences
git --no-pager diff conda-forge.yml recipe/conda_build_config.yaml
