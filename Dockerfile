FROM ubuntu:18.04

ARG DEBIAN_FRONTEND=noninteractive

MAINTAINER CircuitBreaker <sarris88p@gmail.com>

RUN apt-get update && apt-get -y upgrade \
&& apt-get install -y git unzip build-essential libdb++-dev libboost-all-dev libqrencode-dev libminiupnpc-dev libevent-dev autogen automake libtool libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools qt5-default libcurl4-openssl-dev \
&& apt-get -y install git

RUN apt-get -y install make \
&& apt-get -y install wget \
&& wget https://www.openssl.org/source/openssl-1.0.1j.tar.gz \
&& tar -xzvf openssl-1.0.1j.tar.gz \
&& cd openssl-1.0.1j \
&& ./config \
&& make depend \
&& make install \
&& ln -sf /usr/local/ssl/bin/openssl `which openssl` \
&& cd ~

RUN git clone https://github.com/innova-foundation/innova \
&& cd innova \
&& sed -i 's/LIBS += -lcurl -lssl -lcrypto -lcrypt32 -lssh2 -lgcrypt -lidn2 -lgpg-error -lunistring -lwldap32 -ldb_cxx$$BDB_LIB_SUFFIX/LIBS += -lcurl -lssl -lcrypto -ldb_cxx$$BDB_LIB_SUFFIX/' innova-qt.pro \
&& strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5 \
&& qmake "USE_UPNP=1" "USE_QRCODE=1" OPENSSL_INCLUDE_PATH=/usr/local/ssl/include OPENSSL_LIB_PATH=/usr/local/ssl/lib innova-qt.pro \
&& make \
&& strip Innova

ADD mount/dotfiles /root
ADD mount/etc /etc

EXPOSE 14530 14531 15530 15531 14539 15539
