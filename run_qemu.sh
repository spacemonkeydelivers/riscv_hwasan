#!/bin/bash

# Add monitor to connect to qemu: -monitor unix:<unix socket path>,server,nowait
# Connect to the monitor with: socat -,echo=0,icanon=0 unix-connect:<unix socket path>

# Redirect qemu output to telnet socket instead of stdio with: -serial telnet::<port>,server,nowait
# Connect to telnet socket with telnet localhost <port>

ROOT_DIR="$(pwd)"
MAC=$(echo "$(whoami)| $(pwd)" | md5sum | sed 's/^\(..\)\(..\)\(..\)\(..\)\(..\).*$/02:\1:\2:\3:\4:\5/')

source scripts/env.sh

QEMU_BIN=${INSTALL_DIR}/bin/qemu-system-riscv64

sudo -E ${QEMU_BIN} \
    -nographic \
    -machine virt -cpu rv64,ssnjpm=on \
    -kernel ${LINUX_BUILD_DIR}/arch/riscv/boot/Image \
    -append "root=/dev/vda ro console=ttyS0" \
    -drive file=${BUILDROOT_BUILD_DIR}/output/images/rootfs.ext2,format=raw,id=hd0 \
    -device virtio-blk-device,drive=hd0 \
    -m 1024M \
    -device virtio-net-device,netdev=net0,mac=${MAC} \
    -netdev tap,id=net0,script=./scripts/add_to_bridge.sh,downscript=./scripts/del_from_bridge.sh 
