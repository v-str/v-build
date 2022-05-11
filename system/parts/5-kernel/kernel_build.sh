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

if [ ! -d "$linux" ]; then
	printf "Linux kernel directory does not exist. Exit\n"
	exit 1
else
	if [ ! -e "$linux/.config" ]; then
		printf "Kernel config does not set. Run menuconfig. Exit\n"
		exit 1
	fi

	cd $linux && make -j`nproc`
fi

exit 0


