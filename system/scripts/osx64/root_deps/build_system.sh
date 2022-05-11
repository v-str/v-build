#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

function msg(){ printf "${NC}$1 $2${NC}\n" ; }
function msg_green(){ printf "\n${NC}$1 ${GREEN}$2${NC}\n\n" ; }
function msg_green_sleep(){ 
	printf "\n${NC}$1 ${GREEN}$2${NC}\n\n" ;
	sleep 5 ;
}
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

${OSXDIR}/root_deps/mount_vkfs.sh

msg_green "Re-extraction..."
sudo rm -rf ${V_BUILD_PKG_DIR} && mkdir ${V_BUILD_PKG_DIR}
${V_BUILD_SYSTEM}/scripts/osx64/common/extract_archives.sh

msg_green "Copy part scripts into:" "${V_BUILD_TREE_X86_64}"

sudo rm -rf "${V_BUILD_TREE_X86_64}/parts"
sudo cp -r "${V_BUILD_SYSTEM}/parts" "${V_BUILD_TREE_X86_64}/"
sudo cp -r "${V_BUILD_DIR}/patches" "${V_BUILD_TREE_X86_64}/"

msg_green "chroot into: " "${V_BUILD_TREE_X86_64}"

if [ ! -d "${V_BUILD_TREE_X86_64}/packages" ]; then
	mkdir ${V_BUILD_TREE_X86_64}/packages
fi

msg_green_sleep "Stage 2: " "build temp system"

sudo chroot "${V_BUILD_TREE_X86_64}" /usr/bin/env -i   \
							HOME=/root                  \
							TERM="vt100"                \
							PS1='(v-build chroot) \u:\w\$ ' \
							PATH=/usr/bin:/usr/sbin     \
							/parts/2-temp_system/run.sh

msg_green_sleep "Stage 3: " "build main system"
sudo chroot "${V_BUILD_TREE_X86_64}" /usr/bin/env -i   \
							HOME=/root                  \
							TERM="vt100"                \
							PS1='(v-build chroot) \u:\w\$ ' \
							PATH=/usr/bin:/usr/sbin     \
							/parts/3-main_system/run.sh

msg_green_sleep "Stage 4: " "configure system"
sudo chroot "${V_BUILD_TREE_X86_64}" /usr/bin/env -i   \
							HOME=/root                  \
							TERM="vt100"                \
							PS1='(v-build chroot) \u:\w\$ ' \
							PATH=/usr/bin:/usr/sbin     \
							/parts/configure_system/run.sh

msg_green "status:" "exit chroot"

${OSXDIR}/root_deps/unmount_vkfs.sh

exit 0

