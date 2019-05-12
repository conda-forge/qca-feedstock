
mkdir build
cd build

:: "default" channel "qt" creates "plugins" in root of environment
:: Need to put "qca" plugin -- including qca-ossl -- in that folder
cmake -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DUSE_RELATIVE_PATHS=TRUE ^
    -DQCA_PLUGINS_INSTALL_DIR=%LIBRARY_PREFIX%/plugins ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -G "NMake Makefiles" ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DHAVE_OPENSSL_SHA0=False ^
    ..
if errorlevel 1 exit /B 1

nmake
if errorlevel 1 exit /B 1
:: No make check
nmake install
if errorlevel 1 exit /B 1
