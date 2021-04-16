#!/bin/bash

source scripts/env.sh

function build_binutils_native ()
{
    mkdir -p "${BINUTILS_NATIVE_BUILD_DIR}"

    cd "${BINUTILS_NATIVE_BUILD_DIR}"
    export PATH=$PATH:${INSTALL_DIR}/bin
    ${BINUTILS_SRC_DIR}/configure --target=riscv64-unknown-linux-gnu \
                                  --host=riscv64-unknown-linux-gnu \
                                  --build=x86_64-pc-linux-gnu \
                                  --prefix=${INSTALL_NATIVE_DIR}/sysroot/ \
                                  --with-sysroot=${INSTALL_NATIVE_DIR}/sysroot \
                                  --disable-multilib --disable-werror --disable-nls --with-expat=yes \
                                  --disable-gdb --disable-sim --disable-libdecnumber --disable-readline
    set -e
    make  -j${CPU_NUM}
    make install
}

