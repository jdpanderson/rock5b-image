#!/bin/bash -ex

#ORIGIN=https://github.com/torvalds/linux.git
ORIGIN=https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable
PANTHOR=https://gitlab.freedesktop.org/bbrezillon/linux.git
PANTHOR_BRANCH=panthor-debug

CROSS_COMPILE=aarch64-linux-gnu-
ARCH=arm64

linux_source() {
	if [ -d ${BUILD}/linux ]; then
		return
	fi
	mkdir -p ${BUILD}
	pushd ${BUILD}
	git submodule add ${ORIGIN} linux
	pushd linux
	git remote add panthor ${PANTHOR}
	git fetch panthor
	git checkout -b rock5b-panthor
	git reset --hard panthor/${PANTHOR_BRANCH}
	git merge v6.5.5
	popd
	popd
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
