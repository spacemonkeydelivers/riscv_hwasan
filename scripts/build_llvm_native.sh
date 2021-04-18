#!/bin/bash

source scripts/env.sh

function build_llvm_native ()
{
    mkdir -p "${LLVM_NATIVE_BUILD_DIR}"
    cd "${LLVM_NATIVE_BUILD_DIR}"
    export PATH=$PATH:${INSTALL_DIR}/bin
    export CC=riscv64-unknown-linux-gnu-gcc
    export CC_FOR_BUILD=riscv64-unknown-linux-gnu-gcc
    export CXX=riscv64-unknown-linux-gnu-g++
    export CXX_FOR_BUILD=riscv64-unknown-linux-gnu-g++
    export AR=riscv64-unknown-linux-gnu-ar
    export AR_FOR_BUILD=riscv64-unknown-linux-gnu-ar
    export AS=riscv64-unknown-linux-gnu-as
    export AS_FOR_BUILD=riscv64-unknown-linux-gnu-as
    export NM=riscv64-unknown-linux-gnu-nm
    export NM_FOR_BUILD=riscv64-unknown-linux-gnu-nm
    export LD=riscv64-unknown-linux-gnu-ld
    export LD_FOR_BUILD=riscv64-unknown-linux-gnu-ld
    export LD_LIBRARY_PATH="${BUILDROOT_BUILD_DIR}/output/build/libzlib-1.2.11/":"${INSTALL_DIR}/sysroot/lib/usr/lib":"${INSTALL_DIR}/sysroot/lib/":${LD_LIBRARY_PATH}
    export QEMU_LD_PREFIX="${INSTALL_NATIVE_DIR}/sysroot"
    cmake \
        -DCMAKE_BUILD_TYPE="Debug" \
        -DLLVM_ENABLE_PROJECTS="clang;compiler-rt;lld" \
        -DCMAKE_INSTALL_PREFIX=${INSTALL_NATIVE_DIR}/sysroot \
        -DLLVM_ENABLE_ASSERTIONS=ON \
        -DLLVM_INSTALL_UTILS=ON \
        -DLLVM_TARGETS_TO_BUILD="RISCV" \
        -DLLVM_TARGET_ARCH="riscv64" \
        -DLLVM_DEFAULT_TARGET_TRIPLE="riscv64-unknown-linux-gnu" \
        -DDEFAULT_SYSROOT="${INSTALL_NATIVE_DIR}/sysroot" \
        -DGCC_INSTALL_PREFIX="${INSTALL_NATIVE_DIR}/sysroot" \
        "${LLVM_SRC_DIR}/llvm"
    set -e
    make -j16
    make install -j16
}


