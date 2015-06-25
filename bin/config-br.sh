#!/bin/bash

### BEGIN VARIABLES
SCRIPT_DIR="$(cd -P `dirname ${BASH_SOURCE[0]}` && pwd)"
FOG_DIR="$(cd -P ${SCRIPT_DIR}/.. && pwd)"
FOG_BUILD="${FOG_DIR}/build"

BUILDROOT_VERSION="buildroot-2015.05"
BUILDROOT_DL="http://buildroot.uclibc.org/downloads/${BUILDROOT_VERSION}.tar.gz"
BUILDROOT_DIR="${FOG_DIR}/src/buildroot"

### END VARIABLES

# Ensure one argument is provided
if [ "$#" != "1" ]; then
	echo "FATAL! Script $0 not provided with an argument."
	exit 1
fi

### BEGIN DYNAMIC VARIABLES
arch=$1

if [ "$arch" = "64" ]; then
	brConfig="fog-imager.buildroot.config.64"
	defconfig="${FOG_BUILD}/${BUILDROOT_VERSION}/configs/fog_x86_64_defconfig"
elif [ "$arch" != "32" ]; then
	brConfig="fog-imager.buildroot.config.32"
	defconfig="${FOG_BUILD}/${BUILDROOT_VERSION}/configs/fog_x86_defconfig"
else
	echo "FATAL! Script $0 expects "64" or "32" for argument."
	exit 2
fi

confVar="BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="
sedPat="s|^${confVar}\"\"\$|${confVar}\"${defconfig}\"|g"
### END DYNAMIC VARIABLES

mkdir -p $FOG_BUILD
cd $FOG_BUILD

if [ ! -f "$BUILDROOT_DL" ]; then
	wget $BUILDROOT_DL
fi
tar -xzvf ${BUILDROOT_VERSION}.tar.gz

cd $BUILDROOT_VERSION

# Apply updates to buildroot
patch -p1 < ${BUILDROOT_DIR}/buildroot-fog.patch
cp -Rv ${BUILDROOT_DIR}/{package,system,configs,fog-imager*} ${FOG_BUILD}/${BUILDROOT_VERSION}

# Modify buildroot config to point to correct defconfig

sed -i $sedPat $brConfig
cp -v ${FOG_BUILD}/${BUILDROOT_VERSION}/{${brConfig},.config}
