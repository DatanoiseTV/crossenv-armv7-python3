FROM 32bit/ubuntu:16.04

ENV TOOLCHAIN_PREFIX=/usr/local/gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux/arm-linux-gnueabihf/bin
ENV PATH=/usr/local/bin:$PATH:$TOOLCHAIN_PREFIX/bin
ENV ARCH=arm
ENV CROSS_COMPILE=arm-linux-gnueabihf-
ENV TOOL_PREFIX=/usr/local/gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux/bin/arm-linux-gnueabihf
ENV CXX=$TOOL_PREFIX-g++
ENV CPP="$TOOL_PREFIX-g++ -E"
ENV AR=$TOOL_PREFIX-ar
ENV RANLIB=$TOOL_PREFIX-ranlib
ENV CC=$TOOL_PREFIX-gcc
ENV LD=$TOOL_PREFIX-ld
ENV READELF=$TOOL_PREFIX-readelf
ENV PYTHON_VERSION=3.5.1

RUN apt-get update
RUN apt-get -y install wget build-essential make gawk flex bison tar bzip2 file python3 elfutils libgcc1-armhf-cross libgcc1

ADD ./get_toolchain.sh /get_toolchain.sh
RUN chmod +x /get_toolchain.sh && /get_toolchain.sh

# This is very hacked together, fix me.
RUN cp -r /usr/local/gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux/arm-linux-gnueabihf/libc/lib/* /lib/
RUN cp -r ./usr/local/gcc-linaro-arm-linux-gnueabihf-4.7-2013.03-20130313_linux/arm-linux-gnueabihf/lib/* /lib/
RUN wget https://www.python.org/ftp/python/3.5.1/Python-3.5.1.tar.xz
RUN tar -Jxvf Python-3.5.1.tar.xz -C /tmp/
RUN echo ac_cv_file__dev_ptmx=no > /tmp/Python-3.5.1/config.site
RUN echo ac_cv_file__dev_ptc=no >> /tmp/Python-3.5.1/config.site
RUN cd /tmp/Python-3.5.1/ && CONFIG_SITE=config.site ./configure --host=arm-linux-gnueabihf --prefix=/build --build=x86_64-linux-gnu --with-system-expat --with-system-ffi --disable-ipv6 --with-ensurepip=yes
RUN cd /tmp/Python-3.5.1 && make && make install

RUN apt install -y curl
RUN curl -o /get-pip.py https://bootstrap.pypa.io/get-pip.py
RUN python3 /get-pip.py --prefix=/build
