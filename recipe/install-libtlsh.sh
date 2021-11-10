#!/usr/bin/env bash
set -eux

for c in $(find build -name cmake_install.cmake); do
    cat $c
    sed -i "s+/usr/local+${PREFIX}+g" $c
done

cd "${SRC_DIR}/build/release"

make install
