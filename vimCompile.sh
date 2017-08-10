#! /bin/bash

make clean
make distclean
./configure --prefix=$HOME/work/usr/local \
--with-features=huge \
--disable-gui \
--disable-darwin \
--disable-selinux \
--enable-multibyte \
--enable-terminal \
--disable-rubyinterp \
--enable-fail-if-missing
#--enable-perlinterp \
#--with-luajit \
#--enable-luainterp \
#--without-x \
make -j4
make install
