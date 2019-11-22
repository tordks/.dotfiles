" TODO: Create install.sh script which installs all dependencies
" TODO: Add dotfiles management
" TODO: investigate ctags
" TODO: investigate ack vs ag
"
" TODO: echodoc

call plug#begin('~/.config/nvim/plugged')

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'


" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'


" Autocompletion and autoformatting
Plug 'mindriot101/vim-yapf'  " automatic python code formatter
Plug 'w0rp/ale' " vim syntax checker
" Plug 'zxqfl/tabnine-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Intellisense engine for vim8 & neovim
Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}
Plug 'neoclide/coc-python', {'do': 'yarn install --frozen-lockfile'}


" Motions and general text editing
Plug 'svermeulen/vim-yoink'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround' " mappings to del/change/add surroundings
Plug 'scrooloose/nerdcommenter' " mass comment based on language
Plug 'christoomey/vim-tmux-navigator'
Plug 'unblevable/quick-scope' " highlights first unique char on line


" Syntax and language integration
Plug 'plasticboy/vim-markdown'
Plug 'lervag/vimtex'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'Shougo/echodoc.vim'


" Interface
Plug 'scrooloose/nerdtree' " directory sidebar
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " fuzzy file finder
Plug 'junegunn/fzf.vim'
Plug 'sjl/gundo.vim'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'

" Colorschemes
Plug 'vim-scripts/256-jungle'
Plug 'morhetz/gruvbox'
Plug 'KeitaNakamura/neodark.vim'

" Misc
Plug 'vimwiki/vimwiki' " Notetaking and personal wiki
Plug 'tpope/vim-obsession' " automatic sessioning

call plug#end()
