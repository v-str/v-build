#!/bin/bash

rm -v /etc/group
rm -v /etc/passwd

sleep 3

cp -rv /parts/configure_system/etc-copy/* /etc/

cat > /etc/shells << "EOF"
# Begin /etc/shells

/bin/sh
/bin/bash

# End /etc/shells
EOF

cat > /etc/sysconfig/console << "EOF"
# Begin /etc/sysconfig/console

UNICODE="1"
KEYMAP="us"
KEYMAP_CORRECTIONS="unicode"
LEGACY_CHARSET="iso-8859-15"
FONT="koi8u_8x16 -m 8859-15"

# End /etc/sysconfig/console
EOF

locale -a

pushd /parts/configure_system/bootscripts
make install
popd

exit 0

