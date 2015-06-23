#!/bin/bash

# DESCRIPTION: This script builds a useable ISO from the buildroot files.
#              Use of this script is only needed for testing or special needs.
# DEPENDENCIES: This script will need the same build tools as buildroot plus
#               nasm.

### BEGIN VARIABLES
ORIG_DIR=`pwd`
SCRIPT_DIR="$(cd -P `dirname ${BASH_SOURCE[0]}` && pwd)"
FOG_DIR="$(cd -P ${SCRIPT_DIR}/.. && pwd)"
FOG_BUILD="${FOG_DIR}/build"

ISO_OUTPUT="-o ${FOG_BUILD}/fog-img.iso"
ISO_FOPTS="-b isolinux/isolinux.bin -c isolinux/boot.cat"
ISO_OPTS="-no-emul-boot -boot-load-size 4 -boot-info-table"
ISO_BUILD_DIR="${FOG_BUILD}/iso"

BUILDROOT_VERSION="buildroot-2015.05"
BUILDROOT_IMAGES="${FOG_BUILD}/${BUILDROOT_VERSION}/output/images"

SYSLINUX_VERSION="syslinux-6.03"
SYSLINUX_DL="https://www.kernel.org/pub/linux/utils/boot/syslinux/${SYSLINUX_VERSION}.tar.xz"
### END VARIABLES

# Build syslinux
if [ ! -d "${FOG_BUILD}" ]; then
	# If there is no build directory, buildroot was probably not run.
	echo "FATAL! No build directory! No image available!"
	exit 1
fi

# Download and build syslinux
cd $FOG_BUILD
wget $SYSLINUX_DL
tar -Jxvf ${SYSLINUX_VERSION}.tar.xz
cd ${SYSLINUX_VERSION}
make

if [ -d "${ISO_BUILD_DIR}" ]; then
	rm -rf ${ISO_BUILD_DIR}
fi

mkdir -p ${ISO_BUILD_DIR}/{images,isolinux,kernel}
cp ${FOG_DIR}/src/iso/isolinux/isolinux.cfg ${ISO_BUILD_DIR}/isolinux/
# Move the following files from syslinux to isolinux directory
	cp ${FOG_BUILD}/${SYSLINUX_VERSION}/bios/com32/elflink/ldlinux/ldlinux.c32 \
		${ISO_BUILD_DIR}/isolinux/
	cp ${FOG_BUILD}/${SYSLINUX_VERSION}/bios/core/isolinux.bin \
		${ISO_BUILD_DIR}/isolinux/

cp ${BUILDROOT_IMAGES}/bzImage ${ISO_BUILD_DIR}/kernel/bzImage
cp ${BUILDROOT_IMAGES}/rootfs.ext2.xz ${ISO_BUILD_DIR}/images/fogimg.xz

genisoimage $ISO_OUTPUT $ISO_FOPTS $ISO_OPTS $ISO_BUILD_DIR
