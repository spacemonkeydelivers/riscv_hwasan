#!/bin/bash

source scripts/env.sh

function build_libatomic_native ()
{
    mkdir -p "${LIBATOMIC_NATIVE_BUILD_DIR}"

    cd "${LIBATOMIC_NATIVE_BUILD_DIR}"
    export PATH=$PATH:${INSTALL_DIR}/bin
    ${LIBATOMIC_SRC_DIR}/configure --srcdir=${LIBATOMIC_SRC_DIR} \
                                   --cache-file=./config.cache \
                                   --with-cross-host=x86_64-pc-linux-gnu \
                                   --prefix=${INSTALL_NATIVE_DIR}/sysroot/ \
                                   --with-sysroot=${INSTALL_NATIVE_DIR}/sysroot/ \
                                   --with-system-zlib --enable-shared --enable-tls --disable-libmudflap \
                                   --disable-libssp --disable-libquadmath --disable-nls --disable-bootstrap \
                                   --disable-multilib --with-abi=lp64d --with-arch=rv64gc --with-tune=rocket \
                                   --enable-languages=c,c++,fortran,lto \
                                   --program-transform-name='s/^/riscv64-unknown-linux-gnu-/' --disable-option-checking \
                                   --with-target-subdir=riscv64-unknown-linux-gnu \
                                   --build=x86_64-pc-linux-gnu \
                                   --host=riscv64-unknown-linux-gnu \
                                   --target=riscv64-unknown-linux-gnu

    set -e
    make  -j${CPU_NUM}
    make install
}

