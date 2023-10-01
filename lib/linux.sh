#!/bin/bash -ex

#ORIGIN=https://github.com/torvalds/linux.git
#ORIGIN=https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable
#PANTHOR=https://gitlab.freedesktop.org/bbrezillon/linux.git
#PANTHOR_BRANCH=panthor-debug

LINUX_ORIGIN=https://github.com/jdpanderson/linux.git
LINUX_BRANCH=rock5b-panthor
LINUX_IMAGE=arch/arm64/boot/Image
# Really an RK3588 DTB, but naming consistency
LINUX_DTB=arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dtb

linux_source() {
	source_git linux ${LINUX_ORIGIN} ${LINUX_BRANCH}
}

linux_build() {
	pushd ${BUILD}/linux
	cp ${DIR}/rock5b_defconfig arch/arm64/configs/
	CROSS_COMPILE=${CROSS_COMPILE} ARCH=${ARCH} make rock5b_defconfig
	CROSS_COMPILE=${CROSS_COMPILE} ARCH=${ARCH} make -j$(($(nproc) + 1))
	mkdir -p ${BUILD}/boot
	cp ${LINUX_IMAGE} ${BUILD}/boot/
	cp ${LINUX_DTB} ${BUILD}/boot/
	popd
}

linux_clean() {
	echo "no clean yet"
}
