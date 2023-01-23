# #!/bin/sh

set -exo pipefail

mkdir libtiledbsoma-build && cd libtiledbsoma-build
cmake -DCMAKE_INSTALL_PREFIX:PATH="${PREFIX}" ../libtiledbsoma

make -j ${CPU_COUNT}
