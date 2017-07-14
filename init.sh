#! /bin/bash

cd
mkdir work
mkdir work/usr
mkdir work/bin
mkdir work/usr/local
mkdir work/usr/local/bin

if [ "$(uname)" == 'Darwin' ]; then
	OS='Mac'

elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	OS='Linux'

	# 英語化
	export LANG=C xdg-user-dirs-gtk-update
	export LANG=ja_JP.UTF-8
	sudo apt-get install python-dev python-pip python3-dev python3-pip
	pip3 install neovim

	# その他も突っ込む
	sudo aptitude install make cmake gcc vim

	# latex
	sudo aptitude install tex-live-lang-cjk
	sudo cp ~/work/dotfiles/linux/sty/* /usr/share/texlive/texmf-dist/tex/latex/
	sudo mktexlsr

	# neovimのインストール
	sudo aptitude install software-properties-common
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo aptitude update
	sudo aptitude install neovim

elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	OS='Cygwin'

else
	echo "Your platform ($(uname -a)) is not supported."
	exit 1
fi

#for f in `ls $dir`; do
done


# OS共通



# pyenv
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

# rbenv
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# golang
# go1.4
dir=$HOME/work/go
mkdir $HOME/work/go
cd $dir
git clone https://github.com/golang/go
cp go go1.4
cd go1.4
git checkout release-branch.go1.4
export GOROOT_BOOTSTRAP=$dir/go1.4
if [ "$(uname)" == 'Darwin' ]; then
	$dir/go1.4/src/make.bash
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	$dir/go1.4/src/make.bash
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	$dir/go1.4/src/make.bat
fi

export PATH=$dir/go1.4/bin:$PATH
cd $dir/go/src
if [ "$(uname)" == 'Darwin' ]; then
	$dir/go/src/all.bash
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	$dir/go/src/all.bash
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	$dir/go/src/all.bat
fi


