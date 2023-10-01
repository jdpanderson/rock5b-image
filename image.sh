#!/bin/bash -ex

# Note: This is not a build system. This is just a script that serves to document and reproduce how I built rock5b images

source lib/vars.sh
source lib/linux.sh
source lib/uboot.sh
source lib/rkbin.sh
source lib/image.sh

if [[ "$1" =~ "_" ]]; then
	$($1)
elif [ "$1" == "source" ]; then
	linux_source
	rkbin_source
	uboot_source
elif [ "$1" == "linux" ]; then
	linux_source
	linux_build
elif [ "$1" == "uboot" ]; then
	rkbin_source
	uboot_source
	uboot_build
elif [ "$1" == "image" ]; then
	image_source
	image_build
else
	linux_source
	linux_build
		
	rkbin_source
	uboot_source
	uboot_build

	image_source
	image_build

	echo "If there were no errors above, we should have a bootable image in ${BUILD}/system.img"
fi
