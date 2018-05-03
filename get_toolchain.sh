#!/bin/bash

if [ ! -f /tmp/gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux.tar.bz2 ] ; then
    wget -O /tmp/gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux.tar.bz2 https://releases.linaro.org/archive/13.03/components/toolchain/binaries/gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux.tar.bz2
    tar xfvj /tmp/gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux.tar.bz2 -C /usr/local/
    exit 0
fi
