#!/bin/bash

print_help () 
{
  echo "Usage: mount_user_nfs.sh <user name> <path in /tank/work/dev/share/nfs/<user name>/ where riscv_sanitizers are>"
  exit 1
}

if [ $# -ne 2 ]
  then
    print_help
fi

USER_NAME=$1
USER_PATH=$2

export RISCV_SNT_ROOT=/tank/work/dev/share/nfs/${USER_NAME}/${USER_PATH}/
export PATH="$PATH:$RISCV_SNT_ROOT/install_native/sysroot/bin"
mkdir -p "$RISCV_SNT_ROOT"
mount.nfs neptune:$RISCV_SNT_ROOT $RISCV_SNT_ROOT
cp $RISCV_SNT_ROOT/install_native/sysroot/bin/ldd /usr/bin
ln -s /bin/bash /usr/bin/bash
