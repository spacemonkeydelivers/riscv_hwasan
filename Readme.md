# RISCV HWASAN

This reporistory is the root of riscv-sanitizers project. It contains
guidelines, documentation and includes all relevant repositories as a
submodules.

The main purpose is to provide instructions regarding the general development
process and to provide releases.

## How to obtain sources
````
 git clone https://github.com/gattaca-lab/riscv_hwasan
 cd riscv_hwasan
 ./setup_git
````

## How to build everything

To build project:

```
./build.sh all
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

