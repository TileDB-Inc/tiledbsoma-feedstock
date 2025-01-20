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
# Cover edge case when the label "rc" is temporarily used to upload release
# candidates
sed -i \
  s/"tiledb rc"/"tiledb nightlies"/ \
  recipe/conda_build_config.yaml

# Apply patch from Xanthos to support C++20
# https://github.com/TileDB-Inc/tiledbsoma-feedstock/pull/246
patch -p1 < .github/scripts/nightly/cpp20.patch

# Print differences
git --no-pager diff conda-forge.yml recipe/conda_build_config.yaml
