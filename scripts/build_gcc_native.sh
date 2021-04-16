#!/bin/bash

source scripts/env.sh

function build_gcc_native ()
{
    mkdir -p "${GCC_NATIVE_BUILD_DIR}"

#    #prepare headers
    cd "${LINUX_SRC_DIR}"
#    mkdir -p "${GCC_BUILD_DIR}/linux-headers"
    make headers_install ARCH=riscv INSTALL_HDR_PATH=${INSTALL_NATIVE_DIR}/sysroot
    cd "${GCC_NATIVE_SRC_DIR}"
    ${GCC_NATIVE_SRC_DIR}/contrib/download_prerequisites

    cd "${GCC_NATIVE_BUILD_DIR}"
    export PATH=$PATH:${INSTALL_DIR}/bin
    ${GCC_NATIVE_SRC_DIR}/configure --host=riscv64-unknown-linux-gnu \
                                              --build=x86_64-pc-linux-gnu \
                                              --target=riscv64-unknown-linux-gnu \
                                              --prefix=${INSTALL_NATIVE_DIR}/sysroot \
                                              --with-sysroot=${INSTALL_NATIVE_DIR}/sysroot/ \
                                              --enable-shared --enable-threads --disable-libmudflap --disable-libssp \
                                              --disable-libgomp --disable-libstdcxx-pch --with-gnu-as --with-gnu-ld \
                                              --enable-languages=c,c++ --enable-symvers=gnu --enable-__cxa_atexit \
                                              --disable-nls --disable-multilib
    set -e
    make  -j${CPU_NUM}
    make install
}

