#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

function msg(){ printf "${NC}$1 $2${NC}\n" ; }
function msg_green(){ printf "\n${NC}$1 ${GREEN}$2${NC}\n\n" ; }
function msg_red(){ printf "\n${NC}$1 ${RED}$2${NC}\n\n" ; }

search_pkg=`sh /parts/3-main_system/find_package.sh "LVM2"`

# for LVM package the next kernel options must be enabled:
# CONFIG_MD
# CONFIG_BLK_DEV_DM
# CONFIG_DM_CRYPT
# CONFIG_DM_SNAPSHOT
# CONFIG_DM_THIN_PROVISIONING
# CONFIG_DM_CACHE
# CONFIG_DM_MIRROR
# CONFIG_DM_ZERO
# CONFIG_DM_DELAY
# CONFIG_BLK_DEV_RAM
# CONFIG_MAGIC_SYSRQ

if [ ! -z "${search_pkg}" ]; then
	msg_green "package found:" "$search_pkg"
else
	msg_res "package not found:" "$search_pkg"
	exit 1
fi

pushd /packages/${search_pkg}/${search_pkg}

PATH+=:/usr/sbin                \
./configure --prefix=/usr       \
            --enable-cmdlib     \
            --enable-pkgconfig  \
            --enable-udev_sync

make -j`nproc`

make -C tools install_tools_dynamic
make -C udev  install
make -C libdm install
make install
rm /usr/lib/udev/rules.d/69-dm-lvm.rules

popd

exit 0


