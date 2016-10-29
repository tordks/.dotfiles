
""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""
"   .vimrc for Tord Kriznik Sørensen    "
"""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""

" A lot of inspiration from "A Good vimrc":
" http://dougblack.io/words/a-good-vimrc.html

"TODO: Search up Fuzzy file finder
"TODO: Make this file fold into sections. color, Space/tabs, etc.
"TODO: Test python-mode and add settings
"TODO: Remove YCM plugin from repo and add it in the post install.

syntax on
filetype on
filetype indent plugin on " load filetype-specific indent files

call plug#begin('~/.vim/plugged')

" Snippet solution for Vim. 
" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'  

" Vim script for text filtering and alignment 
Plug 'godlygeek/tabular'

" Syntax checking hacks for vim 
Plug 'scrooloose/syntastic'

" A tree explorer plugin
Plug 'scrooloose/nerdtree'

" Python stuff in vim
"Plug 'klen/python-mode'

" Latex in vim
"Plug 'lervag/vimtex'

" A solid language pack for Vim. 
Plug 'sheerun/vim-polyglot'

" A code-completion engine for Vim
Plug 'Valloric/YouCompleteMe'

" MPI syntax highlighting
" Plug 'jiangxincode/mpi.vim'

" Colorscheme 256-jungle
Plug 'vim-scripts/256-jungle'

" Colorscheme solarized
" Plug 'altercation/vim-colors-solarized'

" statusline plugin for vim (Add if you use it in terminal as well)
" Plug 'powerline/powerline'

" Powerline fonts
Plug 'powerline/fonts'

" lightweight statusbar
Plug 'bling/vim-airline'

" Graph of undos
Plug 'sjl/gundo.vim'

"A code-searching tool similar to ack, but faster.
Plug 'ggreer/the_silver_searcher' 

"Fuzzy file, buffer, mru, tag, etc finder
Plug 'kien/ctrlp.vim'

""Plug 'takac/vim-hardtime'

"markdown syntax highlighting. authentication fail.
Plug 'plasticboy/vim-markdown'

" Git in vim
Plug 'tpope/vim-fugitive'

" Easymotion
Plug 'easymotion/vim-easymotion'

" Multiple cursors
Plug 'terryma/vim-multiple-cursors'

" Matlab in vim
"Plug 'dajero/VimLab'

" Comment plugin
Plug 'scrooloose/nerdcommenter'


call plug#end()


" Prevents excessive use of the keys below
""let g:hardtime_default_on = 1
""let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+"]

" Ultisnip settings
let g:UltiSnipsExpandTrigger="qw"
let g:UltiSnipsJumpForwardTrigger="qw"
let g:UltiSnipsJumpBackwardTrigger="wq"

" YouCompleteMe settings
let g:ycm_key_list_select_completion = ['<tab>', '<Down>']


" Airline setings
"let g:airline_theme             = 'powerlineish'
"let g:airline_powerline_fonts = 1
"if !exists('g:airline_symbols')
"      let g:airline_symbols = {}
"endif
"let g:airline_symbols.space = "\ua0"
"let g:airline#extensions#tabline#enabled = 1
"let g:airline#extensions#tabline#show_buffers = 0

let mapleader = "," " leader is comma 	
      


set nocompatible
set background=dark
set laststatus=2            " always displaying status line
set nu                      " display line numbers
set tabstop=4               " number of visual spaces per TAB
set shiftwidth=4            " size of an indent
set expandtab               " smart expansion of tabs into spaces
"set softtabstop=4           " number of spaces in tab when editing.
"set smarttab
set wildmenu                " visual autocomplete for command menu
set nohlsearch              " removes highlight search
set incsearch               " search as characters are entered
set t_Co=256                " 256 colors
set encoding=utf-8          " sets encoding to utf-8
set history=9999            " remember more history than usual
set undofile                " save undo's after file closes
set undodir=$HOME/.vim/undo " persistent undo
set undolevels=1000         " set the undo history size
set undoreload=10000        " set the number of undos to reload when opening a file
set ruler                   " show the cursor position with a ruler
set cursorline              " highlights the line where the cursor is
set showcmd                 " display incomplete commands
set showmatch               " show matching braces
set lazyredraw              " do not redraw when executing macros; much faster
set foldenable              " enable folding
set foldlevelstart=10       " open most folds by default
"set foldnestmax=10          " 10 nested fold max
set foldmethod=indent       " fold based on indent level
set scrolloff=10             " Start scrolling when we're 8 lines away from margins
set sidescrolloff=15
set sidescroll=1
set mouse=a                 "Enable mouse"
set clipboard=unnamed       "Sets vim clipboard to the systems"

" Delete buffer from split"
nnoremap <C-c> :bp\|bd # <cr>

" Change paste setting by pressing F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>


" <leader> ; inputs ; at end of line
nnoremap <leader>; A;<esc>

" kj is escape and don't move back one character
inoremap kj <esc>l
vnoremap kj <esc>

" Align lines w.r.t. character inserted
vnoremap <leader>t :Tabularize /

" Sets <left> and <right> to switch between buffers
nnoremap <left> :w\|:bp<cr> 
nnoremap <right> :w\|:bn<cr>
"
"Move between splits with ctr-j instead of ctrl-w and then j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" space open/closes folds
nnoremap <space> za " 

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

" highlight last inserted text
nnoremap gV `[v`]

" toggle gundo
nnoremap <leader>u :GundoToggle<CR>

" Return to last edit position when opening files 
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Save session. Reopen by running vim -S
nnoremap <leader>s :mksession<CR>

" open ag.vim
nnoremap <leader>a :Ag


" CtrlP settings. See "A Good vimrc" for explanation
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

" move backups to the /tmp folder.
"set backup
"set writebackup
"set backupdir=.vim/backups

" Highlights characters that make a line more than 79 characters long.
" highlight OverLength ctermbg=lightgray ctermfg=darkblue guibg=#592929
" match OverLength /\%80v.\+/

" toggle between number and relativenumber
function! ToggleNumber()
    if(&relativenumber == 1)
        set norelativenumber
            set number
        else
            set relativenumber
    endif
endfunc

nnoremap <C-n> :call ToggleNumber()<cr>

" Autosave folds
"augroup AutoSaveFolds
"  autocmd!
"  autocmd BufWinLeave * mkview
"  autocmd BufWinEnter * silent loadview
"augroup END

" Remember folds in a file
"set viewdir=$HOME/.vim_view//
"au BufWritePost,BufLeave,WinLeave ?* mkview " for tabs
"au BufWinEnter ?* silent loadview


colorscheme 256-jungle


".vimrc"
"vimplugin"
"PlugInstall"
"
"ctrl+V <char> in insert mode inserts the symbol for that character
