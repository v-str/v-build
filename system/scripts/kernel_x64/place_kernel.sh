#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
PKG_COUNTER=1

function msg(){ printf "${NC}$1 $2${NC}\n" ; }
function msg_green(){ printf "\n${NC}$1 ${GREEN}$2${NC}\n" ; }
function msg_red(){ printf "\n${NC}$1 ${RED}$2${NC}\n" ; }

if [ ! -d "${V_BUILD_TREE_X86_64}" ]; then
	msg_red "\$V_BUILD_TREE" "do not exist!"
	exit 1
fi

if [ ! -d "${V_BUILD_KERNEL_X86_64}" ]; then
	msg_red "\$V_BUILD_KERNEL_X86_64" "do not exist!"
	exit 1
else
	cp -r "${V_BUILD_KERNEL_X86_64}" "${V_BUILD_TREE_X86_64}/"
fi

sync

msg_green "copy kernel sources in tree:" "done."

exit 0


