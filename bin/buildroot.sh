#!/bin/bash

### BEGIN VARIABLES
SCRIPT_DIR="$(cd -P `dirname ${BASH_SOURCE[0]}` && pwd)"
FOG_DIR="$(cd -P ${SCRIPT_DIR}/.. && pwd)"
FOG_BUILD="${FOG_DIR}/build"

BUILDROOT_VERSION="buildroot-2015.05"
BUILDROOT_DL="http://buildroot.uclibc.org/downloads/buildroot-2015.05.tar.gz"
BUILDROOT_DIR="${FOG_DIR}/src/buildroot"
### END VARIABLES

mkdir -p $FOG_BUILD
cd $FOG_BUILD

wget $BUILDROOT_DL
tar -xzvf ${BUILDROOT_VERSION}.tar.gz

cd $BUILDROOT_VERSION

patch -p1 < ${BUILDROOT_DIR}/buildroot-fog.patch
cp -Rv ${BUILDROOT_DIR}/{packages,system,configs,fog-imager*} ${FOG_BUILD}/${BUILDROOT_VERSION}
