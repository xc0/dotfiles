" 2017/07/15/17:30.13 edited.
" 2017/05/10/08:27.50 edited.

" よくある設定 {{{
set nocompatible
set noreadonly
set autoread
set encoding=utf-8
set fileencoding=utf-8
set noautoindent
set nosmartindent
set cindent
set tabstop=4
set shiftwidth=4
set title
set showmatch
set display=lastline
set showmatch
set matchtime=1
"set clipboard=unnamed
set clipboard+=unnamed
set smartcase
"set wrap
set nowrap
set number
set ruler
set list
set listchars=tab:>-,trail:>,nbsp:%,extends:>,precedes:<,eol:<
set backspace=indent,eol,start	" バックスペースで各種消せるようにする
set incsearch
set hlsearch
set whichwrap=h,l
set nowrapscan
"set ignorecase
set noignorecase	" 大文字小文字を区別する
set hidden
set history=2000
set noexpandtab
set helplang=en
set matchpairs& matchpairs+=<:> "対応括弧に<と>のペアを追加
cmap w!! w !sudo tee > /dev/null %  "w!!でrootとして保存

if has('win32unix') && &term =~# '^xterm' && &t_Co < 256
  set t_Co=256  " Extend cygwin terminal color
endif

augroup swapchoice-readonly
  autocmd!
  autocmd SwapExists * let v:swapchoice = 'o'
augroup END

if has('win32unix')
  let &t_ti .= "\e[1 q"
  let &t_SI .= "\e[5 q"
  let &t_EI .= "\e[1 q"
  let &t_te .= "\e[0 q"
endif


"色設定
hi SpecialKey ctermfg=237 guifg=#3a3a3a
hi NonText ctermfg=66 guifg=#5f8787

if (exists('+colorcolumn'))		" 80カラムを強調
	set colorcolumn=80
	highlight ColorColumn ctermbg=9
endif

"}}}

" プラグイン設定 {{{

" VimFilerを標準のファイラーに設定
" :e . でnetrtの変わりにVimFilerが起動する
let g:vimfiler_as_default_explorer=1

augroup vimrc-checktime
  autocmd!
  autocmd WinEnter * checktime
augroup END

if has('vim_starting')
  set nocompatible
  " neobundle をインストールしていない場合は自動インストール
  if !isdirectory(expand("~/.vim/bundle/neobundle.vim/"))
    echo "install neobundle..."
    " vim からコマンド呼び出しているだけ neobundle.vim のクローン
    :call system("git clone git://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim")
  endif
  " runtimepath の追加は必須
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle'))
let g:neobundle_default_git_protocol='https'

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'nanotech/jellybeans.vim'	" こんな感じが基本の書き方

NeoBundleCheck			"プラグインでインストールされていないものがないかチェックする
"filetype plugin indent on
"set t_Co=256
"syntax on

NeoBundle 'simeji/winresizer'


"unite.vim  "他のプラグインからも使われている便利ランチャー
"下記の設定では<C-u><C-f>と<C-u><C-u>に特にお世話になっている
"ファイルの一覧では<C-n>は下方向、<C-p>は上方向に移動する。(この操作方法のプラグインが結構ある)
"また上端の > に文字列を入力することによって絞り込み検索を行い、Enterでファイルを開くのが基本の使い方
"なお、Escを２回押すことで unite で開いたバッファを閉じるように設定している(楽)
"※<C- >はCtrl+いずれかのキー
NeoBundle 'Shougo/unite.vim'
let g:unite_enable_start_insert=1
nmap <silent> <C-u><C-b> :<C-u>Unite buffer<CR>
nmap <silent> <C-u><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nmap <silent> <C-u><C-r> :<C-u>Unite -buffer-name=register register<CR>
nmap <silent> <C-u><C-m> :<C-u>Unite file_mru<CR>
nmap <silent> <C-u><C-u> :<C-u>Unite buffer file_mru<CR>
nmap <silent> <C-u><C-a> :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
au FileType unite nmap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite imap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite nmap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite imap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite nmap <silent> <buffer> <ESC><ESC> q
au FileType unite imap <silent> <buffer> <ESC><ESC> <ESC>q

""neomru.vim""
"unite.vim から独立した機能
"ファイル履歴を記録してくれている
"こいつがいれば上記unite.vimにより<C-u><C-u>で以前開いたファイルが表示される
NeoBundle 'Shougo/neomru.vim', {
  \ 'depends' : 'Shougo/unite.vim'
  \ }

""vimproc
"vim に非同期処理を提供してくれる縁の下の力持ち
"多数のプラグインがこいつを頼りに高速化している。
NeoBundle 'Shougo/vimproc', {
  \ 'build' : {
  \     'windows' : 'make -f make_mingw32.mak',
  \     'cygwin' : 'make -f make_cygwin.mak',
  \     'mac' : 'make -f make_mac.mak',
  \     'unix' : 'make -f make_unix.mak',
  \    },
  \ }

""neocomplete.vim""
"クソ強力な補完機能を使えるようになる
"vimproc で高速化するやつ...というか作者が一緒
"これも<C-n>,<C-p>で補完候補から選択する
if has('lua')
  NeoBundleLazy 'Shougo/neocomplete.vim', {
    \ 'depends' : 'Shougo/vimproc',
    \ 'autoload' : { 'insert' : 1,}
    \ }
endif
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'

""vimshell""
"vim からシェルを簡単に使えるようになる便利屋
"画面分割してシェルを使える VimShellPop がオススメ。
"縮めて vp にマッピングしている。
NeoBundleLazy 'Shougo/vimshell', {
  \ 'depends' : 'Shougo/vimproc',
  \ 'autoload' : {
  \   'commands' : [{ 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete'},
  \                 'VimShellExecute', 'VimShellInteractive',
  \                 'VimShellTerminal', 'VimShellPop'],
  \   'mappings' : ['<Plug>(vimshell_switch)']
  \ }}

""yankround""
"ヤンク履歴を保持してくれるやつ
"ペースト後に<C-p>か<C-n>を押してヤンク履歴をペーストできる
"いわゆるコピペ拡張
"unite.vim と連携することで、(この設定では)\<C-p>で履歴一覧から絞り込み検索が可能
NeoBundle 'LeafCage/yankround.vim'

nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100
nnoremap <Leader><C-p> :<C-u>Unite yankround<CR>

""vimfiler""
"ファイルビューア
"<C-u><C-j>で縦分割で開閉できるように設定してみた
NeoBundleLazy 'Shougo/vimfiler', {
  \ 'depends' : ["Shougo/unite.vim"],
  \ 'autoload' : {
  \   'commands' : [ "VimFilerTab", "VimFiler", "VimFilerExplorer", "VimFilerBufferDir" ],
  \   'mappings' : ['<Plug>(vimfiler_switch)'],
  \   'explorer' : 1,
  \ }}
let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0
let g:vimfiler_data_directory       = expand('~/.vim/etc/vimfiler')

""vim-autoclose""
"括弧を自動的に閉じてくれるやつ
"なお閉じ括弧は入力しても２重にならない素敵仕様
NeoBundle 'Townk/vim-autoclose'

""vim-endwise:.vimrc""
"ifとかの終了宣言を自動で挿入してくれるやつ
"デフォルト設定で十分使える
NeoBundleLazy 'tpope/vim-endwise', {
  \ 'autoload' : { 'insert' : 1,}}

""vim-easymotion
"超高速で簡単な移動がコンセプト s[key][key][done]の４キーで画面内のどこへでも移動可能
"移動したいところを決めてから使う最強のカーソル移動プラグイン
"詳しくは過去記事(http://qiita.com/himinato/items/5fcdb3ad2885f0bc1ce6)を参照してください
NeoBundle 'Lokaltog/vim-easymotion'
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys = 'QZASDFGHJKL;'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1

""vim-surround, matchit""
"テキストを囲みや括弧のカーソル移動機能を拡張する
NeoBundle 'tpope/vim-surround'
NeoBundle 'vim-scripts/matchit.zip'

""vim-quickrun""
"実行する言語で自動化の環境が整っている場合あまり出番がない
"でもプログラムの編集状態から実行できて、出力を得られる
"\rで編集中のファイルを実行する
NeoBundleLazy 'thinca/vim-quickrun', {
  \ 'autoload' : {
  \   'mappings' : [['n', '\r']],
  \   'commands' : ['QuickRun']
  \ }}
let g:quickrun_config = {}
let g:quickrun_config._ = { 'runner' : 'vimproc',
  \ 'runner/vimproc/updatetime' : 200,
  \ 'outputter/buffer/split' : ':botright 8sp',
  \ 'outputter' : 'multi:buffer:quickfix',
  \ 'hook/close_buffer/enable_empty_data' : 1,
  \ 'hook/close_buffer/enable_failure' : 1,
  \ }
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"


""emmet-vim""
"HTMLのタグを一瞬で入力できる。 <C-y>nで次のタグ入力箇所に移動できたりフロントエンドの味方
NeoBundleLazy 'mattn/emmet-vim', {
  \ 'autoload' : {
  \   'filetypes' : ['html', 'html5', 'eruby', 'jsp', 'xml', 'css', 'scss', 'coffee'],
  \   'commands' : ['<Plug>ZenCodingExpandNormal']
  \ }}
let g:use_emmet_complete_tag = 1
let g:user_emmet_settings = {
  \ 'lang' : 'ja',
  \ 'html' : {
  \   'indentation' : '  '
  \ }}

NeoBundle 'rking/ag.vim'
" 行末ホワイトスペースの削除'bronson/vim-trailing-whitespace'
NeoBundle 'bronson/vim-trailing-whitespace'

"molokai 'tomasr/molokai'
NeoBundle 'tomasr/molokai'
colorscheme molokai

" Go lang "
NeoBundle 'fatih/vim-go'
set rtp+=$GOROOT/misc/vim
exe "set rtp+=".globpath($GOPATH, "src/github.com/nsf/gocode/vim”)")
set completeopt=menu,preview

call neobundle#end()

"}}}

" キー割り当て変更 {{{
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
inoremap jj <Esc>		" 入力モード中に素早くJJと入力した場合はESCとみなす

nnoremap s4t :%s/\s\s\s\s/\t/g<CR>		" スペース4をタブに置換
nnoremap s2t :%s/\s\s/\t/g<CR>		" スペース4をタブに置換

nnoremap <CR> o<ESC>

nnoremap Q <Nop>		" exモードを無効
nnoremap Q q
nnoremap q <Nop>

nnoremap setv :e $HOME/.vimrc<CR><ESC> " ,v でvimrcを開く
nnoremap setb :e $HOME/.bashrc<CR><ESC>

nnoremap vs :<C-u>VimShell<CR><ESC>
nnoremap vp :<C-u>VimShellPop<CR><ESC>

autocmd BufRead,BufNewFile *.py setfiletype python
autocmd FileType python setl inoremap # <ESC>0i#<ESC>wi


nnoremap <TAB>f :<C-u>VimFilerBufferDir -split -simple -winwidth=35 -no-quit -toggle<CR>

nnoremap <TAB>t :<C-u>tabnew<CR><ESC>	" TAB-tに新規タブ作成を割り当て
nnoremap <TAB>n gt		" 次のタブに移動
nnoremap <TAB>p gT		" 前のタブに移動
nnoremap <TAB>w <C-w>w		" TABwにウィンドウ切り替えを割り当て

nnoremap <TAB>dt a<C-r>=strftime("%Y/%m/%d/%H:%M")<CR><ESC>		" 日時挿入
nnoremap <Space>dt gg0O# <C-r>=strftime("%Y/%m/%d/%H:%M.%S")<CR> edited.<ESC>0		" 日時挿入

" }}}

