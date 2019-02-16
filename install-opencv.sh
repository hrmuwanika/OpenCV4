#!/bin/bash

######################################
# INSTALL OPENCV ON UBUNTU OR DEBIAN #
######################################

# |          THIS SCRIPT IS TESTED CORRECTLY ON          |
# |------------------------------------------------------|
# | OS               | OpenCV       | Test | Last test   |
# |------------------|--------------|------|-------------|
# | Ubuntu 18.04 LTS | OpenCV 4.0.1 | OK   | 16 Feb 2019 |
# | Debian 9.7       | OpenCV 4.0.1 | OK   | 16 Feb 2019 |
# |----------------------------------------------------- |

# VERSION TO BE INSTALLED
OPENCV_VERSION='4.0.1'

# 1. KEEP UBUNTU OR DEBIAN UP TO DATE

apt-get -y update
apt-get -y upgrade       
# apt-get -y dist-upgrade  # Uncomment this line to, in addition to 'upgrade', handles changing dependencies with new versions of packages
# apt-get -y autoremove    # Uncomment this line to remove packages that are now no longer needed

# 2. INSTALL THE DEPENDENCIES

# Build tools:
apt-get install -y build-essential cmake

# GUI (if you want to use GTK instead of Qt, replace 'qt5-default' with 'libgtkglext1-dev' and remove '-DWITH_QT=ON' option in CMake):
apt-get install -y qt5-default libvtk6-dev

# Media I/O:
apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev libopenexr-dev libgdal-dev

# Video I/O:
apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev

# Parallelism and linear algebra libraries:
apt-get install -y libtbb-dev libeigen3-dev

# Python:
apt-get install -y python-dev python-tk python-numpy python3-dev python3-tk python3-numpy

# Java:
apt-get install -y ant default-jdk

# Documentation:
apt-get install -y doxygen

# 3. INSTALL THE LIBRARY
apt-get install -y unzip wget
wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip
unzip ${OPENCV_VERSION}.zip
rm ${OPENCV_VERSION}.zip
mv opencv-${OPENCV_VERSION} OpenCV
cd OpenCV
mkdir build
cd build
cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DWITH_XINE=ON -DBUILD_EXAMPLES=ON -DENABLE_PRECOMPILED_HEADERS=OFF ..
make -j4
make install
ldconfig

python3
import cv2
print('opencv: %s' % cv2.__version__)

# 4. EXECUTE SOME OPENCV EXAMPLES AND COMPILE A DEMONSTRATION
# To complete this step, please visit 'http://milq.github.io/install-opencv-ubuntu-debian'.
