#!/bin/bash

source scripts/env.sh

function build_buildroot ()
{
    cd "${BUILDROOT_BUILD_DIR}"
    PATH="$PATH:${INSTALL_DIR}/bin/"

    set -e

    make qemu_riscv64_virt_defconfig
    cp "${SRC_DIR}/config/buildroot.config" .config
    sed -i -e "s@REPLACEME_INSTALL_PATH@${INSTALL_DIR}@g" .config
    sed -i -e "s@REPLACEME_BUILDROOT_SRC_PATH@${BUILDROOT_SRC_DIR}@g" .config
    cp -r "${SRC_DIR}/config/riscv/" ./board/
    make oldconfig
    make -j${CPU_NUM}
}
