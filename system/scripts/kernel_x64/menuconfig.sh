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

KDIR="${V_BUILD_SYSTEM}/scripts/kernel_x64"

if [ ! -d "$KDIR" ]; then
	msg_red "Failure to find directory: " "$KDIR"
	exit 1
fi

${KDIR}/mount_vkfs.sh

msg_green "Copy parts scripts into:" "${V_BUILD_TREE_X86_64}"

sudo rm -rf "${V_BUILD_TREE_X86_64}/parts"
sudo cp -r "${V_BUILD_SYSTEM}/parts" "${V_BUILD_TREE_X86_64}/"

sudo chroot "${V_BUILD_TREE_X86_64}" /usr/bin/env -i   \
							HOME=/root                  \
							TERM="vt100"                \
							PS1='(v-build chroot) \u:\w\$ ' \
							PATH=/usr/bin:/usr/sbin     \
							/bin/bash /parts/5-kernel/menuconfig.sh

cp "${V_BUILD_TREE_X86_64}/parts/kernel_configs/"* \
	"${V_BUILD_SYSTEM}/parts/kernel_configs/"

printf "\nkernel configs copied into tree/parts/kernel_configs\n"

${KDIR}/unmount_vkfs.sh

exit 0


