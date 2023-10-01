#!/bin/bash -ex

#ORIGIN=https://gitlab.collabora.com/hardware-enablement/rockchip-3588/rkbin.git
ORIGIN=https://github.com/radxa/rkbin.git
BRANCH=master

CROSS_COMPILE=aarch64-linux-gnu-
ARCH=arm64

uboot_source() {
	git_source rkbin ${ORIGIN} ${BRANCH}
#	if [ -d ${BUILD}/uboot ]; then
#		
#		return
#	fi
#	mkdir -p ${BUILD}
#	pushd ${BUILD}
#	git submodule add ${ORIGIN} uboot
#	pushd uboot
#	git checkout origin/${BRANCH}
#	popd
#	popd
}

uboot_bin() {
	if [ -d ${BUILD}/rkbin ]; then
		return
	fi
	mkdir -p ${BUILD}
	pushd ${BUILD}
	git submodule add ${RKBIN_ORIGIN} rkbin
	popd
}

uboot_build() {
	pushd ${BUILD}/uboot
	export ROCKCHIP_TPL=$(ls -1 ../rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v1.[0-9][0-9].bin)
	export BL31=$(ls -1 ../rkbin/bin/rk35/rk3588_bl31_v1.[0-9][0-9].elf)
	CROSS_COMPILE=${CROSS_COMPILE} make rock5b-rk3588_defconfig
	CROSS_COMPILE=${CROSS_COMPILE} make
	popd
}

uboot_clean() {
	echo "no clean yet"
}
