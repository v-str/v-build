#!/bin/bash

cp -r etc-copy/* /etc/

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
FONT="koi8r.8x8 -m 8859-15"

# End /etc/sysconfig/console
EOF

locale -a


exit 0

