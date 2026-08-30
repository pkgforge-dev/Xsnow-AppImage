#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm atk cairo gsl libx11 libxpm libxml2

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

# Comment this out if you need an AUR package
#make-aur-package xsnow

# If the application needs to be manually built that has to be done down here

# if you also have to make nightly releases check for DEVEL_RELEASE = 1
echo "Building Xsnow..."
echo "---------------------------------------------------------------"
VERSION=3.9.4
echo "$VERSION" > ~/version
wget https://www.ratrabbit.nl/downloads/xsnow/xsnow-$VERSION.tar.gz


mkdir -p ./AppDir/bin
cd ./xsnow-$VERSION
./configure
make -j$(nproc)
mv -v src/xsnow ../AppDir/bin
