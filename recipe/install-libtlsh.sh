#!/usr/bin/env bash
set -eux

cd "${SRC_DIR}/build/release"

for c in $(find -name cmake_install.cmake); do
    cat $c
    sed -i "s+/usr/local+${PREFIX}+g" $c
done

make install
