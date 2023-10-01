#!/bin/bash -ex

#ORIGIN=https://gitlab.collabora.com/hardware-enablement/rockchip-3588/rkbin.git
RKBIN_ORIGIN=https://github.com/radxa/rkbin.git
RKBIN_BRANCH=master

rkbin_source() {
	source_git rkbin ${RKBIN_ORIGIN} ${RKBIN_BRANCH}
}
