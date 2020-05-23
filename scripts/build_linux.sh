#!/bin/bash

source scripts/env.sh

function build_linux ()
{
    cd "${LINUX_BUILD_DIR}"
    PATH="$PATH:${INSTALL_DIR}/bin/"
    cp "${SRC_DIR}/config/linux.config" .config
    ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- make oldconfig
    ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu- make vmlinux -j${CPU_NUM}
}


