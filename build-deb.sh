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
sed -i 's/0.0.0/10.1.1.0/g' debian/changelog
cd include && wget https://raw.githubusercontent.com/kainjow/Mustache/master/mustache.hpp && cd ..
sudo cp include/mustache.hpp /usr/include/
dpkg-buildpackage -b -d -uc -us
cd ..
sudo dpkg -i libkiwix10_*.deb libkiwix-dev_*.deb

rm -rf kiwix-tools
git clone --recurse-submodules --remote-submodules https://github.com/kiwix/kiwix-tools/
cd kiwix-tools
sed -i 's/0.0.0/3.3.0.0/g' debian/changelog
dpkg-buildpackage -b -d -uc -us
cd ..
sudo dpkg -i kiwix-tools_*.deb

sudo apt-get install -y libqt5gui5 qtbase5-dev qtwebengine5-dev \
     libqt5svg5-dev qt5-image-formats-plugins aria2 \
     qttools5-dev-tools qtchooser qt5-qmake \
     qtbase5-dev-tools
rm -rf kiwix-desktop
git clone --recurse-submodules --remote-submodules https://github.com/kiwix/kiwix-desktop
cd kiwix-desktop
sed -i 's/0.0.0/2.2.0.0/g' debian/changelog
dpkg-buildpackage -b -d -uc -us
cd ..
