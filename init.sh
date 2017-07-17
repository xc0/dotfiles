#! /bin/bash

# クリーンインストールしたら
# とりあえず最初に実行しとけ

# dotfiles {{{

echo -e "\n=======================\n"
echo "dotfileのシンボリックリンクを作成します "
if [ "$(uname)" == 'Darwin' ]; then
	OS='Mac'
	dir=~/work/dotfiles/mac
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	OS='Linux'
	dir=~/work/dotfiles/linux
elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	OS='Cygwin'
	dir=~/work/dotfiles/cygwin
else
	echo "Your platform ($(uname -a)) is not supported."
	exit 1
fi

date=`date +%s`
echo "リンク先ファイル一覧"
ls -al $dir
echo ""

if [ -L ~/.bashrc ]; then
	rm ~/.bashrc
fi
if [ -f ~/.bashrc ]; then
	echo ".bashrcが存在します"
	mv ~/.bashrc ~/.vimrc_$date
	echo ".bashrc_$dateにリネームしました"
fi

if [ -L ~/.vimrc ]; then
	rm ~/.vimrc
fi
if [ -f ~/.vimrc ]; then
	echo ".vimrcが存在します"
	mv ~/.vimrc ~/.vimrc_$date
	echo ".vimrc_$dateにリネームしました"
fi

if [ -L ~/.config/vim ]; then
	rm ~/.config/vim
fi
if [ -d ~/.config/vim ]; then
	echo "~/.config/vimが存在します"
	mv ~/.config/vim ~/.config/vim_$date
	echo "~/.config/vim_$dateにリネームしました"
fi

if [ -L ~/.config/nvim ]; then
	rm ~/.config/nvim
fi
if [ -d ~/.config/nvim ]; then
	echo ".config/nvimが存在します"
	mv ~/.config/nvim ~/.config/nvim_$date
	echo "~/.config/nvim_$dateにリネームしました"
fi

if [ -L ~/.local/share/fonts ]; then
	rm ~/.local/share/fonts
fi
if [ -d ~/.local/share/fonts ]; then
	echo ".config/nvim~/.local/share/fontsが存在します"
	mv ~/.local/share/fonts ~/.local/share/fonts_$date
	echo "~/.local/share/fonts_$dateにリネームしました"
fi

echo "dir is $dir"

cd ~
ln -sf $dir/.bashrc
ln -sf $dir/.vimrc

cd ~/.config/
ln -sf $dir/nvim
ln -sf $dir/vim

cd ~/.local/share
ln -sf $dir/fonts


echo -e "\n=======================\n"
echo "シンボリックリンクを作成しました"


echo ""
echo "$HOME"
ls -al ~ | grep .bashrc
ls -al ~ | grep .vimrc
echo ""
echo "~/.config/vim"
ls -al ~/.config/vim
echo ""
echo "~/.config/nvim"
ls -al ~/.config/nvim

# }}}

echo -n "goの設定までスキップしますか？ (Y/n) : "
read check
start=`date +%s`

if [ "${check}" == "n" ]; then


# gitSetting {{{
count=0
while true; do
	echo -n "gitの初期設定をしますか？ (y/N) : "
	read check
	if [ "${check}" == "y" ]; then
		echo "gitの設定をします"
		~/work/dotfiles/gitSetting.sh
		if [ "${?}" == "0" ]; then
			echo "gitの設定が正常終了しました"
			echo "アプリケーションのインストールを始めます"
			break
		else
			echo "gitの設定が正しく終了しませんでした"
			continue
		fi
	else
		echo "gitの設定をスキップします"
		break
	fi
done

# }}}


# よく使うアプリケーションのインストール {{{
count=0

while true; do
	echo -n "このファイルinit.shは~/work/dotfilesに置かれていますか？ (Y/n) : "
	read check
	if [ "${check}" == "n" ]; then
		echo "init.shは~/work/dotfiles/init.shに置かれなければなりません"
		echo "正しい位置に置いてください"
		echo "mkdir ~/work"
		echo "cd ~/work"
		echo "git clone http://git:kumamon@git.xcd0.com/git/dot.git"
		echo "でできます"
		echo "異常終了します"
		exit 1
	else
		break
	fi
done

count=0


if [ "$(uname)" == 'Darwin' ]; then
	OS='Mac'
	echo -n "Macですね? (Y/n) : "
	read check
	if [ "${check}" == "n" ]; then
		echo "まじっすか... OSが判断できませんでした"
		echo "手作業で実行してください"
		echo "異常終了します"
		exit 1
	else
		echo "未実装"
		break
	fi
elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
	OS='Linux'
	echo "Debian系のみ実行してね♥ (RHEL? 知らない子ですね)"
	echo -n "Linuxですね? (Y/n) : "
	read check
	if [ "${check}" == "n" ]; then
		echo "まじっすか... OSが判断できませんでした"
		echo "手作業で実行してください"
		echo "異常終了します"
		exit 1
	fi

	# 英語化
	echo -e "\n=======================\n"
	echo "ホームディレクトリを英語化します"
	echo "export LANG=C; xdg-user-dirs-gtk-update"
	bash `export LANG=C; xdg-user-dirs-gtk-update` &

	echo -e "\n=======================\n"
	echo "ソースリストをアップデートします"
	echo "sudo aptitude update"
	echo "不要なときはC-cでスキップします"
	sudo aptitude update > /dev/null 2>&1
	echo -e "\n=======================\n"
	echo "いろいろインストールします"
	echo "sudo aptitude install -y make cmake gcc vim curl wget"
	sudo aptitude install -y make cmake gcc vim curl wget
	echo "sudo aptitude install -y python-dev python-pip python3-dev python3-pip"
	sudo aptitude install -y python-dev python-pip python3-dev python3-pip
	echo "pip3 install neovim"
	pip3 install neovim

	# latex
	echo -e "\n=======================\n"
	echo "Latex関係のインストールをします"
	echo "sudo aptitude install -y tex-live-lang-cjk"
	sudo aptitude install -y tex-live-lang-cjk
	sudo cp ~/work/dotfiles/sty/* /usr/share/texlive/texmf-dist/tex/latex/
	sudo mktexlsr

	# neovimのインストール
	sudo aptitude install -y software-properties-common
	echo -e "\n=======================\n"
	echo "リポジトリを追加しようとします"
	echo "ダメでも気にしない"
	sudo add-apt-repository ppa:neovim-ppa/unstable
	echo "sudo aptitude update > /dev/null 2>&1"
	echo "不要なときはC-cでスキップします"
	sudo aptitude update > /dev/null 2>&1
	echo "neovimをインストールします"
	sudo aptitude install -y neovim

elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
	OS='Cygwin'
	echo -n "windowsですね? (Y/n) : "
	read check
	if [ "${check}" == "n" ]; then
		echo "まじっすか... OSが判断できませんでした"
		echo "手作業で実行してください"
		echo "異常終了します"
		exit 1
	else
		echo "未実装"
		break
	fi
else
	echo "Your platform ($(uname -a)) is not supported."
	exit 1
fi

#for f in `ls $dir`; do
#done


# OS共通

# pyenv
echo -e "\n=======================\n"
echo "pyenvをインストールします"
curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash

# rbenv
echo -e "\n=======================\n"
echo "rbenvをインストールします"
git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

# }}}


fi

# golang {{{

echo -e "\n=======================\n"
echo "goの最新版をビルドします"

mkdir ~/work/go/
cd ~/work/go

if [ -d ~/work/go/go ]; then
	echo "~/work/go/goが存在します"
	cd ~/work/go/go
	echo -n "最新版に更新しますか? (y/N) : "
	read check
	if [ "${check}" == "y" ]; then
		echo "git pull origin master"
		git pull origin master
		echo "git reset --hard HEAD"
		git reset --hard HEAD
	fi
else
	echo "goの最新版をダウンロードします"
	echo "git clone https://github.com/golang/go"
	git clone https://github.com/golang/go
fi


cp -rf ~/work/go/go ~/work/go/go1.4

godir=$HOME/work/go
GOROOT=$HOME/work/go
cd $godir/go1.4

# go1.4
if [ -d ~/work/go/go1.4/bin ]; then
	echo "go 1.4が存在します"
else
	echo -e "\n=======================\n"
	echo "go1.4をビルドします"
	echo "git checkout release-branch.go1.4	>/dev/null 2>&1"
	git checkout release-branch.go1.4	>/dev/null 2>&1
	cd $godir/go1.4/src
	if [ "$(uname)" == 'Darwin' ]; then
		./make.bash
	elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
		./make.bash
	elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
		./make.bat
	fi
	echo "go1.4のビルドが完了しました"
fi
PATH="$godir/go1.4/bin:$PATH"
echo $PATH
which go
go version


if [ -d ~/work/go/go/bin ]; then
	flag=1
	echo "~/work/go/goが存在します"
	echo -n "ビルドし直しますか? (y/N) : "
	read check
	if [ "${check}" == "y" ]; then
		flag=0
	fi
else
	flag=0
fi

if [ "${flag}" == "0" ]; then

	echo -e "\n=======================\n"
	echo "最新版のgolangをビルドします"

	rm -rf $HOME/go1.4
	ln -sf $godir/go1.4 $HOME

	cd $godir/go/src

	if [ "$(uname)" == 'Darwin' ]; then
		./all.bash
	elif [ "$(expr substr $(uname -s) 1 5)" == 'Linux' ]; then
		./all.bash
	elif [ "$(expr substr $(uname -s) 1 10)" == 'MINGW32_NT' ]; then
		./all.bat
	fi

	rm -rf $HOME/go1.4

	echo -e "\n=======================\n"
	echo "最新版のgolangのビルドが完了しました"
fi


PATH=$godir/go/bin:$PATH
which go
go version


cd ~
if [ -d ~/work/usr ]; then
	echo -n ""
else
	mkdir ~/work/usr
fi
if [ -d ~/work/bin ]; then
	echo -n ""
else
	mkdir ~/work/bin
fi
if [ -d ~/work/usr/local ]; then
	echo -n ""
else
	mkdir ~/work/usr/local
fi
if [ -d ~/work/usr/local/bin ]; then
	echo -n ""
else
	mkdir ~/work/usr/local/bin
fi

# }}}


echo -e "\n=======================\n"
echo "以上ですべての処理が完了しました"
echo -e "\n=======================\n"
end=`date +%s`
past=$((end - start))
echo "実行時間 : $past"

exit 0


