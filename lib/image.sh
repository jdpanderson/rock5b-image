#!/bin/bash -ex

ROOTFS=http://os.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz
IMAGE_SIZE=2048

image_source() {
	if [ ! -f ${BUILD}/rootfs.tar.gz ]; then
		wget -O ${BUILD}/rootfs.tar.gz ${ROOTFS}
	fi
}

image_build() {
	image_create
	image_write
}

# Create a system.img with partition table and bootloaders, but empty filesystems
image_create() {
	BOOT_START=32768
	ROOT_START=1081344
	LOADER1_START=64
	LOADER2_START=16384
	dd if=/dev/zero of=${BUILD}/system.img bs=1M count=${IMAGE_SIZE}
	dd if=${BUILD}/uboot/idbloader.img of=${BUILD}/system.img seek=${LOADER1_START} conv=notrunc
	dd if=${BUILD}/uboot/u-boot.itb of=${BUILD}/system.img seek=${LOADER2_START} conv=notrunc
	parted -s ${BUILD}/system.img mklabel gpt
	parted -s ${BUILD}/system.img unit s mkpart boot ${BOOT_START} $(expr ${ROOT_START} - 1)
	parted -s ${BUILD}/system.img set 1 boot on
	parted -s ${BUILD}/system.img -- unit s mkpart rootfs ${ROOT_START} -34s
}

# Write data to system.img filesystems
image_write() {
	LOOP=$(sudo losetup -f)
	sudo losetup -P ${LOOP} ${BUILD}/system.img
	sudo mkfs.vfat ${LOOP}p1
	sudo mkfs.ext4 ${LOOP}p2
	UUID=$(sudo blkid -s PARTUUID -o value ${LOOP}p2)
	mkdir -p ${BUILD}/boot/extlinux
	sed -e "s/ root=PARTUUID=614e0000-00 / root=PARTUUID=${UUID} /" < extlinux.conf > ${BUILD}/boot/extlinux/extlinux.conf
	mkdir -p ${BUILD}/root
	sudo mount ${LOOP}p2 ${BUILD}/root
	sudo mkdir -p ${BUILD}/root/boot
	sudo mount ${LOOP}p1 ${BUILD}/root/boot
	sudo cp -r ${BUILD}/boot/* ${BUILD}/root/boot/
	sudo umount ${BUILD}/root/boot
	sudo bsdtar -xpf ${BUILD}/rootfs.tar.gz -C ${BUILD}/root
	sudo umount ${BUILD}/root
	sudo losetup -d ${LOOP}
}

# Data from raxda build's partitions.sh
#+ LOADER1_SIZE=8000
#+ RESERVED1_SIZE=128
#+ RESERVED2_SIZE=8192
#+ LOADER2_SIZE=8192
#+ ATF_SIZE=8192
#+ BOOT_SIZE=1048576
#+ SYSTEM_START=0
#+ LOADER1_START=64
#++ expr 64 + 8000
#+ RESERVED1_START=8064
#++ expr 8064 + 128
#+ RESERVED2_START=8192
#++ expr 8192 + 8192
#+ LOADER2_START=16384
#++ expr 16384 + 8192
#+ ATF_START=24576
#++ expr 24576 + 8192
#+ BOOT_START=32768
#++ expr 32768 + 1048576
#+ ROOTFS_START=1081344
