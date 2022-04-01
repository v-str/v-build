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

mkfs.ext4 /dev/loop0p2
mkswap /dev/loop0p1

parted /dev/loop0 print

rm -rf /mnt/loopdev
mkdir /mnt/loopdev

mount /dev/loop0p2 /mnt/loopdev

sudo cp -R ../../build/tree_x86_64/* /mnt/loopdev/
sync

#cp -v "${PWD}/bzImage" "/mnt/loopdev/boot/bzImage"
#cp -v ${PWD}/grub.cfg /mnt/loopdev/boot/grub.cfg

#grub-install /dev/loop0 \
#    --target=i386-pc \
#    --grub-mkimage="${PWD}/grub.img" \
#	--boot-directory=/mnt/loopdev/boot

sync

umount -v /dev/loop0p3

losetup -D
sudo chown user:user v-build.img
