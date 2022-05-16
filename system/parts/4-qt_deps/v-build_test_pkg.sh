#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

function msg(){ printf "${NC}$1 $2${NC}\n" ; }
function msg_green(){ printf "\n${NC}$1 ${GREEN}$2${NC}\n\n" ; }
function msg_red(){ printf "\n${NC}$1 ${RED}$2${NC}\n\n" ; }

search_pkg=`sh /parts/4-qt_deps/find_package.sh "v-build"`

if [ ! -z "${search_pkg}" ]; then
	msg_green "package found:" "$search_pkg"
else
	msg_res "package not found:" "$search_pkg"
	exit 1
fi

pushd /packages/${search_pkg}/${search_pkg}

mkdir build
pushd build

if [ ! -d "/opt/qt5" ]; then
	msg_red "Build error:" "qt5 doesn't exist"
	exit 1
fi

/opt/qt5/bin/qmake ../

make -j`nproc`

app=`ls | grep v-build | grep app`

install $app /usr/bin

popd
popd

exit 0


