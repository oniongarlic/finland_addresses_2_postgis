#!/bin/bash

set -e

echo "Assuming an apt system"

echo "Assuming that a suitable postgresql+postgis+dev packages are already installed"

echo "Installing required build packages"
sudo apt install build-essential cmake g++ libboost-dev libboost-system-dev \
                    libboost-filesystem-dev libexpat1-dev zlib1g-dev \
                    libbz2-dev libpq-dev libproj-dev \
                    php7.2-cli php7.2-pgsql php7.2-intl libicu-dev \
                    python3-psycopg2 python3-psutil python3-jinja2 python3-icu python3-pip

echo "Python modules..."
sudo pip3 install python-dotenv

echo "Checking for Nominatim sources..."
if [ ! -f Nominatim-4.0.0.tar.bz2 ]; then
 echo "Downloading..."
 wget https://www.nominatim.org/release/Nominatim-4.0.0.tar.bz2
fi

if [ -d build ]; then
 echo "Removing previous build and starting from scratch"
 rm -r build
fi
mkdir build

echo "Extracting nominatim sources..."
tar xf Nominatim-4.0.0.tar.bz2 -C build

echo "Building nominatim"
cd build && mkdir nominatim && cd nominatim && cmake ../Nominatim-4.0.0 && make -j4

echo "Installing nominatim"
sudo make install

echo "Done!"
