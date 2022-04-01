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

msg_green "preparing:" "unmounting Virtual Kernel File System"

if [ -e "${V_BUILD_DIR}/.vkfs_mounted" ]; then
	sudo umount -v ${V_BUILD_TREE_X86_64}/dev/pts
	sudo umount -v ${V_BUILD_TREE_X86_64}/{sys,proc,run}
	sudo umount -v ${V_BUILD_TREE_X86_64}/dev
	rm ${V_BUILD_DIR}/.vkfs_mounted
fi

msg_green "status:" "done"

exit 0


