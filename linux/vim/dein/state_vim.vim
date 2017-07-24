if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/st/c2015/c5901/.vimrc', '/st/c2015/c5901/.config/vim/dein.toml', '/st/c2015/c5901/.config/vim/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/st/c2015/c5901/.config/vim/dein'
let g:dein#_runtime_path = '/st/c2015/c5901/.config/vim/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/st/c2015/c5901/.config/vim/dein/.cache/.vimrc'
let &runtimepath = '/st/c2015/c5901/.vim,/var/lib/vim/addons,/st/c2015/c5901/.config/vim/dein/repos/github.com/Shougo/dein.vim,/st/c2015/c5901/.config/vim/dein/.cache/.vimrc/.dein,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/st/c2015/c5901/.config/vim/dein/.cache/.vimrc/.dein/after,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,/st/c2015/c5901/.vim/after'
filetype off
