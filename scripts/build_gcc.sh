#!/bin/bash

source scripts/env.sh

function build_gcc ()
{
    mkdir -p "${GCC_BUILD_DIR}"

    #prepare headers
    cd "${LINUX_SRC_DIR}"
    mkdir -p "${GCC_BUILD_DIR}/linux-headers"
    make headers_install ARCH=riscv INSTALL_HDR_PATH=${GCC_BUILD_DIR}/linux-headers

    cd "${GCC_BUILD_DIR}"
    ${GCC_SRC_DIR}/configure --prefix="${INSTALL_DIR}" --with-arch=${RISCV_ISA_TARGET} --with-linux-headers-src=${GCC_BUILD_DIR}/linux-headers/include
    set -e
    make linux -j${CPU_NUM}
}

