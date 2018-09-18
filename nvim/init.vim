
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

" A lot of inspiration from "A Good vimrc":
" http://dougblack.io/words/a-good-vimrc.html

syntax on
filetype on
filetype indent plugin on " load filetype-specific indent files

""""""""""""
""""""""""""
"" PLUGINS "
""""""""""""
""""""""""""

call plug#begin('~/.config/nvim/plugged')


"""""""""""""""""""""""
" General programming "
"""""""""""""""""""""""

" Code completion
" Plug 'Valloric/YouCompleteMe'
Plug 'Shougo/deoplete.nvim'


" Automatic .ycm_conf_extra.py generation
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}

" Syntax checking for nvim/vim
Plug 'neomake/neomake'
"
" A solid language pack for Vim with syntax highlighting. 
" TODO: Double check that this works
Plug 'sheerun/vim-polyglot'

" Snippet solution for Vim. 
" Group dependencies, vim-snippets depends on ultisnips
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'  
"
" A tree explorer plugin
Plug 'scrooloose/nerdtree'

" Python autocomplete
Plug 'davidhalter/jedi-vim'


""""""""""""""""""
" Organizational "
""""""""""""""""""

" Git in vim
Plug 'tpope/vim-fugitive'

" Powerline fonts
Plug 'powerline/fonts'
"
" lightweight statusbar
Plug 'bling/vim-airline'

" Graph of undos
Plug 'sjl/gundo.vim'

" Saving vim sessions
Plug 'tpope/vim-obsession'

" Tmux navigation
Plug 'christoomey/vim-tmux-navigator'


""""""""""""
" Movement "
""""""""""""

"Fuzzy file, buffer, mru, tag, etc finder
Plug 'kien/ctrlp.vim'

" Easymotion
"TODO: Learn this properly
Plug 'easymotion/vim-easymotion'

" Multiple cursors
"TODO: Learn this properly
Plug 'terryma/vim-multiple-cursors'

""""""""""
" Matlab "
""""""""""
" Matlab in vim
"Plug 'dajero/VimLab'

""""""""""
" Python "
""""""""""
" Python stuff in vim
"Plug 'klen/python-mode'

""""""""""""
" Markdown "
""""""""""""
"markdown syntax highlighting. authentication fail.
Plug 'plasticboy/vim-markdown'

"""""""""
" Latex "
"""""""""
" Latex in vim
"Plug 'lervag/vimtex'

"""""""""
" C/C++ "
"""""""""

" MPI syntax highlighting
Plug 'jiangxincode/mpi.vim'

"""""""""
" Misc. "
"""""""""

" Colorscheme 256-jungle
Plug 'vim-scripts/256-jungle'

" Colorscheme solarized
"Plug 'altercation/vim-colors-solarized'
"Plug 'icymind/NeoSolarized'
"
" Colorscheme neodark
Plug 'KeitaNakamura/neodark.vim'




" Comment plugin
Plug 'scrooloose/nerdcommenter'

" Vim script for text filtering and alignment 
Plug 'godlygeek/tabular'

""Plug 'takac/vim-hardtime'

call plug#end()

"""""""""""""""""""""
"""""""""""""""""""""
"" SNIPPET SETTINGS "
"""""""""""""""""""""
"""""""""""""""""""""
" TODO: Should order in same order as above

" Prevents excessive use of the keys below
""let g:hardtime_default_on = 1
""let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+"]

" Ultisnip settings
let g:UltiSnipsExpandTrigger="qw"
let g:UltiSnipsJumpForwardTrigger="qw"
let g:UltiSnipsJumpBackwardTrigger="wq"

" codecomplete settings
"let g:ycm_key_list_select_completion = ['<tab>', '<Down>']
"let g:ycm_extra_conf_globlist = ["~/Desktop/Sommerstudenter2016"]  

" Use deoplete.
let g:deoplete#enable_at_startup = 1



" run neomake for every save
autocmd! BufWritePost * Neomake

"""""""""""""
"""""""""""""
"" MAPPINGS "
"""""""""""""
"""""""""""""

" leader is comma 	
let mapleader = "," 

" Change paste setting by pressing F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" <leader> ; inputs ; at end of line
nnoremap <leader>; A;<esc>

" Delete buffer from split"
nnoremap <C-c> :bp\|bd # <cr>

" jk is escape and don't move back one character
inoremap jk <esc>l
vnoremap jk <esc>

" terminal emulator esc
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>

" Align lines w.r.t. character inserted
vnoremap <leader>t :Tabularize /

" space open/closes folds
nnoremap <space> za " 

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
" Sets <left> and <right> to switch between buffers

" TODO: Change this map?
"nnoremap <A-h> :w\|:bp<cr> 
"nnoremap <A-l> :w\|:bn<cr>
nnoremap <A-h> :bp<cr> 
nnoremap <A-l> :bn<cr>

"Move between splits with ctr-j instead of ctrl-w and then j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" Move between windows in terminal window for neovim
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Open terminal in new split window and start in indsert mode
nnoremap <leader>n  :20sp <cr> <C-W>r :terminal <cr>

" Open terminal in new split window and start in insert mode and run make
nnoremap <leader>m  :20sp <cr> <C-W>r :terminal <cr> make <cr>
nnoremap <leader>gs  :20sp <cr> <C-W>r :terminal <cr> git status <cr>

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>

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

" Change paste setting by pressing F2
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" Search for makefile in above folders
" TODO: Make sure this does the right thing
"fun! SetMkfile()
  "let filemk = "Makefile"
  "let pathmk = "./"
  "let depth = 1
  "while depth < 4
    "if filereadable(pathmk . filemk)
      "return pathmk
    "endif
    "let depth += 1
    "let pathmk = "../" . pathmk
  "endwhile
  "return "."
"endf

"command! -nargs=* Make tabnew | let $mkpath = SetMkfile() | make <args> -C $mkpath | cwindow 10

"""""""""""""
"""""""""""""
"" SETTINGS "
"""""""""""""
"""""""""""""

set nocompatible
set background=dark
set laststatus=2            " always displaying status line
set nu                      " display line numbers
set tabstop=4               " number of visual spaces per TAB
set shiftwidth=4            " size of an indent
set expandtab               " smart expansion of tabs into spaces
set softtabstop=4           " number of spaces in tab when editing.
set smarttab
set wildmenu                " visual autocomplete for command menu
set nohlsearch              " removes highlight search
set incsearch               " search as characters are entered
set t_Co=256                " 256 colors
"set encoding=utf-8          " sets encoding to utf-8
set history=9999            " remember more history than usual
set undofile                " save undo's after file closes
set undodir=$HOME/.config/nvim/undo " persistent undo
set undolevels=10000        " set the undo history size
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


colorscheme 256-jungle
"colorscheme solarized
"colorscheme neodark



