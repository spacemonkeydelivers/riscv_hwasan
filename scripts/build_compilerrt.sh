#!/bin/bash

source scripts/env.sh

function build_compilerrt ()
{
    mkdir -p "${COMPILERRT_BUILD_DIR}"
    cd "${COMPILERRT_BUILD_DIR}"

    PATH="${INSTALL_DIR}/bin/:$PATH" \
      CC="${INSTALL_DIR}/bin/clang" \
      CXX="${INSTALL_DIR}/bin/clang++" \
      cmake \
        -DCMAKE_C_FLAGS="  -target ${RISCV_GCC_TARGET} -B ${INSTALL_DIR}/lib/gcc/${RISCV_GCC_TARGET}/${GCC_VERSION} -O0 -g" \
        -DCMAKE_CXX_FLAGS="-target ${RISCV_GCC_TARGET} -B ${INSTALL_DIR}/lib/gcc/${RISCV_GCC_TARGET}/${GCC_VERSION} -O0 -g" \
        -DLLVM_CONFIG_PATH=${INSTALL_DIR}/bin/llvm-config \
        -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}/lib/clang/${LLVM_VERSION}/ \
        ${COMPILERRT_SRC_DIR}

    set -e
    PATH="${INSTALL_DIR}/bin/:$PATH" \
        CC="${INSTALL_DIR}/bin/clang" CXX="${INSTALL_DIR}/bin/clang++" \
    make -j${CPU_NUM}
    make install
}

