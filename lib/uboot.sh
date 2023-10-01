#!/bin/bash -ex

UBOOT_ORIGIN=https://gitlab.collabora.com/hardware-enablement/rockchip-3588/u-boot.git
UBOOT_BRANCH=2023.10-rc1-rk3588

uboot_source() {
	source_git uboot ${UBOOT_ORIGIN} ${UBOOT_BRANCH}
}

uboot_build() {
	pushd ${BUILD}/uboot
	export ROCKCHIP_TPL=$(ls -1 ../rkbin/bin/rk35/rk3588_ddr_lp4_2112MHz_lp5_2736MHz_v1.[0-9][0-9].bin)
	export BL31=$(ls -1 ../rkbin/bin/rk35/rk3588_bl31_v1.[0-9][0-9].elf)
	CROSS_COMPILE=${CROSS_COMPILE} make rock5b-rk3588_defconfig
	CROSS_COMPILE=${CROSS_COMPILE} make -j$(($(nproc) + 1))
	mkdir -p ${BUILD}/boot/extlinux
	cp ${DIR}/extlinux.conf ${BUILD}/boot/extlinux/
	popd
}

uboot_clean() {
	echo "no clean yet"
}
