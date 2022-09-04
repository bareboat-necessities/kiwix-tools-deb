#!/bin/bash -e

sudo apt-get -y install meson cmake make git \
 dpkg-dev debhelper devscripts equivs pkg-config

#sudo apt-get -y install python3-pip virtualenv
#
#virtualenv -p python3 ./ # Create virtualenv
#source bin/activate      # Activate the virtualenv
#
#git clone --recurse-submodules --remote-submodules https://github.com/kiwix/kiwix-build.git
#cd kiwix-build
#pip3 install .
#hash -r # Refresh bash paths

sudo apt-get -y install meson cmake make git \
 dpkg-dev debhelper devscripts equivs pkg-config \
 libpugixml-dev libmicrohttpd-dev libicu-dev libcurl4-openssl-dev zlib1g-dev aria2

sudo apt-get -y install liblzma-dev libicu-dev libzstd-dev libxapian-dev libcurl4-gnutls-dev
rm -rf libzim
git clone --recurse-submodules --remote-submodules https://github.com/openzim/libzim
cd libzim
sed -i 's/0.0.0/7.2.0.0/g' debian/changelog
dpkg-buildpackage -b -d -uc -us
cd ..
sudo dpkg -i libzim7_*.deb libzim-dev_*.deb


rm -rf libkiwix
git clone --recurse-submodules --remote-submodules https://github.com/kiwix/libkiwix/
cd libkiwix
cd include && wget https://raw.githubusercontent.com/kainjow/Mustache/master/mustache.hpp && cd ..
sudo cp include/mustache.hpp /usr/include/
dpkg-buildpackage -b -d -uc -us
cd ..
sudo dpkg -i libkiwix10_*.deb libkiwix-dev_*.deb

rm -rf kiwix-tools
git clone --recurse-submodules --remote-submodules https://github.com/kiwix/kiwix-tools/
cd kiwix-tools
dpkg-buildpackage -b -d -uc -us
cd ..

sudo dpkg -i kiwix-tools_*.deb
