#!/bin/bash
set -x

source scripts/env.sh

function build_asan_tests ()
{
  mkdir -p "${ASANTEST_BUILD_DIR}"
  cd "${ASANTEST_BUILD_DIR}"

  COMPILERRT_SRC_DIR="${SRC_DIR}/llvm-project/compiler-rt"

  CC="${INSTALL_DIR}/bin/clang"
  CXX="${INSTALL_DIR}/bin/clang++"

  PATH="${INSTALL_DIR}/bin/:$PATH" \
      CC="${INSTALL_DIR}/bin/clang" \
      CXX="${INSTALL_DIR}/bin/clang++" \
    cmake \
    -DCMAKE_C_FLAGS="  -target ${RISCV_GCC_TARGET} -B ${INSTALL_DIR}/lib/gcc/${RISCV_GCC_TARGET}/9.2.0 -O0 -g" \
    -DCMAKE_CXX_FLAGS="-target ${RISCV_GCC_TARGET} -B ${INSTALL_DIR}/lib/gcc/${RISCV_GCC_TARGET}/9.2.0 -O0 -g" \
    -DCOMPILER_RT_DEBUG=ON \
    -DCOMPILER_RT_INCLUDE_TESTS=ON \
    -DLLVM_CONFIG_PATH="${INSTALL_DIR}/bin/llvm-config" \
    -DCMAKE_INSTALL_PREFIX="${INSTALL_DIR}/lib/clang/${LLVM_VERSION}" \
       "${COMPILERRT_SRC_DIR}"

  set -e
  # CPU_NUM=1
  make AsanUnitTests VERBOSE=1  -j${CPU_NUM} -k
  make SanitizerUnitTests VERBOSE=1  -j${CPU_NUM} -k

  if [[ ! -z "${ASAN_TESTS_DESTINATION}" ]]; then
    TESTS_LOCATION="${ASANTEST_BUILD_DIR}/lib/asan/tests"
    echo "tests will be additionaly  copied to ${TESTS_LOCATION}"
    cp "${TESTS_LOCATION}/default/Asan-riscv64-calls-Noinst-Test" "${ASAN_TESTS_DESTINATION}"
    cp "${TESTS_LOCATION}/default/Asan-riscv64-inline-Noinst-Test" "${ASAN_TESTS_DESTINATION}"
    cp "${ASANTEST_BUILD_DIR}/lib/sanitizer_common/tests/Sanitizer-riscv64-Test" "${ASAN_TESTS_DESTINATION}"
    # this one was an additional testsuite which is excessive, disabled for good
    #cp "${TESTS_LOCATION}/default/Asan-Common-riscv64-Noinst-Test" "${ASAN_TESTS_DESTINATION}"
  else
    echo "tests are not copyied as ASAN_TESTS_DESTINATION is not set"
  fi

  echo "AsanUnitTests are ready, see ${ASANTEST_BUILD_DIR}/lib/asan/tests/default"
}

