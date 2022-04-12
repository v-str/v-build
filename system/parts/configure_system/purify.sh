#!/bin/bash

# purifying system, remove excess files and directories

echo "purifying ... "

pushd /

echo "Before:"
du -sch *

rm -rfv linux-*
rm -rfv packages/*
rm -rfv parts/*
rm -rfv patches/*
rm -rfv lib/python-*/test
rm -rfv usr/bin/git
rm -rfv usr/libexec/git-core/git

rm -rfv /usr/bin/perlbug
rm -rfv /usr/bin/perl
rm -rfv /usr/bin/perldoc
rm -rfv /usr/bin/perl5.34.0
rm -rfv /usr/bin/perlivp
rm -rfv /usr/bin/perlthanks
rm -rfv /usr/lib/perl5

rm -rfv /usr/bin/python3.9-config
rm -rfv /usr/bin/python3-config
rm -rfv /usr/bin/python3
rm -rfv /usr/bin/python3.9
rm -rfv /usr/lib/pkgconfig/python3-embed.pc
rm -rfv /usr/lib/pkgconfig/python-3.9.pc
rm -rfv /usr/lib/pkgconfig/python3.pc
rm -rfv /usr/lib/pkgconfig/python-3.9-embed.pc
rm -rfv /usr/lib/python3.9
rm -rfv /usr/include/python3.9
rm -rfv /usr/share/man/man1/python3.9.1
rm -rfv /usr/share/man/man1/python3.1

rm -rfv /usr/bin/gcc-ar
rm -rfv /usr/bin/gcc
rm -rfv /usr/bin/gcc-ranlib
rm -rfv /usr/bin/gcc-nm
rm -rfv /usr/lib/perl5/5.34/core_perl/ExtUtils/CBuilder/Platform/Windows/GCC.pm
rm -rfv /usr/lib/gcc
rm -rfv /usr/libexec/gcc
rm -rfv /usr/share/man/man1/gcc.1
rm -rfv /usr/share/vim/vim82/compiler/gcc.vim
rm -rfv /usr/share/gcc-9.4.0
rm -rfv /usr/share/locale/zh_TW/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/tr/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/nl/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/fr/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/sr/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/de/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/hr/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/es/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/ja/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/fi/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/be/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/da/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/sv/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/uk/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/id/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/vi/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/zh_CN/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/locale/el/LC_MESSAGES/gcc.mo
rm -rfv /usr/share/info/gccinstall.info
rm -rfv /usr/share/info/gccint.info
rm -rfv /usr/share/info/gcc.info

rm -rfv /usr/libexec/git-core
rm -rfv /usr/bin/cmake
rm -rfv /usr/lib/cmake
rm -rfv /usr/share/bash-completion

rm -rfv ./usr/bin/git-cvsserver
rm -rfv ./usr/bin/git-upload-pack
rm -rfv ./usr/bin/git-receive-pack
rm -rfv ./usr/bin/git-upload-archive
rm -rfv ./usr/bin/git-shell
rm -rfv ./usr/bin/gitk
rm -rfv ./usr/share/git-gui
rm -rfv ./usr/share/gitweb
rm -rfv ./usr/share/cmake*
rm -rfv ./usr/share/git-core
rm -rfv ./usr/share/gitk

echo "Before:"
du -sch *

popd


exit 0
