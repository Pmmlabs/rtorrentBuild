#!/bin/bash

screen=screen-4.3.1

wget http://ftp.gnu.org/gnu/screen/$screen.tar.gz
tar xfz $screen.tar.gz
rm -f $screen.tar.gz
cd $screen
./configure --prefix=`pwd`/dist && make && make install
