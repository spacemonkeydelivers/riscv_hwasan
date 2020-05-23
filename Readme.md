# RISCV HWASAN

This reporistory is the root of riscv-sanitizers project. It contains
guidelines, documentation and includes all relevant repositories as a
submodules.

The main purpose is to provide instructions regarding the general development
process and to provide releases.


## TODO (before release)

1. Provide procedure to build GNU toolchain from vanilla sources.
1. Get rid of riscv-pk. It is excessive (and looks bogus).

## How to obtain sources

* git clone https://github.com/gattaca-lab/riscv_hwasan
* cd riscv_hwasan
* ./setup_git

## How to build everything

To build project:

```
./build.sh all
```

## How to compile with clang

Example of compilation string:

```
  ./install/bin/clang \<c source\> \
    -L ./install/lib/gcc/riscv64-unknown-linux-gnu/9.2.0/ \
    -B ./install/lib/gcc/riscv64-unknown-linux-gnu/9.2.0/
```

## How to run QEMU vm

* **NB**: existing network configuration is tailored for neptune machine only
* Login and password for default image are: **root** and **root** respectively
* command:
```
./run_qemu.sh
# For neptune users: /tank/work/dev/share/nfs would already be mounted to /mnt upon boot
```

## How to use existing infra with QEMU vm

* Prebuilt gdb and binutils in this case are located in /mnt/ablue/{riscv_gdb,riscv_binutils}
* Access VM via ssh:
  - set password for root with passwd
  - get ip address of the VM via ifconfig
  - run "ssh root@\<ip addr from 2 step\>"
* To make GDB find sources on the VM, you have to:
  - Copy sources to the NFS share directory
  - Inside GDB run "set substitute-path from to" where **from** is path on
  **host** and **to** is path on **VM** via mounted nfs share
  

## How to modify rootfs image
* In **src/config/riscv** there are different directories that are copied into the built rootfs image
* If you want to modify anything inside your image, put a modified file into proper directory and it would be copied

