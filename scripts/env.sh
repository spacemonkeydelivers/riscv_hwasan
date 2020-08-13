#!/bin/bash

SRC_DIR="${ROOT_DIR}/src"
BUILD_DIR="${ROOT_DIR}/build"
INSTALL_DIR="${ROOT_DIR}/install"
LLVM_VERSION="10.0.0"
RISCV_GCC_TARGET=riscv64-unknown-linux-gnu
RISCV_ISA_TARGET=rv64gc

QEMU_SRC_DIR="${SRC_DIR}/qemu"
GCC_SRC_DIR="${SRC_DIR}/riscv-gnu-toolchain"
GLIBC_SRC_DIR="${GCC_SRC_DIR}/riscv-glibc"
BINUTILS_SRC_DIR="${GCC_SRC_DIR}/riscv-binutils"
LIBATOMIC_SRC_DIR="${GCC_SRC_DIR}/riscv-gcc/libatomic"
BUILDROOT_SRC_DIR="${SRC_DIR}/buildroot"
LINUX_SRC_DIR="${SRC_DIR}/linux"
LLVM_SRC_DIR="${SRC_DIR}/llvm-project"
COMPILERRT_SRC_DIR="${SRC_DIR}/llvm-project/compiler-rt"
PK_SRC_DIR="${SRC_DIR}/riscv-pk"

QEMU_BUILD_DIR="${BUILD_DIR}/qemu"
GCC_BUILD_DIR="${BUILD_DIR}/riscv-gnu-toolchain"
BUILDROOT_BUILD_DIR="${BUILDROOT_SRC_DIR}"
LINUX_BUILD_DIR="${LINUX_SRC_DIR}"
LLVM_BUILD_DIR="${BUILD_DIR}/llvm-project"
COMPILERRT_BUILD_DIR="${BUILD_DIR}/compiler-rt"
PK_BUILD_DIR="${BUILD_DIR}/risc-pk"
ASANTEST_BUILD_DIR="${BUILD_DIR}/asan-tests"

CPU_NUM=${CPU_NUM:-8}
