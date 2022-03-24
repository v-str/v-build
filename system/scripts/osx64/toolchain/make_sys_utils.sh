#!/bin/bash

# installation:

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

function msg(){ printf "${NC}$1 $2${NC}\n" ; }
function msg_green(){ printf "\n${NC}$1 ${GREEN}$2${NC}\n\n" ; }
function msg_red(){ printf "\n${NC}$1 ${RED}$2${NC}\n\n" ; }

# utils list

M4="none"
NCURSES="none"
BASHPKG="none"
COREUTILS="none"
DIFFUTILS="none"
FILEPKG="none"
FINDPKG="none"
GAWK="none"
GREPPKG="none"
GZIP="none"
MAKEPKG="none"
PATCHPKG="none"
SEDPKG="none"
TARPKG="none"
XZPKG="none"

############################# Functions ########################################

# find package in PKG dir
function find_package(){
	local search_pkg=$1
	local res=$(ls ${V_BUILD_PKG_DIR} | grep $search_pkg)

	if [ -z "$res" ]; then
		msg_red "Pkg not found:" "$search_pkg"
		exit 1
	else
		echo $res
	fi
}


function install_m4(){
	msg_green "Package found: " "$M4"

	rm -rf ${V_BUILD_PKG_DIR}/$M4/$M4/build
	mkdir ${V_BUILD_PKG_DIR}/$M4/$M4/build

	pushd ${V_BUILD_PKG_DIR}/$M4/$M4/build

	sh ../configure \
	--prefix=/usr \
	--host=${V_BUILD_TGT_X86_64} \
	--build=$(../build-aux/config.guess)

	make -j`nproc`
	make DESTDIR=${V_BUILD_TREE_X86_64} install

	msg_green "" "$M4 has been built."

	popd
}

function install_ncurses() {
	msg_green "Package found: " "$NCURSES"


	pushd ${V_BUILD_PKG_DIR}/$NCURSES/$NCURSES
	sed -i s/mawk// configure

	sh configure

	make -C include
	make -C progs tic

	sh configure \
	--prefix=/usr \
	--host=$V_BUILD_TGT_X86_64 \
	--build=$(./config.guess) \
	--mandir=/usr/share/man \
	--with-manpage-format=normal \
	--with-shared \
	--without-debug \
	--without-ada \
	--without-normal \
	--enable-widec \

	make -j1

	make DESTDIR=${V_BUILD_TREE_X86_64} TIC_PATH= ${V_BUILD_TREE_X86_64}/bin/tic install

	echo "INPUT(-lncursesw)" > ${V_BUILD_TREE_X86_64}/usr/lib/libncurses.so

	msg_green "" "$NCURSES has been built."

	popd
}

function install_bash(){
	msg_green "Package found: " "$BASHPKG"

	rm -rf ${V_BUILD_PKG_DIR}/$BASHPKG/$BASHPKG/build
	mkdir ${V_BUILD_PKG_DIR}/$BASHPKG/$BASHPKG/build

	pushd ${V_BUILD_PKG_DIR}/$BASHPKG/$BASHPKG/build

	sh ../configure \
	--prefix=/usr \
	--build=$(../support/config.guess) \
	--host=$V_BUILD_TGT_X86_64 \
	--without-bash-malloc

	make -j`nproc`
	make DESTDIR=${V_BUILD_TREE_X86_64} install

	popd

	pushd ${V_BUILD_TREE_X86_64}
	ln -s bash usr/bin/sh
	popd

	msg_green "" "$BASHPKG has been built."
}

function install_coreutils(){
	msg_green "Package found: " "$COREUTILS"

	rm -rf ${V_BUILD_PKG_DIR}/$COREUTILS/$COREUTILS/build
	mkdir ${V_BUILD_PKG_DIR}/$COREUTILS/$COREUTILS/build

	pushd ${V_BUILD_PKG_DIR}/$COREUTILS/$COREUTILS/build

	sh ../configure \
	--prefix=/usr \
	--host=$V_BUILD_TGT_X86_64 \
	--build=$(../build-aux/config.guess)  \
	--enable-install-program=hostname \
	--enable-no-install-program=kill,uptime

	make -j`nproc`
	make DESTDIR=${V_BUILD_TREE_X86_64} install

	popd

	pushd ${V_BUILD_TREE_X86_64}

	mv -v ${V_BUILD_TREE_X86_64}/usr/bin/chroot ${V_BUILD_TREE_X86_64}/usr/sbin
	mkdir -p ${V_BUILD_TREE_X86_64}/usr/share/man/man8
	mv -v ${V_BUILD_TREE_X86_64}/usr/share/man/man1/chroot.1 \
		${V_BUILD_TREE_X86_64}/usr/share/man/man8/chroot.8
	sed -i 's/"1"/"8"/' ${V_BUILD_TREE_X86_64}/usr/share/man/man8/chroot.8

	popd

	msg_green "" "$COREUTILS has been built."
}

function install_diffutils(){
	msg_green "Package found: " "$DIFFUTILS"

	rm -rf ${V_BUILD_PKG_DIR}/$DIFFUTILS/$DIFFUTILS/build
	mkdir ${V_BUILD_PKG_DIR}/$DIFFUTILS/$DIFFUTILS/build

	pushd ${V_BUILD_PKG_DIR}/$DIFFUTILS/$DIFFUTILS/build

	sh ../configure \
	--prefix=/usr \
	--host=$V_BUILD_TGT_X86_64

	make -j`nproc`
	make DESTDIR=${V_BUILD_TREE_X86_64} install

	popd

	msg_green "" "$DIFFUTILS has been built."
}

function install_file(){
	msg_green "Package found: " "$FILEPKG"

	rm -rf ${V_BUILD_PKG_DIR}/$FILEPKG/$FILEPKG/build
	mkdir ${V_BUILD_PKG_DIR}/$FILEPKG/$FILEPKG/build

	pushd ${V_BUILD_PKG_DIR}/$FILEPKG/$FILEPKG/build

	sh ../configure \
	--disable-bzlib \
	--disable-libseccomp \
	--disable-xzlib \
	--disable-zlib

	make -j`nproc`

	popd

	pushd ${V_BUILD_PKG_DIR}/$FILEPKG/$FILEPKG

	sh configure \
	--prefix=/usr \
	--host=$V_BUILD_TGT_X86_64 \
	--build=$(./config.guess)

	make FILE_COMPILE=$(pwd)/build/src/file
	make DESTDIR=${V_BUILD_TREE_X86_64} install

	popd

	msg_green "" "$FILEPKG has been built."
}

function install_find(){
	msg_green "Package found: " "$FINDPKG"

	rm -rf ${V_BUILD_PKG_DIR}/$FINDPKG/$FINDPKG/build
	mkdir ${V_BUILD_PKG_DIR}/$FINDPKG/$FINDPKG/build

	pushd ${V_BUILD_PKG_DIR}/$FINDPKG/$FINDPKG/build

	sh ../configure \
	--prefix=/usr \
	--localstatedir=/var/lib/locate \
	--host=$V_BUILD_TGT_X86_64 \
	--build=$(../build-aux/config.guess)

	make -j`nproc`

	make DESTDIR=${V_BUILD_TREE_X86_64} install

	popd

	msg_green "" "$FINDPKG has been built."
}

function install_gawk(){
	msg_green "Package found: " "$GAWK"

	rm -rf ${V_BUILD_PKG_DIR}/$GAWK/$GAWK/build
	mkdir ${V_BUILD_PKG_DIR}/$GAWK/$GAWK/build

	pushd ${V_BUILD_PKG_DIR}/$GAWK/$GAWK/build

	sh ../configure \
	--prefix=/usr \
	--host=$V_BUILD_TGT_X86_64 \
	--build=$(../config.guess)

	make -j`nproc`

	make DESTDIR=${V_BUILD_TREE_X86_64} install

	popd

	msg_green "" "$GAWK has been built."
}

function install_grep(){
	msg_green "Package found: " "$GREPPKG"

	rm -rf ${V_BUILD_PKG_DIR}/$GREPPKG/$GREPPKG/build
	mkdir ${V_BUILD_PKG_DIR}/$GREPPKG/$GREPPKG/build

	pushd ${V_BUILD_PKG_DIR}/$GREPPKG/$GREPPKG/build

	sh ../configure \
	--prefix=/usr \
	--host=$V_BUILD_TGT_X86_64

	make -j`nproc`

	make DESTDIR=${V_BUILD_TREE_X86_64} install

	popd

	msg_green "" "$GREPPKG has been built."
}

function install_gzip(){
	msg_green "Package found: " "$GZIP"

	rm -rf ${V_BUILD_PKG_DIR}/$GZIP/$GZIP/build
	mkdir ${V_BUILD_PKG_DIR}/$GZIP/$GZIP/build

	pushd ${V_BUILD_PKG_DIR}/$GZIP/$GZIP/build

	sh ../configure \
	--prefix=/usr \
	--host=$V_BUILD_TGT_X86_64

	make -j`nproc`

	make DESTDIR=${V_BUILD_TREE_X86_64} install

	popd

	msg_green "" "$GZIP has been built."
}

function install_make(){
	msg_green "Package found: " "$MAKEPKG"

	rm -rf ${V_BUILD_PKG_DIR}/$MAKEPKG/$MAKEPKG/build
	mkdir ${V_BUILD_PKG_DIR}/$MAKEPKG/$MAKEPKG/build

	pushd ${V_BUILD_PKG_DIR}/$MAKEPKG/$MAKEPKG/build

	sh ../configure \
	--prefix=/usr \
	--without-guile \
	--host=$V_BUILD_TGT_X86_64 \
	--build=$(../build-aux/config.guess)

	make -j`nproc`

	make DESTDIR=${V_BUILD_TREE_X86_64} install

	popd

	msg_green "" "$MAKEPKG has been built."
}

function install_patch(){
	msg_green "Package found: " "$PATCHPKG"

	rm -rf ${V_BUILD_PKG_DIR}/$PATCHPKG/$PATCHPKG/build
	mkdir ${V_BUILD_PKG_DIR}/$PATCHPKG/$PATCHPKG/build

	pushd ${V_BUILD_PKG_DIR}/$PATCHPKG/$PATCHPKG/build

	sh ../configure \
	--prefix=/usr \
	--host=$V_BUILD_TGT_X86_64 \
	--build=$(../build-aux/config.guess)

	make -j`nproc`

	make DESTDIR=${V_BUILD_TREE_X86_64} install

	popd

	msg_green "" "$PATCHPKG has been built."
}

function install_sed(){
	msg_green "Package found: " "$SEDPKG"

	rm -rf ${V_BUILD_PKG_DIR}/$SEDPKG/$SEDPKG/build
	mkdir ${V_BUILD_PKG_DIR}/$SEDPKG/$SEDPKG/build

	pushd ${V_BUILD_PKG_DIR}/$SEDPKG/$SEDPKG/build

	sh ../configure \
	--prefix=/usr \
	--host=$V_BUILD_TGT_X86_64

	make -j`nproc`

	make DESTDIR=${V_BUILD_TREE_X86_64} install

	popd

	msg_green "" "$SEDPKG has been built."
}

function install_tar(){
	msg_green "Package found: " "$TARPKG"

	rm -rf ${V_BUILD_PKG_DIR}/$TARPKG/$TARPKG/build
	mkdir ${V_BUILD_PKG_DIR}/$TARPKG/$TARPKG/build

	pushd ${V_BUILD_PKG_DIR}/$TARPKG/$TARPKG/build

	sh ../configure \
	--prefix=/usr \
	--host=$V_BUILD_TGT_X86_64 \
	--build=$(../build-aux/config.guess)

	make -j`nproc`

	make DESTDIR=${V_BUILD_TREE_X86_64} install

	popd

	msg_green "" "$TARPKG has been built."
}

function install_xz(){
	msg_green "Package found: " "$XZPKG"

	rm -rf ${V_BUILD_PKG_DIR}/$XZPKG/$XZPKG/build
	mkdir ${V_BUILD_PKG_DIR}/$XZPKG/$XZPKG/build

	pushd ${V_BUILD_PKG_DIR}/$XZPKG/$XZPKG/build

	sh ../configure \
	--prefix=/usr \
	--host=$V_BUILD_TGT_X86_64 \
	--build=$(../build-aux/config.guess) \
	--disable-static \
	--docdir=/usr/share/doc/$XZPKG

	make -j`nproc`

	make DESTDIR=${V_BUILD_TREE_X86_64} install

	popd

	msg_green "" "$XZPKG has been built."
}

################################### Main #######################################

if [ ! -d "${V_BUILD_DIR}" ]; then
	printf "env variables don't set, exit.\n"
	exit 1
fi

if [ ! -d "${V_BUILD_TOOLS_X86_64}" ]; then
	printf "env variables don't set, exit.\n"
	exit 1
fi

M4=$(find_package "m4")
NCURSES=$(find_package "ncurses")
BASHPKG=$(find_package "bash")
COREUTILS=$(find_package "coreutils")
DIFFUTILS=$(find_package "diffutils")
FILEPKG=$(find_package "file")
FINDPKG=$(find_package "findutils")
GAWK=$(find_package "gawk")
GREPPKG=$(find_package "grep")
GZIP=$(find_package "gzip")
MAKEPKG=$(find_package "^make")
PATCHPKG=$(find_package "patch")
SEDPKG=$(find_package "sed")
TARPKG=$(find_package "tar")
XZPKG=$(find_package "xz")

install_m4
install_ncurses
install_bash
install_coreutils
install_diffutils
install_file
install_find
install_gawk
install_grep
install_gzip
install_make
install_patch
install_sed
install_tar
install_xz

exit 0
