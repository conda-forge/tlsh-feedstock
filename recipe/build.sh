#!/usr/bin/env bash
set -eux

mkdir -p build/release

pushd build/release
    cmake
        $CMAKE_ARGS \
        -GNinja \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=${PREFIX} \
        -DCMAKE_INSTALL_RPATH=${PREFIX}/lib \
        -DCMAKE_EXE_LINKER_FLAGS="-Wl,-rpath,${PREFIX}/lib -L${PREFIX}/lib" \
        -DCMAKE_CXX_FLAGS="${CXXFLAGS} ${CPPFLAGS}" \
        -DTLSH_SHARED_LIBRARY=1 \
        -DTLSH_CHECKSUM_1B=1 \
        ../..
popd

make -C build DESTDIR="${PREFIX}" install
