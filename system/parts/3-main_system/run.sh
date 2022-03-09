#!/bin/bash

pushd /parts/3-main_system
./man-pages_pkg.sh
./iana-etc_pkg.sh
./glibc_pkg.sh
./zlib_pkg.sh
./bzip2_pkg.sh
./xz_pkg.sh
./zstd_pkg.sh
./file_pkg.sh
./ncurses_pkg.sh

# COMMENT readline after ncurses
./readline_pkg.sh

./m4_pkg.sh
./bc_pkg.sh
./flex_pkg.sh

# COMMENT tcl is hard coded script, version - 8.6
./tcl_pkg.sh

./expect_pkg.sh
# COMMENT dejagnu is depend from expect
./dejagnu_pkg.sh

# COMMENT binutils is depend from expect
./binutils_pkg.sh

./gmp_pkg.sh
./mpfr_pkg.sh
./mpc_pkg.sh
./attr_pkg.sh
./acl_pkg.sh
./libcap_pkg.sh
./shadow_pkg.sh
./gcc_pkg.sh
./pkg-config_pkg.sh
./sed_pkg.sh
./psmisc_pkg.sh
./gettext_pkg.sh
./bison_pkg.sh
./grep_pkg.sh
./bash_pkg.sh
./libtool_pkg.sh
./gdbm_pkg.sh
./gperf_pkg.sh
./expat_pkg.sh
./inetutils_pkg.sh
./less_pkg.sh

# COMMENT perl version 5.34, re-extract before building or you'll errors
./perl_pkg.sh
./XML-Parser_pkg.sh

./intltool_pkg.sh
./autoconf_pkg.sh
./automake_pkg.sh
./kmod_pkg.sh
./elfutils_pkg.sh
./libffi_pkg.sh

./openssl_pkg.sh
./python3_pkg.sh

# COMMENT ninja after python3
./ninja_pkg.sh

./meson_pkg.sh
./coreutils_pkg.sh
./check_pkg.sh
./diffutils_pkg.sh
./gawk_pkg.sh
./findutils_pkg.sh
./groff_pkg.sh
./gzip_pkg.sh
./iproute2_pkg.sh
./kbd_pkg.sh
./libpipeline_pkg.sh

# COMMENT make is version 4*
./make_pkg.sh

./patch_pkg.sh
./tar_pkg.sh
./texinfo_pkg.sh
./vim_pkg.sh
./eudev_pkg.sh
./procps-ng_pkg.sh
./util-linux_pkg.sh
./e2fsprogs_pkg.sh
./sysklogd_pkg.sh
./sysvinit_pkg.sh
./rsync_pkg.sh
./lfs_bootscripts.sh


# COMMENT strip system
./strip_and_clean.sh


popd

exit 0

