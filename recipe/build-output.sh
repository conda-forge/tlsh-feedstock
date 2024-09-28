#!/usr/bin/env bash
set -eux

if [[ "${PKG_NAME}" == "libtlsh" ]]; then
    mkdir -p "${PREFIX}/lib" "${PREFIX}/include"
    cp -r lib "${PREFIX}/lib/tlsh"
    cp -r include/* "${PREFIX}/include/"
elif [[ "${PKG_NAME}" == "tlsh-tools" ]]; then
    mkdir -p "${PREFIX}/bin"
    cp "bin/tlsh_unittest" "${PREFIX}/bin/"
    ln -s "${PREFIX}/bin/tlsh_unittest" "${PREFIX}/bin/tlsh"
elif [[ "${PKG_NAME}" == "python-tlsh" ]]; then
    export LIBRARY_PATH="${PREFIX}/lib"
    export LD_LIBRARY_PATH="${PREFIX}/lib"

    cd py_ext

    "${PYTHON}" setup.py bdist_wheel \
        --dist-dir=dist
    "${PYTHON}" -m pip install \
        --find-links=dist \
        --no-deps \
        --ignore-installed \
        --no-cache-dir \
        -vvv \
        tlsh
fi
