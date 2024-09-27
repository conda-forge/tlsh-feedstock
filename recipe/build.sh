#!/usr/bin/env bash
set -eux


# adapted from https://gitlab.archlinux.org/archlinux/packaging/packages/tlsh/-/blob/main/PKGBUILD

# remove garbage
sed '/set(CMAKE_EXE_LINKER_FLAGS/d' -i CMakeLists.txt
sed '/set(CMAKE_CXX_FLAGS/d' -i CMakeLists.txt
sed 's|TLSH_SHARED_LIBRARY 0|TLSH_SHARED_LIBRARY 1|' -i src/CMakeLists.txt

mkdir -p build

cd build

cmake .. \
    $CMAKE_ARGS \
    -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX} \
    -DCMAKE_INSTALL_RPATH=${PREFIX}/lib \
    -DCMAKE_EXE_LINKER_FLAGS="-Wl,-rpath,${PREFIX}/lib -L${PREFIX}/lib" \
    -DCMAKE_CXX_FLAGS="${CXXFLAGS} ${CPPFLAGS}" \
    -DTLSH_CHECKSUM_1B=1

make
