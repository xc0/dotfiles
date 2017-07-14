

set number				" 行番号表示
set termguicolors		" TrueColor
set clipboard=unnamed	" クリップボードの共有


if &compatible
	set nocompatible
endif
set runtimepath+={}							" dein.vimのインストールディレクトリ

call dein#begin(expand("~/.cache/dein"))

call dein#add('Shougo/denite.nvim')			" 

call dein#add('Shougo/deoplete.nvim')		" 補完
call dein#add('zchee/deoplete-jedi')		" python
call dein#add('zchee/deoplete-go')			" golang
call dein#add('landaire/deoplete-swift')	" swift
call dein#add('zchee/deoplete-clang')		" C/C++/Obj-C/Obj-C++ 
call dein#add('carlitux/deoplete-ternjs')	" javascript
call dein#add('Shougo/deoplete-rct')		" ruby
call dein#add('poppyschmo/deoplete-latex')	" latex

call dein#add('neomake/neomake')			" 外部コマンドを非同期実行
call dein#add('flazz/vim-colorschemes')		" カラースキーマいっぱい

call dein#add('fatih/vim-go')				" golang support
set rtp+=$GOROOT/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim”)")
set completeopt=menu,preview

call dein#add('tomasr/molokai')				" molokai
call dein#add('rking/ag.vim')				" 行末ホワイトスペース削除
call dein#add('mattn/emmet-vim')			" html,css,xml support
call dein#add('LeafCage/yankround.vim')		" クリップボード拡張
" yankround.vim {{{
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100
nnoremap <Leader><C-p> :<C-u>Denite yankround<CR>

call dein#add('')				" 

if dein#check_install()
	call dein#install()
endif
call dein#end()



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


nnoremap s4t :%s/\s\s\s\s/\t/g<CR>		" スペース4をタブに置換
nnoremap s2t :%s/\s\s/\t/g<CR>			" スペース2をタブに置換

nnoremap <TAB>f :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit -toggle<CR>

nnoremap <TAB>t :<C-u>tabnew<CR>	" TAB-tに新規タブ作成を割り当て
nnoremap <TAB>n gt		" 次のタブに移動
nnoremap <TAB>p gT		" 前のタブに移動
nnoremap <TAB>w <C-w>w		" TABwにウィンドウ切り替えを割り当て

nnoremap <TAB>dt a<C-r>=strftime("%Y/%m/%d/%H:%M")<CR><ESC>		" 日時挿入
nnoremap <Space>dt gg0O# <C-r>=strftime("%Y/%m/%d/%H:%M.%S")<CR> edited.<ESC>0	" 日時挿入

