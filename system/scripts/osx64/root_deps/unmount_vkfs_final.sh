#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

FINAL_TREE="final.tree"

function msg(){ printf "${NC}$1 $2${NC}\n" ; }
function msg_green(){ printf "\n${NC}$1 ${GREEN}$2${NC}\n\n" ; }
function msg_red(){ printf "\n${NC}$1 ${RED}$2${NC}\n\n" ; }

if [ ! -d "${V_BUILD_DIR}/${FINAL_TREE}" ]; then
	msg_red "finale.tree" "do not exist!"
	exit 1
fi

msg_green "preparing:" "unmounting Virtual Kernel File System"

sudo umount -vl ${V_BUILD_DIR}/${FINAL_TREE}/dev/pts
sudo umount -vl ${V_BUILD_DIR}/${FINAL_TREE}/{sys,proc,run}
sudo umount -vl ${V_BUILD_DIR}/${FINAL_TREE}/dev

msg_green "status:" "done"

exit 0


