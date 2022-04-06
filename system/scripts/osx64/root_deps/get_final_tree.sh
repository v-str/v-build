#!/bin/bash

GREEN='\033[0;32m'

RED='\033[0;31m'
NC='\033[0m'

FINAL_TREE="final.tree"

function msg(){ printf "${NC}$1 $2${NC}\n" ; }
function msg_green(){ printf "\n${NC}$1 ${GREEN}$2${NC}\n" ; }
function msg_red(){ printf "\n${NC}$1 ${RED}$2${NC}\n" ; }

if [ ! -d "${V_BUILD_TREE_X86_64}" ]; then
	msg_red "\$V_BUILD_TREE" "do not exist!"
	msg_red ":" "nothing to copy, exit with error"
	sleep 5
	exit 1
fi

if [ -z "${V_BUILD_SYSTEM}" ]; then
	msg_red "\$V_BUILD_SYSTEM" "do not exist!"
	msg_red ":" "check your environment vars"
	sleep 5
	exit 1
fi

OSXDIR="${V_BUILD_SYSTEM}/scripts/osx64"

if [ ! -d "$OSXDIR" ]; then
	msg_red "Failure to find directory: " "$OSXDIR"
	exit 1
fi

if [ -d "${V_BUILD_DIR}/${FINAL_TREE}" ]; then
	sudo rm -rf "${V_BUILD_DIR}/${FINAL_TREE}" 
fi

mkdir "${V_BUILD_DIR}/${FINAL_TREE}" 

msg_green "in progress: " "rsync ..."
sudo rsync -ah --exclude 'linux*/*' --exclude 'packages' \
	${V_BUILD_TREE_X86_64}/* ${V_BUILD_DIR}/${FINAL_TREE}/
sudo chown -R root:root ${V_BUILD_DIR}/${FINAL_TREE}
msg_green "rsync: " "done"

${OSXDIR}/root_deps/mount_vkfs_final.sh

sudo cp -v "${V_BUILD_SYSTEM}/parts/configure_system/purify.sh" \
	${V_BUILD_DIR}/${FINAL_TREE}

msg_green "chrooting into: " "final.tree"
sleep 1
sudo chroot "${V_BUILD_DIR}/${FINAL_TREE}" /usr/bin/env -i   \
							HOME=/root                  \
							TERM="vt100"                \
							PS1='(v-build chroot) \u:\w\$ ' \
							PATH=/usr/bin:/usr/sbin     \
							/purify.sh

msg_green "status:" "exit chroot"

${OSXDIR}/root_deps/unmount_vkfs_final.sh

exit 0

