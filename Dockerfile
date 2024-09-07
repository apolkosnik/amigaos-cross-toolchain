# To build and publish image run following commands:
# > docker build -t cahirwpz/amigaos-cross-toolchain:latest .
# > docker login
# > docker push cahirwpz/amigaos-cross-toolchain:latest

FROM debian:jessie

WORKDIR /root

RUN rm /etc/apt/sources.list

RUN echo "deb http://archive.debian.org/debian-security jessie/updates main" >> /etc/apt/sources.list.d/jessie.list

RUN echo "deb http://archive.debian.org/debian jessie main" >> /etc/apt/sources.list.d/jessie.list

RUN apt-get -o Acquire::Check-Valid-Until=false update

RUN apt-get -q update && apt-get upgrade -y
RUN apt-get install -y --force-yes --no-install-recommends \
            git-core make gettext patch bison flex gperf ca-certificates \
            gcc g++ gcc-multilib libc6-dev libncurses-dev \
            python2.7 libpython2.7-dev python-setuptools subversion
RUN git clone https://github.com/apolkosnik/amigaos-cross-toolchain.git && \
    cd amigaos-cross-toolchain && \
      ./toolchain-m68k --prefix=/usr/local build && \
      ./toolchain-m68k --prefix=/usr/local test && \
    cd .. && rm -rf amigaos-cross-toolchain
