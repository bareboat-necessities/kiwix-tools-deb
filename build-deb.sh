#!/bin/bash -e

sudo apt-get -y install meson cmake make git \
 dpkg-dev debhelper devscripts equivs pkg-config ninja

rm -rf kiwix-tools
git clone https://github.com/kiwix/kiwix-tools/

cd kiwix-tools
dpkg-buildpackage -b -d -uc -us


