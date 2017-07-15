#! /bin/bash

# クリーンインストールしたら
# とりあえず最初に実行しとけ

while true; do
	echo -n "このファイルinit.shは~/work/dotfilesに置かれていますか？ (y/n) : "
	read check
	if [ "${check}" == "y" ]; then
		break
	elif [ "${check}" == "n" ]; then
		echo "init.shは~/work/dotfiles/init.shに置かれなければなりません"
		echo "正しい位置に置いてください"
		echo "mkdir ~/work"
		echo "cd ~/work"
		echo "git clone http://git:kumamon@git.xcd0.com/git/dot.git"
		echo "でできます"
		exit 1
	fi
	echo "yかnです"
done



if [ "$(uname)" == 'Darwin' ]; then
	OS='Mac'
	while true; do
		echo -n "Macですね? (y/n) : "
		read check
		if [ "${check}" == "y" ]; then
			break
		else
			echo "まじっすか... 手作業よろ"
			echo "終了します"
			exit 1
		fi
	done

elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	OS='Linux'
	while true; do
		echo "Debian系のみ実行してね♥ (RHEL? 知らない子ですね)"
		echo -n "Linuxですね? (y/n) : "
		read check
		if [ "${check}" == "y" ]; then
			break
		else
			echo "まじっすか... 手作業よろ"
			echo "終了します"
			exit 1
		fi
	done

	# 英語化
	echo "ホームディレクトリを英語化"
	export LANG=C xdg-user-dirs-gtk-update
	export LANG=ja_JP.UTF-8
	echo "ホームディレクトリを英語化しました"

	echo "いろいろインストールします"
	sudo aptitude install -y make cmake gcc vim
	sudo aptitude install -y python-dev python-pip python3-dev python3-pip
	pip3 install neovim

	# latex
	echo "Latex関係のインストールをします"
	sudo aptitude install -y tex-live-lang-cjk
	sudo cp ~/work/dotfiles/sty/* /usr/share/texlive/texmf-dist/tex/latex/
	sudo mktexlsr

	# neovimのインストール
	echo "neovimをインストールします"
	sudo aptitude install software-properties-common
	echo "リポジトリを追加しようとします"
	echo "ダメでも気にしない"
	sudo add-apt-repository ppa:neovim-ppa/unstable
	sudo aptitude update
	sudo aptitude install neovim

elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	OS='Cygwin'
	while true; do
		echo -n "windowsですね? (y/n) : "
		read check
		if [ "${check}" == "y" ]; then
			break
		else
			echo "まじっすか... 手作業よろ"
			echo "終了します"
			exit 1
		fi
	done

else
	echo "Your platform ($(uname -a)) is not supported."
	exit 1
fi

#for f in `ls $dir`; do
#done


# OS共通



# pyenv
echo "pyenvをインストールします"
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

# rbenv
echo "rbenvをインストールします"
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# golang
echo "golangをインストールします"
echo "go1.4をビルドします"
# go1.4
dir=$HOME/work/go
mkdir $HOME/work/go
cd $dir
git clone https://github.com/golang/go	>/dev/null 2>&1
cp go go1.4
cd go1.4
git checkout release-branch.go1.4	>/dev/null 2>&1
export GOROOT_BOOTSTRAP=$dir/go1.4
if [ "$(uname)" == 'Darwin' ]; then
	$dir/go1.4/src/make.bash
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	$dir/go1.4/src/make.bash
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	$dir/go1.4/src/make.bat
fi
export PATH=$dir/go1.4/bin:$PATH

echo "最新版のgolangをビルドします"
cd $dir/go/src
if [ "$(uname)" == 'Darwin' ]; then
	$dir/go/src/all.bash
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	$dir/go/src/all.bash
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	$dir/go/src/all.bat
fi


cd
mkdir work/usr
mkdir work/bin
mkdir work/usr/local
mkdir work/usr/local/bin
