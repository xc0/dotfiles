#! /bin/bash

cd

if [ "$(uname)" == 'Darwin' ]; then
	OS='Mac'
	dir=~/work/dotfiles/mac/
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	OS='Linux'
	dir=~/work/dotfiles/linux/
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then                                                                                           
	OS='Cygwin'
	dir=~/work/dotfiles/cygwin/
else
	echo "Your platform ($(uname -a)) is not supported."
	exit 1
fi

for f in `ls $dir`; do
	ln $dir/$f
done

