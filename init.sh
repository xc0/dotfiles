#! /bin/bash

version=0.3

# 関数群 {{{2
osCheck(){ # {{{
	if [ "$(uname)" == "Darwin" ]; then
		OS='Mac'
	elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
		OS='Linux'
	elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
		OS='Cygwin'
	elif [ "$(uname -s)" == "MSYS_NT-10.0-WOW" ]; then
		OS='Msys'
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
	if [ "$HOME" == "/st/c2015/c5901" ]; then
		dir=~/work/dotfiles/kcs
	else
		dir=~/work/dotfiles/linux
	fi
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
mkSLink_msys(){ # {{{
	echo "Mysys"
	dir=~/work/dotfiles/msys
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
	if [ -d $HOME/.config ]; then
		echo -n ".configが存在します"
	else
		mkdir ~/.config
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

	echo "シンボリックリンクの作成が完了しました"
	echo "ホームディレクトリ"
	ls -al ~
	echo "~/.config"
	ls -al ~/.config
} # }}}
mkSLink(){ # {{{
	echo -e "\n=======================\n"
	echo "dotfileのシンボリックリンクを作成します "

	if [ "$OS" == "Darwin" ]; then
		mkSLink_mac

	elif [ "$OS" == "Linux" ]; then
		mkSLink_linux

	elif [ "$OS" == "Cygwin" ]; then
		mkSLink_cygwin

	elif [ "$OS" == "Msys" ]; then
		mkSLink_msys
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
		if [ "$gitS" == "" ]; then
			echo -n "gitの初期設定をしますか？ (y/N) : "
			read gitS
		fi
		if [ "${gitS}" == "y" ]; then
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
	echo "未実装"
	return
} # }}}
appInstall_linux() { #{{{
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
	echo -e "\n=======================\n"
	echo "neovimをビルドします"
	cd ~/work/
	if [ -d neovim ]; then
		if [ -d .git ]; then
			cd neovim
			git pull origin master
		else
			rm -rf neovim
			git clone https://github.com/neovim/neovim
		fi
	else
		git clone https://github.com/neovim/neovim
		cd neovim
	fi
	make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/work/usr/local/neovim"
	make install
} # }}}
appInstall_cygwin() { #{{{
	echo "未実装"
	return
} # }}}
appInstall_msys() { #{{{
	echo "Application install for Mysys"
	echo -e "\n=======================\n"
	echo "ソースリストをアップデートします"
	echo "pacman -Syuu"
	echo "不要なときはC-cでスキップします"
	pacman -Syuu
	echo -e "\n=======================\n"
	echo "いろいろインストールします"
	echo "pacman -S make cmake gcc vim curl wget"
	pacman -S make cmake gcc vim curl wget
	echo "pacman -S python-dev python-pip python3-dev python3-pip"
	pacman -S python-dev python-pip python3-dev python3-pip
	echo "pip3 install neovim"
	pip3 install neovim

	# latex
	echo -e "\n=======================\n"
	echo "Latex関係のインストールをします"
	echo "pacman -S tex-live-lang-cjk"
       	pacman -S tex-live-lang-cjk
	cp ~/work/dotfiles/sty/* /usr/share/texlive/texmf-dist/tex/latex/
	mktexlsr

	# neovimのインストール
	echo -e "\n=======================\n"
	echo "neovimをビルドします"
	cd ~/work/
	if [ -d neovim ]; then
		if [ -d .git ]; then
			cd neovim
			git pull origin master
		else
			rm -rf neovim
			git clone https://github.com/neovim/neovim
		fi
	else
		git clone https://github.com/neovim/neovim
		cd neovim
	fi
	make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=$HOME/work/usr/local/neovim"
	make install
	return
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
	if [ "$app" == "" ]; then
		echo -n "よく使うアプリケーションをインストールしますか？ (y/N) : "
		read app
	fi
	if [ "${app}" == "y" ]; then
		count=0
		if [ "$pos" == "" ]; then
			echo -n "このファイルinit.shは~/work/dotfilesに置かれていますか？ (y/N) : "
			read pos
		fi
		if [ "${pos}" == "y" ]; then
			echo -n ""
			break
		else
			echo "init.shは~/work/dotfiles/init.shに置かれなければなりません"
			echo "正しい位置に置いてください"
			echo "mkdir ~/work"
			echo "cd ~/work"
			echo "git clone http://git:kumamon@git.xcd0.com/git/dot.git"
			echo "でできます"
			echo "エラー終了します"
			exit 1
		fi

		count=0

		if [ "$OS" == 'Darwin' ]; then
			appInstall_mac
		elif [ "$OS" == 'Linux' ]; then
			appInstall_linux
		elif [ "$OS" == 'Cygwin' ]; then
			appInstall_cygwin
		elif [ "$OS" == 'Msys' ]; then
			appInstall_msys
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
		echo "go を pull します"
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
	elif [ "$OS" == 'Cygwin' ]; then
		./make.bat
	elif [ "$OS" == 'Msys' ]; then
		./make.bat
	fi
	echo "go1.4のビルドが完了しました"
} # }}}
goLastBuild(){ # {{{
	echo -e "\n=======================\n"
	echo "最新版のgolangをビルドします"

	godir=$HOME/work/go

	mv $godir/go/bin $godir/go/bin_$date

	rm -rf ~/go1.4
	ln -sf $godir/go1.4 ~/

	cd $godir/go/src

	if [ "$OS" == 'Darwin' ]; then
		./all.bash
	elif [ "$OS" == 'Linux' ]; then
		./all.bash
	elif [ "$OS" == 'Cygwin' ]; then
		./all.bat
	elif [ "$OS" == 'Msys' ]; then
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
	if [ "$ins" != "y" ]; then
		return
	fi
	echo -e "\n=======================\n"
	echo "goをインストールします"

	flag=0		# 1 なら最新版をビルド
	a=`which go | wc -l`

	if [ "${a}" != "0" ]; then
		if [ -f ~/work/go/bin/go ]; then
			echo "~/work/go/bin/goが存在します"
			~/work/go/bin/go version
			flag=0
			if [ "$goM" == "" ]; then
				echo -n "元のファイルを移動しますか? (Y/n) : "
				read goM
			fi
			if [ "${goM}" == "n" ]; then
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
				if [ "`which go`" != "$HOME/work/go/go/bin/go" ]; then
					if [ "$gopp" == "" ]; then
						echo "~/work/go/go/binにパスが通っていません"
						echo -n "~/work/go/go/binにパスを通しますか? (y/N) : "
						read gopp
					fi
					if [ "${gopp}" == "y" ]; then
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
			if [ "$ins" == "" ]; then
				echo -n "最新版に更新しますか? (y/N) : "
			fi
		fi
	else
		if [ "$ins" == "" ]; then
			echo "goが存在しません"
			echo -n "goをインストールしますか? (y/N) : "
		fi
	fi
	if [ "$ins" == "" ]; then
		read ins
	fi
	if [ "${ins}" == "y" ]; then
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
			if [ "$gorb4" == "" ]; then
				echo "go 1.4をビルドし直しますか？ : (Y/n)"
				read gorb4
			fi
			if [ "${gorb4}" == "n" ]; then
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
			if [ "$gorb" == "" ]; then
				echo "~/work/go/go/bin/goが存在します"
				echo -n "ビルドし直しますか? (y/N) : "
				read gorb
			fi
			if [ "${gorb}" == "y" ]; then
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

run(){ # {{{
	date=`date +%s`
	# 何回実行しても問題ない奴ら
	osCheck
	mkSLink
	mkUsr
	if [ "${goskip}" == "n" ]; then
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

# init  {{{1
interactiveMode(){ # {{{
	echo "======================================================================"
	echo "インタラクティブモード"
	echo "対話的に実行します"
	sleep 1
	echo -n "goの設定までスキップしますか？ (Y/n) : "
	read goskip
	run
} # }}}
autoMode(){ # {{{
	echo "======================================================================"
	echo "オートモード"
	echo ""
	echo "非常に危険なモードです。"
	echo "オートモードの設定をします。"
	echo "質問にyかnで答えてください。(最大8つ)"
	echo "大文字になっている方がどちらかというと安全です"
	echo "間違えると大変危険です。注意してください。"
	echo ""
	echo -n "1 : このシェルスクリプトは~/work/dotfilesに置かれていますか? (y/N) : "
	read pos
	if [ "$pos" == "y" ]; then
		echo ""
	elif [ "$pos" == "n" ]; then
		echo "init.shは~/work/dotfiles/init.shに置かれなければなりません"
		echo "正しい位置に置いてください"
		echo "mkdir ~/work"
		echo "cd ~/work"
		echo "git clone http://git:kumamon@git.xcd0.com/git/dot.git"
		echo "でできます"
		echo "エラー終了します"
		exit 1
	else
		echo "入力がyかnではありませんでした。"
		echo "エラー終了します。"
		exit 1
	fi
	echo -n "2 : gitの初期設定をしますか? (y/N) : "
	read gitS
	if [   "$gitS" == "y" ]; then
		echo ""
	elif [ "$gitS" == "n" ]; then
		echo ""
	else
		echo "入力がyかnでありませんでした。"
		echo "エラー終了します。"
		exit 1
	fi
	echo -n "3 : よく使うアプリケーションをインストールしますか? (y/N) : "
	read app
	if [   "$app" == "y" ]; then
		echo ""
	elif [ "$app" == "n" ]; then
		echo ""
	else
		echo "入力がyかnではありませんでした。"
		echo "エラー終了します。"
		exit 1
	fi
	echo -n "4 : 最新版のgoをインストールしますか? (y/N) : "
	read ins
	if [ "$ins" == "y" ]; then
		gorb=$ins
		source ~/.bashrc
		if [ "`which go`" != "$HOME/work/go/go/bin/go" ]; then
			echo "5 : ~/work/go/go/binにパスが通っていません"
			echo -n "    ~/work/go/go/binにパスを通しますか? (y/N) : "
			read gopp
			if [   "$gopp" == "y" ]; then
				echo ""
			elif [ "$gopp" == "n" ]; then
				echo ""
			else
				echo "入力がyかnではありませんでした。"
				echo "エラー終了します。"
				exit 1
			fi
		fi
		if [ -f ~/work/go/bin/go ]; then
			echo "5 : ~/work/go/bin/goが存在します"
			~/work/go/bin/go version
			echo -n "    ファイルを移動しますか? (Y/n) : "
			read goM
			if [   "$goM" == "y" ]; then
				echo ""
			elif [ "$goM" == "n" ]; then
				echo ""
			else
				echo "入力がyかnではありませんでした。"
				echo "エラー終了します。"
				exit 1
			fi
		fi
		if [ -f ~/work/go/go1.4/bin/go ]; then
			echo "    ~/work/go/go1.4/bin/goが存在します"
			echo -n "7 : go 1.4をビルドし直しますか. : (Y/n)"
			read gorb4
			if [   "$gorb4" == "y" ]; then
				echo ""
			elif [ "$gorb4" == "n" ]; then
				echo ""
			else
				echo "入力がyかnではありませんでした。"
				echo "エラー終了します。"
				exit 1
			fi
		fi
	elif [   "$ins" == "n" ]; then
		gopp=n
		goM=n
		gorb4=n
		gorb=n
	else
		echo "入力がyかnではありませんでした。"
		echo "エラー終了します。"
		exit 1
	fi
	echo "8 : オートモードの設定は以上です。"
	echo -n "    入力に間違いはありませんね? (y/N) : "
	read fin
	if [ "$fin" == "y" ]; then
		run
		exit 0
	else
		echo "エラー終了します。"
		exit 1
	fi
} # }}}
askMode(){ # {{{

	count=0
	while true; do
		echo -n "どちらのモードで実行しますか? ( i / a ) : "
		read check
		if [ "${check}" == "i" ]; then
			interactiveMode
		elif [ "${check}" == "a" ]; then
			autoMode
		else
			((count++))
			if [ "${count}" == "3" ]; then
				echo "3回誤入力がありました。"
				echo "エラー終了します。"
				exit 1
			fi
			echo "誤入力です。"
			echo "iかaを入力します。"
			echo "3回の誤入力で終了します。"
		fi
	done
} # }}}
message(){ # {{{

echo -e "\n-------------------------------------------------------------------"
	cat <<MSG

	クリーンインストールしたら
	最初に実行して環境設定を終わらせよう!
	という目的で作ったshellscriptです。
	もちろんクリーンじゃなくてもおkです。

	Debian系のみ実行してね♥ RHEL? 知らない子ですね

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
MSG
echo -e "\n-------------------------------------------------------------------\n"

sleep 1

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
# }}}1

checkOption $@


exit 0

