# RISCV HWASAN

This reporistory is the root of riscv-sanitizers project. It contains
guidelines, documentation and includes all relevant repositories as a
submodules.

The main purpose is to provide instructions regarding the general development
process and to provide releases.

## How to obtain sources

```
 git clone https://github.com/spacemonkeydelivers/riscv_hwasan
 cd riscv_hwasan
 # WILL TAKE A WHILE
 ./setup_git
```

## Prerequisites
At least these several packages are required to build the GCC toolchain. On Ubuntu you could install them using following line:

```
sudo apt-get install autoconf automake autotools-dev curl python3 libmpc-dev libmpfr-dev libgmp-dev gawk build-essential bison flex texinfo gperf libtool patchutils bc zlib1g-dev libexpat-dev
```
**NB**: this list might not be complete. If you encounter any issue while building the project, raise an issue and we'll update the list.

## How to build everything

To build project:

```
./build.sh target all
```

## How to compile with clang

Example of compilation string:

```
  ./install/bin/clang <c source> \
    -L ./install/lib/gcc/riscv64-unknown-linux-gnu/9.2.0/ \
    -B ./install/lib/gcc/riscv64-unknown-linux-gnu/9.2.0/
```

## How to run QEMU vm

* **NB**: existing network configuration is tailored for neptune machine only
* Login and password for default image are: **root** and **root** respectively
* command:
```
./run_qemu.sh
login: root
password: root
```

## How to modify rootfs image
* In **src/config/riscv** there are different directories that are copied into the built rootfs image
* If you want to modify anything inside your image, put a modified file into proper directory and it would be copied

