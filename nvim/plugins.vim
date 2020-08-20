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
Plug 'fisadev/vim-isort' " auto sort python imports
Plug 'dense-analysis/ale' " vim linter and formatter (can wrap multiple formatters)
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
"Plug 'jiangmiao/auto-pairs' " automatically pair paranthesis
"
"
" Syntax and language integration
Plug 'lervag/vimtex'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
"TODO: vim-markdown vs vim-pandoc and vim-pandoc-syntax
"Plug 'plasticboy/vim-markdown'
"Plug 'octol/vim-cpp-enhanced-highlight'
"Plug 'Shougo/echodoc.vim'


" Motions and general text editing
Plug 'svermeulen/vim-yoink'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround' " mappings to del/change/add surroundings
Plug 'scrooloose/nerdcommenter' " mass comment based on language
Plug 'christoomey/vim-tmux-navigator'
Plug 'unblevable/quick-scope' " highlights first unique char on line


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
Plug 'tbabej/taskwiki' " vimwiki + taskwarrior integration
Plug 'powerman/vim-plugin-AnsiEsc' " adds color support in charts (taskwiki)
Plug 'majutsushi/tagbar' " Vim plugin that displays tags in a window, ordered by scope (enables taskwiki file navigation)
Plug 'blindFS/vim-taskwarrior' " vim interface for taskwarrior
Plug 'tpope/vim-obsession' " automatic sessioning

call plug#end()
