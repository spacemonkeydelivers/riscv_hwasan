#!/bin/bash

ROOT_DIR="$(pwd)"

source scripts/env.sh

git submodule update --init --recursive

# switch QEMU to proper branch
cd ${QEMU_SRC_DIR}
git checkout zjpm_0.5.4
git submodule init
git submodule update
cd ${ROOT_DIR}

# switch GCC toolchain to proper branch
cd ${GCC_SRC_DIR}
git checkout master
cd ${ROOT_DIR}

# switch GCC toolchain to proper branch
cd ${GCC_NATIVE_SRC_DIR}
git checkout releases/gcc-13
cd ${ROOT_DIR}

# switch Linux to proper branch
cd ${LINUX_SRC_DIR}
git checkout zjpm_0.5.4
cd ${ROOT_DIR}

# switch LLVM to proper branch
cd ${LLVM_SRC_DIR}
git checkout main
cd ${ROOT_DIR}

# switch LLVM to proper branch
cd ${BUILDROOT_SRC_DIR}
git checkout 5f966716569ad0b133ae40662d3f5817e09fa313
cd ${ROOT_DIR}
