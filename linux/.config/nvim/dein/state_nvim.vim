if g:dein#_cache_version != 100 | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/home/xcd0/work/dotfiles/linux/.config/nvim/init.vim', '/home/xcd0/.config/nvim/dein.toml', '/home/xcd0/.config/nvim/dein_lazy.toml'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/home/xcd0/.config/nvim/dein'
let g:dein#_runtime_path = '/home/xcd0/.config/nvim/dein/.cache/init.vim/.dein'
let g:dein#_cache_path = '/home/xcd0/.config/nvim/dein/.cache/init.vim'
let &runtimepath = '/home/xcd0/.config/nvim,/etc/xdg/xdg-cinnamon/nvim,/etc/xdg/nvim,/home/xcd0/.local/share/nvim/site,/usr/share/cinnamon/nvim/site,/usr/share/gnome/nvim/site,/usr/local/share/nvim/site,/home/xcd0/.config/nvim/dein/.cache/init.vim/.dein,/usr/share/nvim/site,/usr/share/nvim/runtime,/home/xcd0/.config/nvim/dein/.cache/init.vim/.dein/after,/usr/share/nvim/site/after,/usr/local/share/nvim/site/after,/usr/share/gnome/nvim/site/after,/usr/share/cinnamon/nvim/site/after,/home/xcd0/.local/share/nvim/site/after,/etc/xdg/nvim/after,/etc/xdg/xdg-cinnamon/nvim/after,/home/xcd0/.config/nvim/after,/home/xcd0/.config/nvim/dein/repos/github.com/Shougo/dein.vim'
filetype off
