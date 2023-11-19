#!/bin/bash
##############################################################################################
##
## Dragonfire Minetest Client Compile script for Ubuntu/Mint/Debian/Fedora/Arch/Alpine
##
## v1.0
## Author: Flora Mae Wolfe
## URL: 
##
##############################################################################################

# Check the distro

if command -v apt-get >/dev/null; then
  echo "Detected Debian/Ubuntu based distro..."
  distro='apt'
elif command -v dnf >/dev/null; then
  echo "Detected Fedora based distro..."
  distro='dnf'
elif command -v pacman >/dev/null; then
  echo "Detected Arch based distro"
  distro='pacman'
elif command -v apk >/dev/null; then
  echo "Detected Alpine based distro"
  distro='apk'
else
  echo "Your distro is not supported by this script yet."
  exit
fi


## Download/Install dependencies

# Debian/Ubuntu/Mint
if [[ $distro == *"apt"* ]]; then
  echo "Downloading dependencies..."
  sudo apt install g++ make libc6-dev cmake libpng-dev libjpeg-dev libxxf86vm-dev libgl1-mesa-dev libsqlite3-dev libogg-dev libvorbis-dev libopenal-dev libcurl4-gnutls-dev libfreetype6-dev zlib1g-dev libgmp-dev libjsoncpp-dev libzstd-dev libluajit-5.1-dev libxcb-cursor0 git
  echo "If no errors, dependencies have been installed, proceeding..."
fi

# Fedora
if [[ $distro == *"dnf"* ]]; then
  echo "Downloading dependencies..."
  sudo dnf install make automake gcc gcc-c++ kernel-devel cmake libcurl-devel openal-soft-devel libvorbis-devel libXxf86vm-devel libogg-devel freetype-devel mesa-libGL-devel zlib-devel jsoncpp-devel gmp-devel sqlite-devel luajit-devel leveldb-devel ncurses-devel spatialindex-devel libzstd-devel
  echo "If no errors, dependencies have been installed, proceeding..."
fi

# Arch
if [[ $distro == *"pacman"* ]]; then
  echo "Downloading dependencies..."
  sudo pacman -S base-devel libcurl-gnutls cmake libxxf86vm libpng sqlite libogg libvorbis openal freetype2 jsoncpp gmp luajit leveldb ncurses zstd
  echo "If no errors, dependencies have been installed, proceeding..."
fi

# Alpine
if [[ $distro == *"apk"* ]]; then
  echo "Downloading dependencies..."
  sudo apk add build-base cmake libpng-dev jpeg-dev libxxf86vm-dev mesa-dev sqlite-dev libogg-dev libvorbis-dev openal-soft-dev curl-dev freetype-dev zlib-dev gmp-dev jsoncpp-dev luajit-dev zstd-dev
  echo "If no errors, dependencies have been installed, proceeding..."
fi

## Compiling

# Fetching the sources
git clone --depth 1 https://github.com/dragonfireclient/dragonfireclient
cd dragonfireclient
git clone --depth 1 https://github.com/minetest/minetest_game.git games/minetest_game
git clone --branch 1.9.0mt7 --depth 1 https://github.com/minetest/irrlicht.git lib/irrlichtmt

# Applying unreasonable force
cmake . -DRUN_IN_PLACE=TRUE
make -j$(nproc)

echo "Hopefully no errors, if you don't see a ./bin/minetest"
echo "Then something didn't go right"
