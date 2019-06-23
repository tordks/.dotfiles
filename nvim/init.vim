
"TODO: Go thorugh plugins and set settings
"TODO: Add ifdef if using vim or neovim for plugins etc.
"TODO: Add plugins from vimawesome
"       * Gitgutter
"       * Table mode
"       * Indent guides

""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""
"   nvim config for Tord Kriznik Sørensen    "
""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""

syntax on
filetype on
filetype indent plugin on " load filetype-specific indent files

source ~/.config/nvim/init_plugins.vim
source ~/.config/nvim/init_settings.vim
source ~/.config/nvim/init_mappings.vim
source ~/.config/nvim/init_funcs.vim


"colorscheme 256-jungle
"colorscheme solarized
colorscheme neodark



