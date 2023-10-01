#!/bin/bash -ex

# Note: This is not a build system. This is just a script that serves to document and reproduce how I built rock5b images

source lib/vars.sh
source lib/linux.sh
source lib/uboot.sh

linux_source
linux_build

uboot_source
uboot_bin
uboot_build
