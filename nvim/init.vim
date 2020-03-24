
"TODO: Go thorugh plugins and set settings
"TODO: Add ifdef if using vim or neovim for plugins etc.
"TODO: Add plugins from vimawesome
"       * Gitgutter
"       * Table mode
"       * Indent guides


source ~/.config/nvim/plugins.vim

" ============ General Config ============
set autoread                " Reload files changed outside vim
set colorcolumn=80          " Highlight the character limit
set cursorline              " highlights the line where the cursor is
if &encoding != 'utf-8'
    set encoding=utf-8          " sets encoding to utf-8
endif
set history=9999            " remember more history than usual
set inccommand=nosplit      " use incremental replace
set laststatus=2            " always displaying status line
set lazyredraw              " do not redraw when executing macros; much faster
set mouse=a                 " Enable mouse"
set nocompatible
set noshowmode              " Don't show the mode(airline is handling this)
set number                  " display line numbers
set ruler                   " show the cursor position with a ruler
set showcmd                 " display incomplete commands
set showmatch               " show matching braces
set spelllang=en,no
set t_Co=256                " 256 colors
set visualbell              " No sounds
set wildmenu                " visual autocomplete for command menu
set clipboard=unnamedplus  " use system clipboard by default


if &t_Co > 2 || has("gui_running")
  "switch syntax highlighting on, when the terminal has colors
  syntax on
endif


"Setting the colorscheme
if &t_Co >= 256 || has("gui_running")
  set termguicolors
  set background=dark
  "colorscheme 256-jungle
  "colorscheme neodark
  colorscheme gruvbox
endif

" Lightline
let g:lightline = {
      \ 'colorscheme': 'gruvbox',
      \ }

let g:lightline.component_expand = {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \  'linter_checking': 'left',
      \  'linter_warnings': 'warning',
      \  'linter_errors': 'error',
      \  'linter_ok': 'left',
      \ }
let g:lightline.active = { 'right': [[ 'linter_checking', 'linter_errors', 'linter_warnings']] }


" quick-scope
augroup qs_colors
  autocmd!
  autocmd ColorScheme * highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  autocmd ColorScheme * highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
augroup END
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

" GitGutter
autocmd BufWritePost * GitGutter

" ultisnips options
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"


" ================ Search Settings  =================
set nohlsearch       "removes highlight search
set incsearch        "Find the next match as we type the search
set viminfo='100,f1  "Save up to 100 marks, enable capital marks



" ================ Turn Off Swap Files ==============
set noswapfile
set nobackup
set nowb

" ================ Persistent Undo ==================
" Keep undo history across sessions, by storing in file.
" Only works all the time.

silent !mkdir ~/.vim/backups > /dev/null 2>&1
set undodir=~/.vim/backups
set undolevels=10000 " set the undo history size
set undoreload=10000 " set the number of undos to reload when opening a file
set undofile

" ================ Indentation ======================

set autoindent
set smartindent
set smarttab

set shiftwidth=4
set tabstop=4
set expandtab " smart expansion of tabs into spaces

filetype plugin on
filetype indent on

" Display tabs and trailing spaces visually
set list listchars=trail:·,tab:┊\ ,extends:>,precedes:<,nbsp:·

set wrap       "wrap lines
set linebreak    "Wrap lines at convenient points


" ================ Folds ======================
set foldmethod=indent " fold based on indent level
set foldnestmax=3 " 10 nested fold max
set nofoldenable " don't fold by default


" ================ Scrolling ========================
set scrolloff=10         "Start scrolling when we're 10 lines away from margins
set sidescrolloff=15
set sidescroll=1



" ================ Keybindings ======================
source ~/.config/nvim/keybindings.vim

" ================ Keybindings ======================
" TODO: reevaluate funcs
source ~/.config/nvim/funcs.vim




" === NERDTree ===
nnoremap <Leader>n :NERDTreeToggle<Enter>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Start nerdtree when opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" close vim if nerdtree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" === FZF ===
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
      \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" search for git tracked files
nmap <Leader>f :GFiles<CR>
" search for all files
nmap <Leader>F :Files<CR>
" search through buffers
nmap <Leader>b :Buffers<CR>
" search through history
nmap <Leader>h :History<CR>

let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <c-p> :FZF<cr>

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction
autocmd! User FzfStatusLine call <SID>fzf_statusline()

" Hide statusline of containing buffer
augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

" ================ Completion/Lint/Docs =======================
" hidden makes vim act like all other editors, buffers can
" exist in the background without being in a window.
" if hidden is not set, TextEdit might fail.
set hidden
set cmdheight=2 " better display messages
set updatetime=300 " bad experience with default 4000 for diagnostic messages
source ~/.config/nvim/coc.vim
source ~/.config/nvim/ale.vim

let g:echodoc#enable_at_startup=1

" === Gundo ===
nnoremap <leader>u :GundoToggle<CR>


" === YAPF ===
let g:yapf_style = "pep8"
:nnoremap <leader>y :Yapf<cr>

" === Tabular ===
vnoremap <leader>t :Tabularize /

" === Yoink ===
" TODO: evaluate mapping
nmap <c-n><c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p><c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" === airline ===
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


" === Vimwiki ===
let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0

nmap <Leader>we <Plug>VimwikiSplitLink
nmap <Leader>wq <Plug>VimwikiVSplitLink
nmap <Leader>wp <Plug>VimwikiPrevLink
