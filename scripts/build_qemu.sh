#!/bin/bash

source scripts/env.sh

function build_qemu ()
{
    mkdir -p "${QEMU_BUILD_DIR}"
    cd "${QEMU_BUILD_DIR}"
#    ${QEMU_SRC_DIR}/configure --prefix=${INSTALL_DIR} --target-list=riscv64-softmmu,riscv64-linux-user --enable-debug
    ${QEMU_SRC_DIR}/configure --prefix=${INSTALL_DIR} --target-list=riscv64-softmmu,riscv64-linux-user
    set -e
    make -j${CPU_NUM}
    make install
}
