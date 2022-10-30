#!/usr/bin/env bash
set -eux
export LIBRARY_PATH="${PREFIX}/lib"
export LD_LIBRARY_PATH="${PREFIX}/lib"
cd "${SRC_DIR}/py_ext"

$PYTHON setup.py bdist_wheel --dist-dir=dist
$PYTHON -m pip install --find-links=dist --no-deps --ignore-installed --no-cache-dir -vvv tlsh
