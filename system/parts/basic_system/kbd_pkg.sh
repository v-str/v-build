#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

function msg(){ printf "${NC}$1 $2${NC}\n" ; }
function msg_green(){ printf "\n${NC}$1 ${GREEN}$2${NC}\n\n" ; }
function msg_red(){ printf "\n${NC}$1 ${RED}$2${NC}\n\n" ; }

search_pkg=`sh /parts/basic_system/find_package.sh "kbd"`

if [ ! -z "${search_pkg}" ]; then
	msg_green "package found:" "$search_pkg"
else
	msg_res "package not found:" "$search_pkg"
	exit 1
fi

pushd /packages/${search_pkg}/${search_pkg}

patch -Np1 -i /patches/kbd-2.4.0-backspace-1.patch

sed -i '/RESIZECONS_PROGS=/s/yes/no/' configure
sed -i 's/resizecons.8 //' docs/man/man8/Makefile.in

./configure --prefix=/usr --disable-vlock

make

make install

popd

exit 0


