#!/bin/bash

# Download all archives and patches

PKG_LIST="$V_BUILD_SYSTEM/scripts/osx64/packages.list"
PATCH_LIST="$V_BUILD_SYSTEM/scripts/osx64/patches.list"

if [ ! -d "$V_BUILD_ARCHIVE_DIR" ]; then
	printf "Directory for archives doesn't exist, check env variables\n"
	exit 1
fi

if [ ! -d "$V_BUILD_PATCH_DIR" ]; then
	printf "Directory for patches doesn't exist, check env variables\n"
	exit 1
fi

wget --input-file=$PKG_LIST --continue --directory-prefix=$V_BUILD_ARCHIVE_DIR
wget --input-file=$PATCH_LIST --continue --directory-prefix=$V_BUILD_PATCH_DIR

pushd $V_BUILD_ARCHIVE_DIR

mtools=`ls | grep 0.8.9`
mv -v $mtools "multipath-tools-0.8.9.tar.gz"

libaio=`ls | grep libaio`
mv -v $libaio "libaio-0.3.112.tar.xz"

lvm=`ls | grep LVM`
mv -v $lvm "LVM2.2.03.15.tar.gz"

popd

exit 0

