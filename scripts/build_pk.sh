#!/bin/bash

source scripts/env.sh

function build_pk ()
{
    mkdir -p "${PK_BUILD_DIR}"
    cd "${PK_BUILD_DIR}"
    PATH="$PATH:${INSTALL_DIR}/bin/"
    ${PK_SRC_DIR}/configure \
      --enable-logo \
      --host=${RISCV_GCC_TARGET} \
      --with-payload=${LINUX_BUILD_DIR}/vmlinux
    set -e
    make ISA=${RISCV_ISA_TARGET} -j${CPU_NUM}
}

