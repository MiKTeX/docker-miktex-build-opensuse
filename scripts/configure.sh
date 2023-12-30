#!/bin/sh
package_revision=${1-1}
cd /miktex/build
CC=/usr/bin/gcc-13 CXX=/usr/bin/g++-13 cmake \
    -DMIKTEX_PACKAGE_REVISION=${package_revision} \
    -DMIKTEX_LINUX_DIST=opensuse \
    -DMIKTEX_LINUX_DIST_VERSION=15 \
    -DUSE_SYSTEM_HARFBUZZ=FALSE \
    -DUSE_SYSTEM_HARFBUZZ_ICU=FALSE \
    -DUSE_SYSTEM_LOG4CXX=FALSE \
    -DUSE_SYSTEM_POPPLER=FALSE \
    -DUSE_SYSTEM_POPPLER_QT5=FALSE \
    -DWITH_UI_QT=TRUE \
    /miktex/source
