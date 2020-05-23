#!/bin/bash

source scripts/env.sh

function build_buildroot ()
{
    cd "${BUILDROOT_BUILD_DIR}"
    PATH="$PATH:${INSTALL_DIR}/bin/"

    set -e

    make qemu_riscv64_virt_defconfig
    cp "${SRC_DIR}/config/buildroot.config" .config
    cp -r "${SRC_DIR}/config/riscv/" ./board/
    make oldconfig
    make -j${CPU_NUM}
}
