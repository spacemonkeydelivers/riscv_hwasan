#!/bin/bash

source scripts/env.sh

function build_glibc_native ()
{
    #prepare headers
    cd "${LINUX_SRC_DIR}"
    mkdir -p "${GCC_BUILD_DIR}/linux-headers"
    make headers_install ARCH=riscv INSTALL_HDR_PATH=${GCC_NATIVE_BUILD_DIR}/linux-headers

    mkdir -p "${GLIBC_NATIVE_BUILD_DIR}"
    mkdir -p "${INSTALL_NATIVE_DIR}/sysroot"

    cd "${GLIBC_NATIVE_BUILD_DIR}"
    export PATH=$PATH:${INSTALL_DIR}/bin
    export CC=riscv64-unknown-linux-gnu-gcc
    export CXX=riscv64-unknown-linux-gnu-g++
    ${GLIBC_SRC_DIR}/configure --prefix="${INSTALL_NATIVE_DIR}/sysroot" \
                               --host=riscv64-unknown-linux-gnu \
                               --target=riscv64-unknown-linux-gnu \
                               --build=x86_64-pc-linux-gnu \
                               --with-headers=${GCC_NATIVE_BUILD_DIR}/linux-headers/include \
                               --disable-werror --enable-shared --enable-obsolete-rpc \
                               --disable-multilib --enable-kernel=3.0.0 \
                               --libdir=${INSTALL_NATIVE_DIR}/sysroot/usr/lib \
                               libc_cv_slibdir=${INSTALL_NATIVE_DIR}/sysroot/lib \
                               libc_cv_rtlddir=${INSTALL_NATIVE_DIR}/sysroot/lib \
                               --includedir=${INSTALL_NATIVE_DIR}/sysroot/usr/include/
    set -e
    make -j${CPU_NUM}
    make install
    # fix abs path in libc.so
    sed -i "s@${INSTALL_NATIVE_DIR}/sysroot@@g" ${INSTALL_NATIVE_DIR}/sysroot/usr/lib/libc.so
}

