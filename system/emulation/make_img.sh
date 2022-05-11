#!/bin/bash

img="${PWD}/v-build.img"
block_size=1024
cnt=2097152

# 2Gb

rm -rf ${img}
touch ${img}
dd if=/dev/zero of=${img} bs=${block_size} count=${cnt} status=progress
                                                                                                                
losetup /dev/loop0 "${img}"

parted --script /dev/loop0 \
	unit mib \
	mklabel gpt \
	mkpart primary 1% 30% \
	set 1 swap on \
	mkpart primary 30% 100% \
	quit

losetup -D
sleep 1
losetup -P /dev/loop0 "${img}"

mkswap /dev/loop0p1
mkfs.ext4 /dev/loop0p2

parted /dev/loop0 print

rm -rf /mnt/loopdev
mkdir /mnt/loopdev

mount /dev/loop0p2 /mnt/loopdev
sudo cp -R ../../build/final.tree/* /mnt/loopdev/
sync
umount -v /dev/loop0p2

losetup -D
sudo chown user:user v-build.img
