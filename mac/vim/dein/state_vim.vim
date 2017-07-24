if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/xc0/.vimrc', '/Users/xc0/.config/vim/dein.toml', '/Users/xc0/.config/vim/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/xc0/.config/vim/dein'
let g:dein#_runtime_path = '/Users/xc0/.config/vim/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/Users/xc0/.config/vim/dein/.cache/.vimrc'
let &runtimepath = '/Users/xc0/.vim,/Users/xc0/.config/vim/dein/repos/github.com/Shougo/dein.vim,/Users/xc0/.config/vim/dein/.cache/.vimrc/.dein,/usr/share/vim/vimfiles,/usr/share/vim/vim74,/Users/xc0/.config/vim/dein/.cache/.vimrc/.dein/after,/usr/share/vim/vimfiles/after,/Users/xc0/.vim/after'
