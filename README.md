About tiledbsoma-feedstock
==========================

Feedstock license: [BSD-3-Clause](https://github.com/TileDB-Inc/tiledbsoma-feedstock/blob/master/LICENSE.txt)

Home: http://tiledb.com

Package license: MIT

Summary: TileDB-SOMA API

Development: https://github.com/single-cell-data/TileDB-SOMA

Documentation: https://docs.tiledb.com/

Python API for efficient storage and retrieval of single-cell data using TileDB

Current build status
====================


<table>
    
  <tr>
    <td>Azure</td>
    <td>
      <details>
        <summary>
          <a href="https://dev.azure.com/TileDB-Inc/feedstock-builds/_build/latest?definitionId=&branchName=master">
            <img src="https://dev.azure.com/TileDB-Inc/feedstock-builds/_apis/build/status/tiledbsoma-feedstock?branchName=master">
          </a>
        </summary>
        <table>
          <thead><tr><th>Variant</th><th>Status</th></tr></thead>
          <tbody><tr>
              <td>linux_64</td>
              <td>
                <a href="https://dev.azure.com/TileDB-Inc/feedstock-builds/_build/latest?definitionId=&branchName=master">
                  <img src="https://dev.azure.com/TileDB-Inc/feedstock-builds/_apis/build/status/tiledbsoma-feedstock?branchName=master&jobName=linux&configuration=linux%20linux_64_" alt="variant">
                </a>
              </td>
            </tr><tr>
              <td>osx_64</td>
              <td>
                <a href="https://dev.azure.com/TileDB-Inc/feedstock-builds/_build/latest?definitionId=&branchName=master">
                  <img src="https://dev.azure.com/TileDB-Inc/feedstock-builds/_apis/build/status/tiledbsoma-feedstock?branchName=master&jobName=osx&configuration=osx%20osx_64_" alt="variant">
                </a>
              </td>
            </tr><tr>
              <td>osx_arm64</td>
              <td>
                <a href="https://dev.azure.com/TileDB-Inc/feedstock-builds/_build/latest?definitionId=&branchName=master">
                  <img src="https://dev.azure.com/TileDB-Inc/feedstock-builds/_apis/build/status/tiledbsoma-feedstock?branchName=master&jobName=osx&configuration=osx%20osx_arm64_" alt="variant">
                </a>
              </td>
            </tr>
          </tbody>
        </table>
      </details>
    </td>
  </tr>
</table>

Current release info
====================

| Name | Downloads | Version | Platforms |
| --- | --- | --- | --- |
| [![Conda Recipe](https://img.shields.io/badge/recipe-libtiledbsoma-green.svg)](https://anaconda.org/tiledb/libtiledbsoma) | [![Conda Downloads](https://img.shields.io/conda/dn/tiledb/libtiledbsoma.svg)](https://anaconda.org/tiledb/libtiledbsoma) | [![Conda Version](https://img.shields.io/conda/vn/tiledb/libtiledbsoma.svg)](https://anaconda.org/tiledb/libtiledbsoma) | [![Conda Platforms](https://img.shields.io/conda/pn/tiledb/libtiledbsoma.svg)](https://anaconda.org/tiledb/libtiledbsoma) |
| [![Conda Recipe](https://img.shields.io/badge/recipe-tiledbsoma--py-green.svg)](https://anaconda.org/tiledb/tiledbsoma-py) | [![Conda Downloads](https://img.shields.io/conda/dn/tiledb/tiledbsoma-py.svg)](https://anaconda.org/tiledb/tiledbsoma-py) | [![Conda Version](https://img.shields.io/conda/vn/tiledb/tiledbsoma-py.svg)](https://anaconda.org/tiledb/tiledbsoma-py) | [![Conda Platforms](https://img.shields.io/conda/pn/tiledb/tiledbsoma-py.svg)](https://anaconda.org/tiledb/tiledbsoma-py) |

Installing tiledbsoma
=====================

Installing `tiledbsoma` from the `tiledb` channel can be achieved by adding `tiledb` to your channels with:

```
conda config --add channels tiledb
conda config --set channel_priority strict
```

Once the `tiledb` channel has been enabled, `libtiledbsoma, tiledbsoma-py` can be installed with `conda`:

```
conda install libtiledbsoma tiledbsoma-py
```

or with `mamba`:

```
mamba install libtiledbsoma tiledbsoma-py
```

It is possible to list all of the versions of `libtiledbsoma` available on your platform with `conda`:

```
conda search libtiledbsoma --channel tiledb
```

or with `mamba`:

```
mamba search libtiledbsoma --channel tiledb
```

Alternatively, `mamba repoquery` may provide more information:

```
# Search all versions available on your platform:
mamba repoquery search libtiledbsoma --channel tiledb

# List packages depending on `libtiledbsoma`:
mamba repoquery whoneeds libtiledbsoma --channel tiledb

# List dependencies of `libtiledbsoma`:
mamba repoquery depends libtiledbsoma --channel tiledb
```




Updating tiledbsoma-feedstock
=============================

If you would like to improve the tiledbsoma recipe or build a new
package version, please fork this repository and submit a PR. Upon submission,
your changes will be run on the appropriate platforms to give the reviewer an
opportunity to confirm that the changes result in a successful build. Once
merged, the recipe will be re-built and uploaded automatically to the
`tiledb` channel, whereupon the built conda packages will be available for
everybody to install and use from the `tiledb` channel.
Note that all branches in the TileDB-Inc/tiledbsoma-feedstock are
immediately built and any created packages are uploaded, so PRs should be based
on branches in forks and branches in the main repository should only be used to
build distinct package versions.

In order to produce a uniquely identifiable distribution:
 * If the version of a package **is not** being increased, please add or increase
   the [``build/number``](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-number-and-string).
 * If the version of a package **is** being increased, please remember to return
   the [``build/number``](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-number-and-string)
   back to 0.

Feedstock Maintainers
=====================

* [@gspowley](https://github.com/gspowley/)
* [@johnkerl](https://github.com/johnkerl/)
* [@mlin](https://github.com/mlin/)
* [@shelnutt2](https://github.com/shelnutt2/)

