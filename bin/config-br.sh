#!/bin/bash

### BEGIN VARIABLES
SCRIPT_DIR="$(cd -P `dirname ${BASH_SOURCE[0]}` && pwd)"
FOG_DIR="$(cd -P ${SCRIPT_DIR}/.. && pwd)"
FOG_BUILD="${FOG_DIR}/build"

BUILDROOT_VERSION="buildroot-2015.05"
BUILDROOT_DL="http://buildroot.uclibc.org/downloads/${BUILDROOT_VERSION}.tar.gz"
BUILDROOT_DIR="${FOG_DIR}/src/buildroot"
### END VARIABLES

mkdir -p $FOG_BUILD
cd $FOG_BUILD

wget $BUILDROOT_DL
tar -xzvf ${BUILDROOT_VERSION}.tar.gz

cd $BUILDROOT_VERSION

patch -p1 < ${BUILDROOT_DIR}/buildroot-fog.patch
cp -Rv ${BUILDROOT_DIR}/{package,system,configs,fog-imager*} ${FOG_BUILD}/${BUILDROOT_VERSION}

# TODO - If x86_64
  # cp -v ${FOG_BUILD}/${BUILDROOT_VERSION/{fog-imager.buildroot.config.64,.config}
  # TODO - Replace BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE=""
  # with: BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="${FOG_BUILD}/${BUILDROOT_VERSION}/configs/fog_x86_64_defconfig"
# else
  # cp -v ${FOG_BUILD}/${BUILDROOT_VERSION/{fog-imager.buildroot.config.32,.config}
  # TODO - Replace BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE=""
  # with: BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="${FOG_BUILD}/${BUILDROOT_VERSION}/configs/fog_x86_defconfig"
# fi
