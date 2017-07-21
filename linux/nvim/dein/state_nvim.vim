if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/xc0/work/dotfiles/linux/nvim/init.vim', '/Users/xc0/.config/nvim/dein.toml', '/Users/xc0/.config/nvim/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/xc0/.config/nvim/dein'
let g:dein#_runtime_path = '/Users/xc0/.config/nvim/dein/.cache/init.vim/.dein'
let g:dein#_cache_path = '/Users/xc0/.config/nvim/dein/.cache/init.vim'
let &runtimepath = '/Users/xc0/.config/nvim,/etc/xdg/nvim,/Users/xc0/.local/share/nvim/site,/usr/local/share/nvim/site,/Users/xc0/.config/nvim/dein/repos/github.com/Shougo/dein.vim,/Users/xc0/.config/nvim/dein/.cache/init.vim/.dein,/usr/share/nvim/site,/usr/local/Cellar/neovim/0.2.0_1/share/nvim/runtime,/Users/xc0/.config/nvim/dein/.cache/init.vim/.dein/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/Users/xc0/.local/share/nvim/site/after,/etc/xdg/nvim/after,/Users/xc0/.config/nvim/after'
filetype off
