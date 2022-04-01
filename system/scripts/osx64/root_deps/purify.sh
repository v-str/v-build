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

OSXDIR="${V_BUILD_SYSTEM}/scripts/osx64"

if [ ! -d "$OSXDIR" ]; then
	msg_red "Failure to find directory: " "$OSXDIR"
	exit 1
fi

if [ -e "${V_BUILD_DIR}/.vkfs_mounted" ]; then
	msg_red "chroot fail:" "something wrong, remove file \.vkfs_mounted and try again."
	exit 0
fi

msg_green "" "Before purifying"

sudo du -shc ${V_BUILD_TREE_X86_64}/

${OSXDIR}/root_deps/mount_vkfs.sh

msg_green "Copy part scripts into:" "${V_BUILD_TREE_X86_64}"

sudo rm -rf "${V_BUILD_TREE_X86_64}/parts"
sudo cp -r "${V_BUILD_SYSTEM}/parts" "${V_BUILD_TREE_X86_64}/"
sudo cp -r "${V_BUILD_DIR}/patches" "${V_BUILD_TREE_X86_64}/"

msg_green "chroot into: " "${V_BUILD_TREE_X86_64}"

if [ ! -d "${V_BUILD_TREE_X86_64}/packages" ]; then
	mkdir ${V_BUILD_TREE_X86_64}/packages
fi

sudo chroot "${V_BUILD_TREE_X86_64}" /usr/bin/env -i   \
							HOME=/root                  \
							TERM="vt100"                \
							PS1='(v-build chroot) \u:\w\$ ' \
							PATH=/usr/bin:/usr/sbin     \
							/parts/configure_system/purify.sh

msg_green "status:" "exit chroot"

${OSXDIR}/root_deps/unmount_vkfs.sh

msg_green "" "After purifying"

sudo du -shc ${V_BUILD_TREE_X86_64}/

exit 0


