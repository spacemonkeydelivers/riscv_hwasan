#!/bin/bash

ROOT_DIR="$(pwd)"

source scripts/env.sh

git submodule update --init --recursive

# switch QEMU to proper branch
cd ${QEMU_SRC_DIR}
git checkout master
git submodule init
git submodule update
cd ${ROOT_DIR}

# switch GCC toolchain to proper branch
cd ${GCC_SRC_DIR}
git checkout master
cd ${ROOT_DIR}

# switch GCC toolchain to proper branch
cd ${GCC_NATIVE_SRC_DIR}
git checkout releases/gcc-11
cd ${ROOT_DIR}

# switch Linux to proper branch
cd ${LINUX_SRC_DIR}
git checkout riscv_pm_5.8_dev
cd ${ROOT_DIR}

# switch LLVM to proper branch
cd ${LLVM_SRC_DIR}
git checkout hwasan_upstream_llvm15_050722
cd ${ROOT_DIR}

# switch LLVM to proper branch
cd ${BUILDROOT_SRC_DIR}
git checkout 5f966716569ad0b133ae40662d3f5817e09fa313
cd ${ROOT_DIR}
