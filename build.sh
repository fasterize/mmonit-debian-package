#!/bin/sh -e

MMONIT_BINARY_URL="https://mmonit.com/dist/mmonit-3.5.1-linux-x64.tar.gz"
DEBIAN_DIR=`pwd`
BUILD_FOLDER=/tmp/build-mmonit
BUILD_RESULT=/tmp/incoming

echo "Cleanup ..."
[ -d $BUILD_FOLDER ] && rm -rf $BUILD_FOLDER
[ -d $BUILD_RESULT ] && rm -rf $BUILD_RESULT

echo "Dowloading MMonit binary"
wget $MMONIT_BINARY_URL -O /tmp/mmonit.tar.gz

echo "Preparing build folder"
mkdir $BUILD_FOLDER

cp -r ${DEBIAN_DIR}/*  ${BUILD_FOLDER}/

cd $BUILD_FOLDER
mkdir usr && mkdir usr/local && mkdir usr/local/mmonit

tar -C usr/local/mmonit/ --strip-components=1 -xvf /tmp/mmonit.tar.gz
rm -r usr/local/mmonit/logs 


echo "Build the debian package"
# build package
mkdir $BUILD_RESULT
dpkg-deb -b $BUILD_FOLDER ${BUILD_RESULT}/ 
