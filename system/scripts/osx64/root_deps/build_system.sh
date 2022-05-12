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

function invoke_cmd_chroot_parts() {
	sudo chroot "${V_BUILD_TREE_X86_64}" /usr/bin/env -i	\
							HOME=/root						\
							TERM="vt100"					\
							PS1='(v-build chroot) \u:\w\$ '	\
							PATH=/usr/bin:/usr/sbin			\
							/parts/$1/run.sh
}

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

# stage 1 is toolchain building, so we no need it here, start with stage 2

# temp system: util-lunux, bison, gettext, perl and so on
msg_green_sleep "Stage 2: " "build temp system"
invoke_cmd_chroot_parts "2-temp_system"


# main packages of the system
msg_green_sleep "Stage 3: " "build main system"
invoke_cmd_chroot_parts "3-main_system"


# build qt and related packages
msg_green_sleep "Stage 4: " "build qt and deps"
invoke_cmd_chroot_parts "4-qt_deps"


# company related packages
msg_green_sleep "Stage 4: " "configure system"
invoke_cmd_chroot_parts "x-company_deps"


msg_green "status:" "exit chroot"

${OSXDIR}/root_deps/unmount_vkfs.sh

exit 0


