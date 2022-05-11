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

msg_green "preparing:" "Virtual Kernel File System"

sudo mkdir -pv ${V_BUILD_TREE_X86_64}/{dev,proc,sys,run}

sudo mknod -m 600 ${V_BUILD_TREE_X86_64}/dev/console c 5 1
sudo mknod -m 666 ${V_BUILD_TREE_X86_64}/dev/null c 1 3

msg_green "stage:" "mounting"

sudo mount -v --bind /dev ${V_BUILD_TREE_X86_64}/dev
sudo mount -v --bind /dev/pts ${V_BUILD_TREE_X86_64}/dev/pts
sudo mount -vt proc proc ${V_BUILD_TREE_X86_64}/proc
sudo mount -vt sysfs sysfs ${V_BUILD_TREE_X86_64}/sys
sudo mount -vt tmpfs tmpfs ${V_BUILD_TREE_X86_64}/run

if [ -h ${V_BUILD_TREE_X86_64}/dev/shm ]; then
  sudo mkdir -pv ${V_BUILD_TREE_X86_64}/$(readlink ${V_BUILD_TREE_X86_64}/dev/shm)
fi

msg_green "status:" "done"

exit 0


