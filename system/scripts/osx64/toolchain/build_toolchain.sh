#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

function msg(){ printf "${NC}$1 $2${NC}\n" ; }
function msg_green(){ printf "\n${NC}$1 ${GREEN}$2${NC}\n\n" ; }
function msg_red(){ printf "\n${NC}$1 ${RED}$2${NC}\n\n" ; }

if [ -z ${V_BUILD_KERNEL_X86_64} ]; then
	msg_red "Error, kernel path not found:" "\$V_BUILD_KERNEL_X86_64"
	msg "Run: make help\n"
	exit 1
fi


if [ ! -d "${V_BUILD_TREE_X86_64}" ]; then
	msg_red "\$V_BUILD_TREE" "do not exist!"
	exit 1
fi

OSXDIR="${V_BUILD_SYSTEM}/scripts/osx64"

if [ ! -d "$OSXDIR" ]; then
	msg_red "Failure to find directory: " "$OSXDIR"
	exit 1
fi

#${OSXDIR}/toolchain/make_binutils_x86_64_pass_1.sh
#${OSXDIR}/toolchain/make_gcc_x86_64_pass_1.sh
#${OSXDIR}/toolchain/install_kernel_headers.sh
#${OSXDIR}/toolchain/make_glibc_x86_64.sh
#${OSXDIR}/toolchain/gcc_mkheaders.sh
#${OSXDIR}/toolchain/make_libstdcpp_x86_64_pass_1.sh
#${OSXDIR}/toolchain/make_sys_utils.sh
#${OSXDIR}/toolchain/make_binutils_x86_64_pass_2.sh
#${OSXDIR}/toolchain/make_gcc_x86_64_pass_2.sh
#${OSXDIR}/root_deps/chown_tree.sh
${OSXDIR}/root_deps/chroot-1-finalize.sh



exit 0


