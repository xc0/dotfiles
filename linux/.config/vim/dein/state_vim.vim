if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/home/xcd0/.vimrc', '/home/xcd0/.config/vim/dein.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/home/xcd0/.config/vim/dein'
let g:dein#_runtime_path = '/home/xcd0/.config/vim/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/home/xcd0/.config/vim/dein/.cache/.vimrc'
let &runtimepath = '/home/xcd0/.vim,/var/lib/vim/addons,/home/xcd0/.config/vim/dein/repos/github.com/Shougo/dein.vim,/home/xcd0/.config/vim/dein/.cache/.vimrc/.dein,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/home/xcd0/.config/vim/dein/.cache/.vimrc/.dein/after,/usr/share/vim/vimfiles/after,/var/lib/vim/addons/after,/home/xcd0/.vim/after'
filetype off
