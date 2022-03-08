#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

function msg(){ printf "${NC}$1 $2${NC}\n" ; }
function msg_green(){ printf "\n${NC}$1 ${GREEN}$2${NC}\n\n" ; }
function msg_red(){ printf "\n${NC}$1 ${RED}$2${NC}\n\n" ; }

if [ ! -d "${V_BUILD_TREE_X86_64}" ]; then
	msg_red "\$V_BUILD_TREE" "do not exist!"
	exit 1
fi

linux=`ls "${V_BUILD_TREE_X86_64}/" | grep linux`

cp -v "${V_BUILD_TREE_X86_64}/$linux/arch/x86/boot/bzImage" \
	"${V_BUILD_SYSTEM}/emulation/bzImage"

sync

exit 0


