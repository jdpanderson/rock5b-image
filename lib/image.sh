#!/bin/bash -ex

IMAGE_SIZE=2048

image_build() {
	BOOT_START=32768
	ROOT_START=1081344
	dd if=/dev/zero of=${BUILD}/system.img bs=1M count=${IMAGE_SIZE}
	parted -s ${BUILD}/system.img mklabel gpt
	parted -s ${BUILD}/system.img unit s mkpart boot ${BOOT_START} $(expr ${ROOT_START} - 1)
	parted -s ${BUILD}/system.img set 1 boot on
	parted -s ${BUILD}/system.img -- unit s mkpart rootfs ${ROOT_START} -34s
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
