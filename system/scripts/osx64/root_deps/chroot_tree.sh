#!/bin/bash

# when basic system is complete, chroot using this script
# login without hashing

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

if [ ! -e "${V_BUILD_DIR}/.vkfs_mounted" ]; then
	msg_red "chroot fail:" "first, you need to prepare virtual kernel fs"
	exit 0
fi

msg_green "Copy part scripts into:" "${V_BUILD_TREE_X86_64}"

sudo rm -rf "${V_BUILD_TREE_X86_64}/parts"
sudo cp -vr "${V_BUILD_SYSTEM}/parts" "${V_BUILD_TREE_X86_64}/"
sudo cp -vr "${V_BUILD_DIR}/patches" "${V_BUILD_TREE_X86_64}/"

msg_green "chroot into: " "${V_BUILD_TREE_X86_64}"

if [ ! -d "${V_BUILD_TREE_X86_64}/packages" ]; then
	mkdir ${V_BUILD_TREE_X86_64}/packages
fi

sudo chroot "${V_BUILD_TREE_X86_64}" /usr/bin/env -i   \
							HOME=/root                  \
							TERM="vt100"                \
							PS1='(v-build chroot) \u:\w\$ ' \
							PATH=/usr/bin:/usr/sbin     \
							/bin/bash

msg_green "status:" "exit chroot"

exit 0


