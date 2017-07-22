#! /bin/bash

version=0.2

# 関数 {{{2

osCheck(){ # {{{
	if [ "$(uname)" == "Darwin" ]; then
		OS='Mac'
	elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
		OS='Linux'
	elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
		OS='Cygwin'
	else
		echo "Your platform ($(uname -s)) is not supported."
		exit 1
	fi
} # }}}

mkUsr(){ # {{{
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
} # }}}

# シンボリックリンクの作成 {{{1
mkSLink_mac(){ #{{{
	dir=~/work/dotfiles/mac

	echo "リンク先ファイル一覧"
	ls -al $dir
	echo ""

	if [ -L ~/.bash_profile ]; then
		rm ~/.bash_profile
	fi
	if [ -f ~/.bash_profile ]; then
		echo ".bash_profileが存在します"
		mv ~/.bash_profile ~/.bash_profile_$date
		echo ".bash_profile_$dateにリネームしました"
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
	ln -sf $dir/.bash_profile
	ln -sf $dir/.vimrc

	cd ~/.config/
	ln -sf $dir/nvim
	ln -sf $dir/vim

	cd ~/.local/share
	ln -sf $dir/fonts
} # }}}
mkSLink_linux(){ # {{{
	dir=~/work/dotfiles/linux
	echo "リンク先ファイル一覧"
	ls -al $dir
	echo ""

	if [ -L ~/.bashrc ]; then
		rm ~/.bashrc
	fi
	if [ -f ~/.bashrc ]; then
		echo ".bashrcが存在します"
		mv ~/.bashrc ~/.bashrc_$date
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
} # }}}
mkSLink_cygwin(){ # {{{
	dir=~/work/dotfiles/cygwin
	echo "未実装"
} # }}}
mkSLink(){ # {{{
	echo -e "\n=======================\n"
	echo "dotfileのシンボリックリンクを作成します "

	if [ "$OS" == "Darwin" ]; then
		mkSLink_mac

	elif [ "$OS" == "Linux" ]; then
		mkSLink_linux

	elif [ "$OS" == "MINGW32_NT" ]; then
		mkSlink_cygwin
	else
		echo "Your platform ($(uname -s)) is not supported."
		exit 1
	fi

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

	echo -e "\n=======================\n"
	echo "シンボリックリンクを作成しました"
} # }}}
# }}}1

gitSetting(){ # {{{
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
} # }}}

# よく使うアプリケーションのインストール {{{1
appInstall_mac() { #{{{
	echo -n "macですね? (y/n) : "
	read check
	if [ "${check}" == "n" ]; then
		echo "まじっすか... osが判断できませんでした"
		echo "手作業で実行してください"
		echo "異常終了します"
		exit 1
	else
		echo "未実装"
		return
	fi
} # }}}
appInstall_linux() { #{{{
	echo "debian系のみ実行してね♥ (rhel? 知らない子ですね)"
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
} # }}}
appInstall_cygwin() { #{{{
	echo -n "windowsですね? (Y/n) : "
	read check
	if [ "${check}" == "n" ]; then
		echo "まじっすか... OSが判断できませんでした"
		echo "手作業で実行してください"
		echo "異常終了します"
		exit 1
	else
		echo "未実装"
		return
	fi
} # }}}
pyenvInstall(){ # {{{
	# pyenv
	echo -e "\n=======================\n"
	echo "pyenvをインストールします"
	curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
} # }}}
rbenvInstall(){ # {{{
	# rbenv
	echo -e "\n=======================\n"
	echo "rbenvをインストールします"
	git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
	git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
} # }}}
appInstall() { #{{{
	echo -n "よく使うアプリケーションをインストールしますか？ (y/N) : "
	read check
	if [ "${check}" == "y" ]; then
		count=0
		while true; do
			echo -n "このファイルinit.shは~/work/dotfilesに置かれていますか？ (y/n) : "
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

		if [ "$OS" == 'Darwin' ]; then
			appInstall_mac
		elif [ "$OS" == 'Linux' ]; then
			appInstall_linux
		elif [ "$OS" == 'MINGW32_NT' ]; then
			appInstall_cygwin
		else
			echo "Your platform ($(uname -s)) is not supported."
			exit 1
		fi
		pyenvInstall
		rbenvInstall
	fi
} # }}}
# }}}1

# golang {{{1
goPull(){ # {{{
	if [ -d ~/work/go/go/.git ]; then
		echo "~/work/go/go/.gitが存在します"
		ehco "go を pull します"
		cd ~/work/go/go
		echo "git pull origin master"
		git pull origin master
		echo "git reset --hard HEAD"
		git reset --hard HEAD
	else
		echo "~/work/go/go/.gitが存在しません"
		if [ -d ~/work/go ]; then
			cd ~/work/go
			echo "~/work/go/が存在します"
			mv ~/work/go/ ~/work/go_$date
			echo "~/work/go/を~/work/go_$dateに変更しました"
			echo "goの最新版をダウンロードします"
			echo "git clone https://github.com/golang/go"
			git clone https://github.com/golang/go
		else
			echo "~/work/go/が存在しません"
			echo "~/work/go/を作成します"
			mkdir ~/work/go/
			cd ~/work/go
			echo "goの最新版をダウンロードします"
			echo "git clone https://github.com/golang/go"
			git clone https://github.com/golang/go
		fi
	fi
} # }}}
go14Build(){ # {{{
	echo -e "\n=======================\n"
	echo "go1.4をビルドします"
	echo "git checkout release-branch.go1.4	>/dev/null 2>&1"
	git checkout release-branch.go1.4	>/dev/null 2>&1
	cd $godir/go1.4/src
	if [ "$OS" == 'Darwin' ]; then
		./make.bash
	elif [ "$OS" == 'Linux' ]; then
		./make.bash
	elif [ "$OS" == 'MINGW32_NT' ]; then
		./make.bat
	fi
	echo "go1.4のビルドが完了しました"
} # }}}
goLastBuild(){ # {{{
	echo -e "\n=======================\n"
	echo "最新版のgolangをビルドします"

	rm -rf ~/go1.4
	ln -sf $godir/go1.4 ~/

	cd $godir/go/src

	if [ "$OS" == 'Darwin' ]; then
		./all.bash
	elif [ "$OS" == 'Linux' ]; then
		./all.bash
	elif [ "$OS" == 'MINGW32_NT' ]; then
		./all.bat
	fi

	rm -rf ~/go1.4

	echo -e "\n=======================\n"
	echo "最新版のgolangのビルドが完了しました"

	PATH=$godir/go/bin:$PATH
	which go
	echo "最新版のgoをインストールしました"
	echo -n "go version : "
	go version
} # }}}
goInstall(){ # {{{
	echo -e "\n=======================\n"
	echo "goをインストールします"

	flag=0		# 1 なら最新版をビルド
	a=`which go | wc -l`

	if [ "${a}" != "0" ]; then
		if [ -f ~/work/go/bin/go ]; then
			echo "~/work/go/bin/goが存在します"
			~/work/go/bin/go version
			flag=0
			echo -n "元のファイルを移動しますか? (Y/n) : "
			read check
			if [ "${check}" == "n" ]; then
				echo -n ""
				echo -n "最新版に更新しますか? (y/N) : "
			else
				mv ~/work/go ~/work/go_$date
				echo "mv ~/work/go ~/work/go_$date"
				echo "~/work/go_$dateにリネームしました"
				echo -n "~/work/go/goに最新版のgoをインストールしますか? (y/N) : "
			fi
		else
			echo "goが存在します"
			if [ -f ~/work/go/go/bin/go ]; then
				echo "~/work/go/go/bin/goが存在します"
				echo -n "go version : "
				~/work/go/go/bin/go version
				if [ "`which go`" != "~/work/go/go/bin/go" ]; then
					echo "~/work/go/go/binにパスが通っていません"
					echo -n "~/work/go/go/binにパスを通しますか? (y/N) : "
					read check
					if [ "${check}" == "y" ]; then
						if [ "$OS" == 'Darwin' ]; then
							echo 'export PATH="~/work/go/go/bin:$PATH"' >> ~/.bash_profile
							echo 'export PATH="~/work/go/go/bin:$PATH"' >> tmp
							source tmp
							rm tmp
						elif [ "$OS" == 'Linux' ]; then
							echo 'export PATH="~/work/go/go/bin:$PATH"' >> ~/.bashrc
							echo 'export PATH="~/work/go/go/bin:$PATH"' >> tmp
							source tmp
							rm tmp
						elif [ "$OS" == 'MINGW32_NT' ]; then
							echo 'export PATH="~/work/go/go/bin:$PATH"' >> ~/.bashrc
							echo 'export PATH="~/work/go/go/bin:$PATH"' >> tmp
							source tmp
							rm tmp
						else
							echo "OS Error in goInstall"
							exit 1
						fi
						echo "~/work/go/go/binにパスを通しました"
						which go
						echo -n "go version : "
						go version
					fi
				fi
			else
				echo -n "go version : "
				which go
			fi
			echo -n "最新版に更新しますか? (y/N) : "
		fi
	else
		echo "goが存在しません"
		echo -n "goをインストールしますか? (y/N) : "
	fi
	read check
	if [ "${check}" == "y" ]; then
		flag=1
		goPull
		cd ~/work/go

		cp -rf ~/work/go/go ~/work/go/go1.4

		echo 'godir="$HOME/work/go"' >> tmp
		echo 'GOROOT="$HOME/work/go"' >> tmp
		source tmp
		rm tmp
		cd $godir/go1.4

		# go1.4
		if [ -f ~/work/go/go1.4/bin/go ]; then
			echo "~/work/go/go1.4/bin/goが存在します"
			~/work/go/go1.4/bin/go version
			echo "go 1.4をビルドし直しますか？ : (Y/n)"
			read check
			if [ "${check}" == "n" ]; then
				echo -n ""
			else
				go14Build
			fi
		else
			go14Build
		fi

		PATH="$godir/go1.4/bin:$PATH"
		echo $PATH
		which go
		go version

		if [ -f ~/work/go/go/bin/go ]; then
			flag=1
			echo "~/work/go/go/bin/goが存在します"
			echo -n "ビルドし直しますか? (y/N) : "
			read check
			if [ "${check}" == "y" ]; then
				flag=0
			fi
		else
			flag=0
		fi

		if [ "${flag}" == "0" ]; then
			goLastBuild
		fi
	else
		echo "goをインストールしませんでした"
	fi
} # }}}
# }}}1

# }}}2

interactiveMode(){ # {{{
	# インタラクティブモード
	date=`date +%s`
	# 何回実行しても問題ない奴ら
	message
	osCheck
	mkSLink
	mkUsr

	echo -n "goの設定までスキップしますか？ (Y/n) : "
	read check
	if [ "${check}" == "n" ]; then
		gitSetting
		appInstall
	fi

	goInstall


	echo -e "\n=======================\n"
	echo "以上ですべての処理が完了しました"
	echo -e "\n=======================\n"
	end=`date +%s`
	past=$((end - date))
	echo "実行時間 : $past 秒"
	exit 0
} # }}}

autoMode(){
	exit 0
}

askMode(){ # {{{

	count=0
	while true; do
		echo -n "どちらのモードで実行しますか? (1/2) : "
		read check
		if [ "${check}" == "1" ]; then
			interavtivemode
		elif [ "${check}" == "2" ]; then
			automode
		else
			((count++))
			if [ "${count}" == "3" ]; then
				echo "3回誤入力がありました。"
				echo "エラー終了します。"
				exit 1
			fi
			echo "誤入力です。"
			echo "1か2を入力します。"
			echo "3回の誤入力で終了します。"
		fi
	done
} # }}}

message(){ # {{{
	cat <<MSG

	-----------------------------------------------------------

	クリーンインストールしたら
	最初に実行して環境設定を終わらせよう!
	という目的で作ったshellscriptです。
	もちろんクリーンじゃなくてもおkです。

	使い方
	① 対話的に実行   ( interactive mode )
MSG
	echo -e "		: オプション \033[0;35m-i\033[0;39m をつけて実行"
	cat <<MSG

	② 最初に入力だけしてあとは放置  ( auto mode )
MSG
	echo -e "		: オプション \033[0;35m-a\033[0;39m をつけて実行"
	cat <<MSG

	オプションなしでは最初にどちらのモードで実行するか尋ねます。

	-----------------------------------------------------------

MSG
} # }}}

checkOption(){ # {{{
	opt=$1
	if [ "$opt" == "-h" ]; then
		message
		exit 1
	elif [ "$opt" == "-v" ]; then
		echo $version
		exit 1
	elif [ "$opt" == "-a" ]; then
		autoMode
	elif [ "$opt" == "-i" ]; then
		interactiveMode
	elif [ "$#" == "0" ]; then
		message
		askMode
	else
		message
		exit 1
	fi
} # }}}

checkOption $@

sleep 1

exit 0

