FROM ubuntu:17.10

ENV GIT_NAME Example John
ENV GIT_EMAIL john@example.org
ENV MAKE_JOBS 8

WORKDIR /root/gateway

ADD ./build /root/gateway

RUN \
	dpkg --add-architecture i386 && apt-get update && apt-get -y update && \
	apt-get -y install android-tools-adb android-tools-fastboot autoconf \
	automake bc bison build-essential cscope curl device-tree-compiler flex \
	ftp-upload gdisk iasl libattr1-dev libc6:i386 libcap-dev libfdt-dev \
	libftdi-dev libglib2.0-dev libhidapi-dev libncurses5-dev \
	libpixman-1-dev libssl-dev libstdc++6:i386 libtool libz1:i386 make \
	mtools netcat python-crypto python-serial python-wand unzip uuid-dev \
	xdg-utils xterm xz-utils zlib1g-dev git repo
RUN \
	git config --global user.name $GIT_NAME && \
	git config --global user.email $GIT_EMAIL
RUN \
	repo init -u https://github.com/AdjustmentBeaver/gateway.git -m repo/rpi3.xml && \
	repo sync
RUN \
	cd build && \
	make toolchains && \
	make -j $MAKE_JOBS
