#!/bin/bash
set -ue

# Reliable way to get full path to script
# http://stackoverflow.com/questions/4774054/
readonly SCRIPTPATH=$(cd $(dirname ${BASH_SOURCE[0]}) > /dev/null; pwd -P )

readonly TESTDIR=${TESTDIR:-"$SCRIPTPATH"}
readonly PLUGIN=${PLUGIN:-"$SCRIPTPATH/../gcc-plugin/scen.so"}

# Error values
readonly E_FILE_NOT_FOUND=1

# Utility functions
error() {
  printf >&2 '%b\n' "$(basename ${0}): ${@:2}"
  exit ${1}
}

testname=$1
shift

[ -e "${TESTDIR}/${testname}.c" ] || error $E_FILE_NOT_FOUND "${testname}.c does not exist"

make gcc-plugin/scen.so
mkdir -p "${TESTDIR}/${testname}"
pushd "${TESTDIR}/${testname}"
"${RISCV}"/bin/riscv32-unknown-elf-gcc $* -mxscen -da -fdump-tree-all -S -fplugin="${PLUGIN}" -o "${testname}.s" "${TESTDIR}/${testname}.c"
popd
make -B $(basename ${TESTDIR})/${testname}.o
