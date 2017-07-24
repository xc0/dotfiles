if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/st/c2015/c5901/work/dotfiles/kcs/nvim/init.vim', '/st/c2015/c5901/.config/vim/dein.toml', '/st/c2015/c5901/.config/vim/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/st/c2015/c5901/.config/vim/dein'
let g:dein#_runtime_path = '/st/c2015/c5901/.config/vim/dein/.cache/init.vim/.dein'
let g:dein#_cache_path = '/st/c2015/c5901/.config/vim/dein/.cache/init.vim'
let &runtimepath = '/st/c2015/c5901/.config/nvim,/etc/xdg/nvim,/st/c2015/c5901/.local/share/nvim/site,/usr/local/share/nvim/site,/st/c2015/c5901/.config/vim/dein/repos/github.com/Shougo/dein.vim,/st/c2015/c5901/.config/vim/dein/.cache/init.vim/.dein,/usr/share/nvim/site,/st/c2015/c5901/work/usr/local/share/nvim/runtime,/st/c2015/c5901/.config/vim/dein/.cache/init.vim/.dein/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/st/c2015/c5901/.local/share/nvim/site/after,/etc/xdg/nvim/after,/st/c2015/c5901/.config/nvim/after'
filetype off
