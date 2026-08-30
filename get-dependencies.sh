#!/bin/sh

set -eu

ARCH=$(uname -m)

echo "Installing package dependencies..."
echo "---------------------------------------------------------------"
pacman -Syu --noconfirm \
    atk    \
    cairo  \
    gsl    \
    libxpm

echo "Installing debloated packages..."
echo "---------------------------------------------------------------"
get-debloated-pkgs --add-common --prefer-nano

echo "Building stable version of Xsnow..."
echo "---------------------------------------------------------------"
VERSION=3.9.0
echo "$VERSION" > ~/version
wget https://www.ratrabbit.nl/downloads/xsnow/xsnow-$VERSION.tar.gz
tar -xvf ./xsnow-$VERSION.tar.gz

mkdir -p ./AppDir/bin
cd ./xsnow-$VERSION
./configure
make -j$(nproc)
mv -v src/xsnow ../AppDir/bin
