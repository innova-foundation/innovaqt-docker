FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

LABEL maintainer "CircuitBreaker <sarris88p@gmail.com>"

RUN apt-get update && apt-get -y upgrade \
&& apt-get install -y git unzip build-essential libssl-dev libgmp-dev libsecp256k1-dev libdb++-dev libboost-all-dev libqrencode-dev libminiupnpc-dev libevent-dev autogen automake libtool libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools qt5-default libcurl4-openssl-dev \
&& apt-get -y install git


RUN git clone https://github.com/innova-foundation/innova \
&& cd innova \
&& git checkout secp256k1 \
&& sed -i 's/LIBS += -lcurl -lssl -lcrypto -lcrypt32 -lssh2 -lgcrypt -lidn2 -lgpg-error -lunistring -lwldap32 -ldb_cxx$$BDB_LIB_SUFFIX/LIBS += -lcurl -lssl -lcrypto -ldb_cxx$$BDB_LIB_SUFFIX/' innova-qt.pro \
#&& strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5 \
&& qmake "USE_UPNP=1" "USE_QRCODE=1" "USE_NATIVETOR=-" innova-qt.pro \
&& make \
&& strip Innova

ADD mount/dotfiles /root
ADD mount/etc /etc

EXPOSE 14530 14531 15530 15531 14539 15539
