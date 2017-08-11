if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/home/xc0/work/dotfiles/linux/nvim/init.vim', '/home/xc0/.config/vim/dein.toml', '/home/xc0/.config/vim/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/home/xc0/.config/vim/dein'
let g:dein#_runtime_path = '/home/xc0/.config/vim/dein/.cache/init.vim/.dein'
let g:dein#_cache_path = '/home/xc0/.config/vim/dein/.cache/init.vim'
let &runtimepath = '/home/xc0/.config/nvim,/etc/xdg/nvim,/home/xc0/.local/share/nvim/site,/usr/local/share/nvim/site,/home/xc0/.config/vim/dein/repos/github.com/Shougo/dein.vim,/home/xc0/.config/vim/dein/.cache/init.vim/.dein,/usr/share/nvim/site,/usr/share/nvim/runtime,/home/xc0/.config/vim/dein/.cache/init.vim/.dein/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/home/xc0/.local/share/nvim/site/after,/etc/xdg/nvim/after,/home/xc0/.config/nvim/after,/home/xc0/.config/nvim/dein/repos/github.com/Shougo/dein.vim'
filetype off
