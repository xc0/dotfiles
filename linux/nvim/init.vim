" 2017/07/15/21:22.57 edited.

" よくある設定 {{{

if &compatible
	set nocompatible               " Be iMproved
endif

set noreadonly						" 書き込み禁止属性解除
set encoding=utf-8					" 文字列の文字コードをUTF-8に
set fileencoding=utf-8				" ファイルの文字コードをUTF-8に
set autoread						" 編集中のファイルに変更があれば読み込む
set showcmd							" 入力中のコマンドを表示
set cursorline						" 現在の行を強調表示
set cursorcolumn					" 現在の列を強調表示
set wildmode=list:longest			" コマンドラインの補完
set display=lastline				" 
set title							" 開いているファイル名を表示
set showmatch						" 
set matchtime=1						" 
set clipboard=unnamed				" クリップボードの共有
"set clipboard+=unnamed				" こっちのほうがいいらしい
set nowrapscan						" 検索時、末尾から先頭に戻らない
set wrapscan						" 検索時、末尾から先頭に戻る
set noignorecase					" 大文字/小文字の区別して検索する
set ignorecase						" 大文字/小文字の区別なく検索する
set smartcase						" 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch						" 
set hlsearch						" 
set whichwrap=h,l					" 
set nocindent						" 
set noautoindent					" 
set smartindent						" set nosmartindent		" 
set tabstop=4						" 
set shiftwidth=4					" 自動インデントでずれる幅
set noexpandtab						" TABを空白に展開しない
set backspace=indent,eol,start		" バックスペースでインデントや改行を削除できるようにする
set formatoptions+=mM				" テキスト挿入中の自動折り返しを日本語に対応させる
set ambiwidth=double				" 全角文字の幅を2に固定する。文脈によって意味が異なる。
set noswapfile						" swapファイルを作らない
set visualbell						" beepを可視化
set number							" 行番号表示
set ruler							" ルーラーを表示
set list							" 不可視文字を表示
set listchars=tab:>-,trail:>,nbsp:%,extends:>,precedes:<,eol:↲	" 不可視文字の表示設定
set matchpairs& matchpairs+=<:> 	" 対応括弧に<と>のペアを追加
cmap w!! w !sudo tee > /dev/null %	" w!!でrootとして保存
set hidden							" ファイルが未保存でも他のファイルを開けるようにする
set history=2000					"
syntax on							" シンタックスハイライト
set termguicolors					" TrueColor
set foldmethod=marker				" 折りたたむ

if (exists('+colorcolumn'))			" 80カラムを強調
	set colorcolumn=80
	highlight ColorColumn ctermbg=9
endif

" }}}


" dein.vim {{{

" dein のインストール方法
" インストールディレクトリを決めて以下のコマンドを実行
" $ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
" $ sh ./installer.sh {specify the installation directory}

"dein Scripts-----------------------------
"
let OSTYPE = system('uname')
if OSTYPE == "Darwin\n"
	set runtimepath+=/Users/xc0/.config/nvim/dein/repos/github.com/Shougo/dein.vim
	if dein#load_state('/Users/xc0/.config/nvim/dein')
		call dein#begin('/Users/xc0/.config/nvim/dein')

		" Let dein manage dein
		" Required:
		call dein#add('/Users/xc0/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

		call dein#add('Shougo/neosnippet.vim')
		call dein#add('Shougo/neosnippet-snippets')

		" toml
		let g:rc_dir		= expand("~/.config/nvim")
		let s:toml		= g:rc_dir . '/dein.toml'
		let s:lazy_toml	= g:rc_dir . '/dein_lazy.toml'

		" read toml and cache
		call dein#load_toml(s:toml,			{'lazy':0})
		call dein#load_toml(s:lazy_toml,	{'lazy':0})

		call dein#end()
		call dein#save_state()
	endif
elseif OSTYPE == "Linux\n"
	set runtimepath+=/home/xc0/.config/vim/dein/repos/github.com/Shougo/dein.vim	" dein.vimのインストールディレクトリ
	if dein#load_state($HOME . '/.config/vim/dein')
		call dein#begin($HOME . '/.config/vim/dein')

		" Let dein manage dein  Required:
		call dein#add($HOME . '/.config/vim/dein/repos/github.com/Shougo/dein.vim')

		call dein#add('Shougo/neosnippet.vim')
		call dein#add('Shougo/neosnippet-snippets')

		" toml
		let g:rc_dir		= expand("~/.config/vim")
		let s:toml		= g:rc_dir . '/dein.toml'
		let s:lazy_toml	= g:rc_dir . '/dein_lazy.toml'

		" read toml and cache
		call dein#load_toml(s:toml,			{'lazy':0})
		call dein#load_toml(s:lazy_toml,	{'lazy':0})

		call dein#end()
		call dein#save_state()
	endif
else
	echo OSTYPE
endif


" Required:
filetype plugin indent on
syntax enable

if dein#check_install()
	call dein#install()
endif

"End dein Scripts-------------------------

" }}}


" キー割り当て {{{
"キー割り当て変更コマンド
"キー割り当て変更コマンドは、下のように、モードごと、再割当(remap)の有無によって別の名前が割り当てられています。
"再割当無し	再割当有り	モード
"noremap		map		ノーマルモード＋ビジュアルモード
"noremap!	map!	コマンドラインモード＋インサートモード
"nnoremap	nmap	ノーマルモード
"vnoremap	vmap	ビジュアル(選択)モード
"cnoremap	cmap	コマンドラインモード
"inoremap	imap	インサート(挿入)モード

" ウィンドウ間の移動
nnoremap swj <C-w>j
nnoremap swk <C-w>k
nnoremap swl <C-w>l
nnoremap swh <C-w>h
" ウィンドウ自体の移動
nnoremap swJ <C-w>J
nnoremap swK <C-w>K
nnoremap swL <C-w>L
nnoremap swH <C-w>H		" ウィンドウを左に移動を
nnoremap swe <C-w>=		" ウィンドウの大きさを揃える


nnoremap ; :
nnoremap : ;
noremap - $
nnoremap <CR> o<ESC>
nnoremap Q <Nop>		" exモードを無効
nnoremap Q q
nnoremap q <Nop>
nnoremap j gj
nnoremap k gk
inoremap jj <ESC>
nmap <Esc><Esc> :noh<CR><Esc>	" ESC連打でハイライト解除

nnoremap s4t :%s/\s\s\s\s/\t/g<CR><ESC>		" スペース4をタブに置換
nnoremap s2t :%s/\s\s/\t/g<CR><ESC>			" スペース2をタブに置換

nnoremap <TAB>dt a<C-r>=strftime("%Y/%m/%d/%H:%M")<CR><ESC>		" 日時挿入
nnoremap <Space>dt gg0O<C-r>=strftime("%Y/%m/%d/%H:%M.%S")<CR> edited.<ESC>gci0		" 日時挿入 caw.vimを使ってる


nnoremap <TAB>f :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit -toggle<CR><ESC>

nnoremap <TAB>t :<C-u>tabnew<CR><ESC>	" TAB-tに新規タブ作成を割り当て
nnoremap <TAB>n gt		" 次のタブに移動
nnoremap <TAB>p gT		" 前のタブに移動
nnoremap <TAB>w <C-w>w		" TABwにウィンドウ切り替えを割り当て



" }}}


" color scheme {{{

"colorscheme alduin
"colorscheme dracula
"colorscheme mizore		" 黒地にめちゃ水色
"colorscheme mango
"colorscheme inkpot
"colorscheme scooby		" ハイライトが強すぎて見えない
"colorscheme newproggie	" コメント緑で微妙

colorscheme eva			" オレンジ
colorscheme fahrenheit	" コーラ
colorscheme moonfly

colorscheme ayu			" 暗めの藍にオレンジ
colorscheme onedark		" 鞍目の藍に紫


colorscheme koehler		" 黒地に赤黃でそれなり
colorscheme evening		" 灰色で落ち着いた感じ
colorscheme slate		" 暗めの灰色で少しはっきりした感じ
colorscheme kalisi


" 不可視文字の表示が明るすぎるカラースキーマ
colorscheme tender
colorscheme pencil
colorscheme apprentice
colorscheme antares
colorscheme ubaryd
colorscheme vendetta
colorscheme deepsea
colorscheme mustang
colorscheme railscasts	" 黒
colorscheme buddy
colorscheme kolor		" 暗めの灰色で落ち着いた感じ
colorscheme basic-dark	" 黒地に青みがかった灰色








" }}}



