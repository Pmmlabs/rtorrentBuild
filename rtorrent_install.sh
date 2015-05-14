#!/bin/bash

sigc="libsigc++-2.4.1"
libtorrent="libtorrent-0.13.4"
rtorrent="rtorrent-0.9.4"

wget http://ftp.gnome.org/pub/GNOME/sources/libsigc++/2.4/$sigc.tar.xz
wget http://libtorrent.rakshasa.no/downloads/$libtorrent.tar.gz
wget http://libtorrent.rakshasa.no/downloads/$rtorrent.tar.gz

tar xf $sigc.tar.xz
tar xfz $libtorrent.tar.gz
tar xfz $rtorrent.tar.gz

rm -f $sigc.tar.xz $libtorrent.tar.gz $rtorrent.tar.gz

cd ./$sigc
./configure --prefix=`pwd`/../dist && make && make install

cd ../$libtorrent
./configure --prefix=`pwd`/../dist PKG_CONFIG_PATH=`pwd`/../dist/lib/pkgconfig/ && make && make install

cd ../$rtorrent
./configure --prefix=`pwd`/../dist PKG_CONFIG_PATH=`pwd`/../dist/lib/pkgconfig/ && make && make install

cd ..
mkdir ./dist/bin/download
mkdir ./dist/bin/session

echo -e "encoding_list = UTF-8\n\
download_rate = 1000\n\
upload_rate = 1000\n\
directory = ./download\n\
session = ./session\n\
session_save = yes\n\
check_hash = no\n\
use_udp_trackers = yes\n\
dht = auto\n\
dht_port = 7011\n\
port_range=7000-7010\n\
peer_exchange = yes" > ./dist/bin/rtorrent.rc

echo -e "while true; do; ./rtorrent -o import=./rtorrent.rc; done" > ./dist/bin/rt.sh
chmod +x ./dist/bin/rt.sh
