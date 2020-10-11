#!/bin/bash

ROOT_DIR="$(pwd)"

source scripts/env.sh

git submodule update --init --recursive

# switch QEMU to proper branch
cd ${QEMU_SRC_DIR}
git checkout riscv_pm_qemu_5.1_dev
git submodule init
git submodule update
cd ${ROOT_DIR}

# switch Linux to proper branch
cd ${LINUX_SRC_DIR}
git checkout riscv_pm_5.8_dev
cd ${ROOT_DIR}

# switch LLVM to proper branch
cd ${LLVM_SRC_DIR}
git checkout riscv_hwasan
cd ${ROOT_DIR}

# switch LLVM to proper branch
cd ${BUILDROOT_SRC_DIR}
git checkout 0e09875f0947c32aca19a351123bde0bd9026aff
cd ${ROOT_DIR}
