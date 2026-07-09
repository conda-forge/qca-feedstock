#!/usr/bin/env bash
if [ -d "build" ]; then
    rm -rf build
fi
[[ ! -d build ]] && mkdir build/
cd build/

# For cross-compilation from x86_64 to arm64
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" == "1" ]]; then
    # Use the build platform's moc
    QT_HOST_PATH="$BUILD_PREFIX"
else
    QT_HOST_PATH="$PREFIX"
fi

# "default" channel "qt" creates "plugins" in root of environment
# Need to put "qca" plugin -- including qca-ossl -- in that folder
cmake ${CMAKE_ARGS} \
    -G Ninja \
    -D CMAKE_INSTALL_PREFIX=${PREFIX} \
    -D USE_RELATIVE_PATHS=FALSE \
    -D QCA_PLUGINS_INSTALL_DIR=${PREFIX}/lib/qt6/plugins \
    -D CMAKE_PREFIX_PATH=${PREFIX} \
    -D CMAKE_BUILD_TYPE=Release \
    -D BUILD_WITH_QT6=ON \
    -D QCA_SUFFIX=qt6 \
    -D BUILD_TESTS=OFF \
    -D QT_HOST_PATH=${QT_HOST_PATH} \
    ${SRC_DIR}

ninja -j${CPU_COUNT}
# No make check
ninja install
