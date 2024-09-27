#!/usr/bin/env bash

mkdir -p build/release
cd build/release
cmake
    $CHECKSUM \
    $CMAKE_ARGS \
    -GNinja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DCMAKE_INSTALL_RPATH=${PREFIX}/lib \
    -DCMAKE_EXE_LINKER_FLAGS="-Wl,-rpath,${PREFIX}/lib -L${PREFIX}/lib" \
    -DCMAKE_CXX_FLAGS="${CXXFLAGS} ${CPPFLAGS}"
    -DTLSH_SHARED_LIBRARY=1 \
    ../..

cd ../..

make -C build DESTDIR="${PREFIX}" install
