#!/bin/bash -ex

# Note: This is not a build system. This is just a script that serves to document and reproduce how I built rock5b images

source lib/vars.sh
source lib/linux.sh
source lib/uboot.sh
source lib/rkbin.sh
source lib/image.sh

if [ "$1" == "source" ]; then
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
else
	linux_source
	linux_build
		
	rkbin_source
	uboot_source
	uboot_build

	image_build
fi
