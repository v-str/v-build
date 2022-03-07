#!/bin/bash

GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

linux=`ls / | grep linux`

ls -lh /parts/kernel_configs/

printf "\n1. CONFIG_NAME
2. skip\n"

read -p 'Operation: ' var

if [ "$var" != "skip" ]; then
	cp /parts/kernel_configs/$var /$linux/.config
	cd $linux && make menuconfig
else
	cd $linux && make menuconfig
fi

printf "\nSave config?\n
1. CONFIG_NAME
2. skip\n"

read -p 'Operation: ' var

if [ "$var" != "skip" ]; then
	cp /$linux/.config /parts/kernel_configs/$var
	echo "done"
else
	echo "done"
fi

exit 0


