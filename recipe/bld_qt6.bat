if exist "build" (
    rd /s /q "build"
)
mkdir build
cd build

:: "default" channel "qt" creates "plugins" in root of environment
:: Need to put "qca" plugin -- including qca-ossl -- in that folder
cmake -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DUSE_RELATIVE_PATHS=FALSE ^
    -DQCA_PLUGINS_INSTALL_DIR=%LIBRARY_PREFIX%/lib/qt6/plugins ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -G "Ninja" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DHAVE_OPENSSL_SHA0=False ^
    -DBUILD_WITH_QT6=ON ^
    -DQCA_SUFFIX=qt6 ^
    ..
if errorlevel 1 exit /B 1

ninja
if errorlevel 1 exit /B 1
:: No make check
ninja install
if errorlevel 1 exit /B 1