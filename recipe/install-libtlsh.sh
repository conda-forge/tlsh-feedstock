#!/usr/bin/env bash
set -eux

for c in $(find build -name cmake_install.cmake); do
    python -c "from pathlib import Path; c= Path('$c'); c.write_text(c.read_text().replace('/usr/local', '$PREFIX'))"
done

cd "${SRC_DIR}/build/release"

make install
