#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

FINAL_TREE="final.tree"

function msg(){ printf "${NC}$1 $2${NC}\n" ; }
function msg_green(){ printf "\n${NC}$1 ${GREEN}$2${NC}\n\n" ; }
function msg_red(){ printf "\n${NC}$1 ${RED}$2${NC}\n\n" ; }

if [ ! -d "${V_BUILD_DIR}/${FINAL_TREE}" ]; then
	msg_red "vkfs mounting:" " final.tree do not exist!"
	exit 1
fi

msg_green "preparing:" "Virtual Kernel File System"

sudo mkdir -pv ${V_BUILD_DIR}/${FINAL_TREE}/{dev,proc,sys,run}

sudo mknod -m 600 ${V_BUILD_DIR}/${FINAL_TREE}/dev/console c 5 1
sudo mknod -m 666 ${V_BUILD_DIR}/${FINAL_TREE}/dev/null c 1 3

msg_green "stage:" "mounting"

sudo mount -v --bind /dev ${V_BUILD_DIR}/${FINAL_TREE}/dev
sudo mount -v --bind /dev/pts ${V_BUILD_DIR}/${FINAL_TREE}/dev/pts
sudo mount -vt proc proc ${V_BUILD_DIR}/${FINAL_TREE}/proc
sudo mount -vt sysfs sysfs ${V_BUILD_DIR}/${FINAL_TREE}/sys
sudo mount -vt tmpfs tmpfs ${V_BUILD_DIR}/${FINAL_TREE}/run

if [ -h ${V_BUILD_DIR}/${FINAL_TREE}/dev/shm ]; then
  sudo mkdir -pv \
  ${V_BUILD_DIR}/${FINAL_TREE}/$(readlink ${V_BUILD_DIR}/${FINAL_TREE}/dev/shm)
fi

msg_green "status:" "done"

exit 0


