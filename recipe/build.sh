#!/usr/bin/env bash
set -eux

mkdir -p build/release

cd build/release

cmake ../.. \
    $CMAKE_ARGS \
    -GNinja \
    -DBUILD_SHARED_LIBS=ON \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX:PATH=${PREFIX} \
    -DCMAKE_INSTALL_RPATH=${PREFIX}/lib \
    -DCMAKE_EXE_LINKER_FLAGS="-Wl,-rpath,${PREFIX}/lib -L${PREFIX}/lib" \
    -DCMAKE_CXX_FLAGS="${CXXFLAGS} ${CPPFLAGS}" \
    -DTLSH_SHARED_LIBRARY=1

ninja
