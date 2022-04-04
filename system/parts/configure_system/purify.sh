#!/bin/bash

# purifying system, remove excess files and directories

pushd /

rm -rf linux-*
rm -rf packages/*
rm -rf patches/*
rm -rf lib/python-*/test
rm -rf usr/bin/git
rm -rf usr/libexec/git-core/git

rm -rf /usr/bin/perlbug
rm -rf /usr/bin/perl
rm -rf /usr/bin/perldoc
rm -rf /usr/bin/perl5.34.0
rm -rf /usr/bin/perlivp
rm -rf /usr/bin/perlthanks
rm -rf /usr/lib/perl5

rm -rf /usr/bin/python3.9-config
rm -rf /usr/bin/python3-config
rm -rf /usr/bin/python3
rm -rf /usr/bin/python3.9
rm -rf /usr/lib/pkgconfig/python3-embed.pc
rm -rf /usr/lib/pkgconfig/python-3.9.pc
rm -rf /usr/lib/pkgconfig/python3.pc
rm -rf /usr/lib/pkgconfig/python-3.9-embed.pc
rm -rf /usr/lib/python3.9
rm -rf /usr/include/python3.9
rm -rf /usr/share/man/man1/python3.9.1
rm -rf /usr/share/man/man1/python3.1

rm -rf /usr/bin/gcc-ar
rm -rf /usr/bin/gcc
rm -rf /usr/bin/gcc-ranlib
rm -rf /usr/bin/gcc-nm
rm -rf /usr/lib/perl5/5.34/core_perl/ExtUtils/CBuilder/Platform/Windows/GCC.pm
rm -rf /usr/lib/gcc
rm -rf /usr/libexec/gcc
rm -rf /usr/share/man/man1/gcc.1
rm -rf /usr/share/vim/vim82/compiler/gcc.vim
rm -rf /usr/share/gcc-9.4.0
rm -rf /usr/share/locale/zh_TW/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/tr/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/nl/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/fr/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/sr/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/de/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/hr/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/es/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/ja/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/fi/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/be/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/da/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/sv/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/uk/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/id/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/vi/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/zh_CN/LC_MESSAGES/gcc.mo
rm -rf /usr/share/locale/el/LC_MESSAGES/gcc.mo
rm -rf /usr/share/info/gccinstall.info
rm -rf /usr/share/info/gccint.info
rm -rf /usr/share/info/gcc.info

rm -rf /usr/libexec/git-core
rm -rf /usr/bin/cmake
rm -rf /usr/lib/cmake
rm -rf /usr/share/bash-completion

rm -rf ./usr/bin/git-cvsserver
rm -rf ./usr/bin/git-upload-pack
rm -rf ./usr/bin/git-receive-pack
rm -rf ./usr/bin/git-upload-archive
rm -rf ./usr/bin/git-shell
rm -rf ./usr/bin/gitk
rm -rf ./usr/share/git-gui
rm -rf ./usr/share/gitweb
rm -rf ./usr/share/cmake*
rm -rf ./usr/share/git-core
rm -rf ./usr/share/gitk

popd


exit 0
