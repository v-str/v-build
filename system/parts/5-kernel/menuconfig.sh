#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

linux=`ls / | grep linux`

if [ -z "$linux" ]; then
	printf "linux-* directory doesn't exist, you need to run: \"place_kernel\"
	command\n"
	exit 1
fi

ls -lh /parts/kernel_configs/

printf "
Choose config:
1. CONFIG_NAME
2. skip
"

read -p 'Operation: ' var

if [ "$var" != "skip" ]; then
	cp -v /parts/kernel_configs/$var /$linux/.config
	cd $linux && make menuconfig
else
	cd $linux && make menuconfig
fi

printf "
Save config?
1. CONFIG_NAME
2. skip

say skip, not 2
"

read -p 'Operation: ' var

if [ "$var" != "skip" ]; then
	cp -v /$linux/.config /parts/kernel_configs/$var
	echo "done"
else
	echo "done"
fi

exit 0


