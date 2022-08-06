#!/bin/bash

source scripts/env.sh

function build_llvm ()
{
    mkdir -p "${LLVM_BUILD_DIR}"
    cd "${LLVM_BUILD_DIR}"
    cmake \
        -DLLVM_USE_LINKER="gold" \
        -DCMAKE_BUILD_TYPE="Debug" \
        -DLLVM_ENABLE_PROJECTS="clang" \
        -DCMAKE_CROSSCOMPILING=True \
        -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
        -DLLVM_ENABLE_ASSERTIONS=ON \
        -DLLVM_TARGETS_TO_BUILD="RISCV" \
        -DLLVM_TARGET_ARCH="riscv64" \
        -DLLVM_DEFAULT_TARGET_TRIPLE="riscv64-unknown-linux-gnu" \
        -DDEFAULT_SYSROOT="${INSTALL_DIR}/sysroot" \
        -DGCC_INSTALL_PREFIX="${INSTALL_DIR}" \
        "${LLVM_SRC_DIR}/llvm"
    set -e
    make -j${CPU_NUM}
    make install -j${CPU_NUM}
}


