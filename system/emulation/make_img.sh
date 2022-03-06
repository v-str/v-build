#!/bin/bash

img="${PWD}/v-build.img"
block_size=512
cnt=8388608

# 4Gb

rm -rf ${img}
touch ${img}
dd if=/dev/zero of=${img} bs=${block_size} count=${cnt} status=progress
                                                                                                                
losetup /dev/loop0 "${img}"

parted --script /dev/loop0 \
	unit mib \
	mklabel gpt \
	mkpart primary 1 2 \
	set 1 bios_grub on \
	mkpart primary 3 100%

mkfs.ext4 /dev/loop0p2
parted /dev/loop0 print

mkdir /mnt/loopdev

mount /dev/loop0p2 /mnt/loopdev

sudo cp -R ../tree_x86_64/* /mnt/loopdev/
sync

cp -v "${PWD}/vmlinuz" "/mnt/loopdev/boot/vmlinuz"
cp -v ${PWD}/grub.cfg /mnt/loopdev/boot/grub.cfg

grub-install /dev/loop0 \
    --target=i386-pc \
    --grub-mkimage="${PWD}/grub.img" \
	--boot-directory=/mnt/loopdev/boot

sync

umount -v /dev/loop0p2

losetup -D
sudo chown user:user v-build.img

#sudo find . | sudo cpio --quiet -H newc -o | sudo gzip -9 -n > fs.img

#sudo chown user:user fs.img
