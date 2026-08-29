#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q xsnow | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/pixmaps/xsnow.svg
export DESKTOP=/usr/share/applications/xsnow.desktop
export STARTUPWMCLASS=Xsnow
export USE_HOST_DRIVERS_EXPERIMENTAL=1

# Deploy dependencies
quick-sharun /usr/bin/xsnow

# Turn AppDir into AppImage
quick-sharun --make-appimage
