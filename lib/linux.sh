#!/bin/bash -ex

#ORIGIN=https://github.com/torvalds/linux.git
#ORIGIN=https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable
#PANTHOR=https://gitlab.freedesktop.org/bbrezillon/linux.git
#PANTHOR_BRANCH=panthor-debug

ORIGIN=https://github.com/jdpanderson/linux.git
BRANCH=rock5b-panthor

CROSS_COMPILE=aarch64-linux-gnu-
ARCH=arm64

linux_source() {
	git_source linux ${ORIGIN} ${BRANCH}
#	if [ -d ${BUILD}/linux ]; then
#		pushd ${BUILD}/linux
#		git pull
#		popd
#	else
#		mkdir -p ${BUILD}
#		pushd ${BUILD}
#		git checkout --depth 1 --branch ${BRANCH} ${ORIGIN} linux
#		popd
#	fi
}

linux_build() {
	pushd ${BUILD}/linux
	cp ${DIR}/rock5b_defconfig arch/arm64/configs/
	CROSS_COMPILE=${CROSS_COMPILE} ARCH=${ARCH} make rock5b_defconfig
	CROSS_COMPILE=${CROSS_COMPILE} ARCH=${ARCH} make -j$(($(nproc) + 1))
	popd
}

linux_clean() {
	echo "no clean yet"
}
