#!/usr/bin/env bash

[[ ! -d build ]] && mkdir build/
cd build/

# "default" channel "qt" creates "plugins" in root of environment
# Need to put "qca" plugin -- including qca-ossl -- in that folder
cmake ${CMAKE_ARGS} \
    -D CMAKE_INSTALL_PREFIX=${PREFIX} \
    -D USE_RELATIVE_PATHS=FALSE \
    -D QCA_PLUGINS_INSTALL_DIR=${PREFIX}/plugins \
    -D CMAKE_PREFIX_PATH=${PREFIX} \
    -D CMAKE_BUILD_TYPE=Release \
    ${SRC_DIR}

make -j${CPU_COUNT}
# No make check
make install
