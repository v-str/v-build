#!/bin/bash

# Extract archives into $V_BUILD_PKG_DIR

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'
PKG_COUNTER=1

function msg(){ printf "${NC}$1 $2${NC}\n" ; }
function msg_green(){ printf "${NC}$1 ${GREEN}$2${NC}" ; }
function msg_red(){ printf "${NC}$1 ${RED}$2${NC}" ; }

if [ -e "$V_BUILD_PKG_DIR" ]; then

	if [ ! -e "$V_BUILD_ARCHIVE_DIR" ]; then
		printf "Directory \"archives\" doesn't exist\n"
		exit 1
	fi

	for archive in $V_BUILD_ARCHIVE_DIR/*.*; do

		# get archive name without full path
		pkg_name=$(basename "$archive")

		# remove 'tar.*' extension
		dirname=$(echo "$V_BUILD_PKG_DIR/$pkg_name" | sed 's/\.tar.*//')

		if [ -d "$dirname" ]; then
			msg_green "Directory $dirname already" "exist\n"
			continue
		else
			mkdir $dirname
			# untar into pkg dir
			msg_green "- $PKG_COUNTER - $(basename "$dirname")" " "
			tar -xf $archive -C "$dirname" > /dev/null 2>&1
			msg_green "" "+\n"

			let "PKG_COUNTER=PKG_COUNTER+1"
		fi

	done
else
	printf "Directory \"packages\" doesn't exist\n"
	exit 1
fi

mkdir -p "${V_BUILD_PKG_DIR}/qt5/qt5"
pushd ${V_BUILD_PKG_DIR}/qt5/qt5

mkdir -p "$V_BUILD_PKG_DIR/qt5/qt5"
cp -rv "${V_BUILD_ARCHIVE_DIR}/qt5/"* "$V_BUILD_PKG_DIR/qt5/qt5"

popd

echo "true" > "${V_BUILD_DIR}/.extracted"

exit 0
