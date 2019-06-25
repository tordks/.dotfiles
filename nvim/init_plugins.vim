
" TODO: Create install.sh script which installs all dependencie
" TODO: Move unused, plugins to its own init_plugins_unused.vim
"       for potential later use.
" TODO: investigate ctags
" TODO: investigate ack vs ag

call plug#begin('~/.config/nvim/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Management:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------------
" NERDTree: File tree 
"--------------------------------------------------------
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
nnoremap <Leader>n :NERDTreeToggle<Enter>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Start nerdtree on startup if no params to nvim
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Start nerdtree when opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" close vim if nerdtree is the only open window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"--------------------------------------------------------
" Vim_vinegar: vinegar.vim enhances netrw,
"--------------------------------------------------------
" TODO: test this and netrw. replacesment for NERDTree?
" Plug 'tpope/vim-vinegar'

"--------------------------------------------------------
" Fzf: fuzzy file finder
"--------------------------------------------------------
" TODO: Look into key-mappings and customization
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

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
" Hide statusline of containing buffer
augroup fzf
  autocmd!
  autocmd! FileType fzf
  autocmd  FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup END

"--------------------------------------------------------
" Tmux_navigation:
"--------------------------------------------------------
Plug 'christoomey/vim-tmux-navigator'

"--------------------------------------------------------
" Gundo: Graph of undos
"--------------------------------------------------------
Plug 'sjl/gundo.vim'
nnoremap <leader>u :GundoToggle<CR>

"--------------------------------------------------------
" Vim_obsession: automatic sessioning.
" Start session recording by :Obsess and end by :Obsess!
"--------------------------------------------------------
 Plug 'tpope/vim-obsession'


"--------------------------------------------------------
 " Fugitive: Git in vim
"--------------------------------------------------------
Plug 'tpope/vim-fugitive'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coding:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------------
" Deoplete: code completion framework
" Good for python/go
"--------------------------------------------------------
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'deoplete-plugins/deoplete-clang'
"Plug 'zchee/deoplete-clang'
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#auto_refresh_delay = 0
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" remap tab to switch key
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

"--------------------------------------------------------
" Jedi: autocompletion and static analysis library for python
"--------------------------------------------------------
" Note: cannot move to builtins
Plug 'davidhalter/jedi-vim'
" using deoplete-jedi for autocomplete, so disable the one from jedi
let g:jedi#completions_enabled = 0


"--------------------------------------------------------
" YouCompleteMe: Code completion framework
" better for c/c++?
"--------------------------------------------------------
" TODO: test
" Plug 'Valloric/YouCompleteMe'
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
" let g:ycm_key_list_select_completion = ['<tab>', '<Down>']
" let g:ycm_extra_conf_globlist = [""]  

"--------------------------------------------------------
" Cocvim: Intellisense engine for vim8 & neovim
"--------------------------------------------------------
" TODO: Test
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

"--------------------------------------------------------
" Ployglot: A collection of language packs with 
"--------------------------------------------------------
" TODO: How does this enter with deoplete/jedi, if compatible?
" Plug 'sheerun/vim-polyglot'


"--------------------------------------------------------
" Ultisnips: Snippet solution
"--------------------------------------------------------
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'  
"let g:UltiSnipsExpandTrigger="qw"
"let g:UltiSnipsJumpForwardTrigger="qw"
"let g:UltiSnipsJumpBackwardTrigger="wq"


"--------------------------------------------------------
" Neosnippet: add snippet support to vim
" supposedly better than ultisnips
" use https://github.com/Shougo/deoppet.nvim when it is done
"--------------------------------------------------------
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
let g:neosnippet#enable_completed_snippet=1

" "TODO: change these to qw, wq like in ultisnip settings?
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif


"--------------------------------------------------------
" Neomake: Asynchronous linting and make framework
"--------------------------------------------------------
Plug 'neomake/neomake'
"call neomake#configure#automake('w')
"TODO: make a test and decide to set python or python3
let g:neomake_python_python_exe = 'python3'
let g:neomake_verbose=1
let g:neomake_open_list = 0
autocmd! BufWritePost,BufEnter * Neomake

"--------------------------------------------------------
" Ale: Asynchronous Lint Engine
"--------------------------------------------------------
" TODO: test
"Plug 'w0rp/ale'


"--------------------------------------------------------
" Black: 
"--------------------------------------------------------
Plug 'python/black'
"autocmd BufWritePost *.py execute ':Black'


"--------------------------------------------------------
" Nerdcommenter: mass comment based on language
"--------------------------------------------------------
Plug 'scrooloose/nerdcommenter'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------------
" Vim_surround: mappings to delete/change/add surroundings
"--------------------------------------------------------
Plug 'tpope/vim-surround'
"

"--------------------------------------------------------
" Vim_repeat:  remaps . in a way that plugins can tap into it.
"--------------------------------------------------------
" TODO: Add support to other plugins?
Plug 'tpope/vim-repeat'

"--------------------------------------------------------
" Vim_easymotion:
"--------------------------------------------------------
Plug 'easymotion/vim-easymotion'

"--------------------------------------------------------
" Cutlass: make delete default and introduce move
"--------------------------------------------------------
" TODO: test this
"Plug 'svermeulen/vim-cutlass'
"nnoremap x d
"xnoremap x d

"nnoremap xx dd
"nnoremap X D


"--------------------------------------------------------
" Tabular: script for filtering text and alignement
"--------------------------------------------------------
Plug 'godlygeek/tabular'
" Align lines w.r.t. character inserted
vnoremap <leader>t :Tabularize /


"--------------------------------------------------------
" Yoink: iterate in yank history
"--------------------------------------------------------
Plug 'svermeulen/vim-yoink'
" TODO: evaluate mapping
nmap <c-n><c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p><c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

"--------------------------------------------------------
" Subversive: adds substitute motion
"--------------------------------------------------------
" Plug 'svermeulen/vim-subversive'
" nmap s <plug>(SubversiveSubstitute)
" nmap ss <plug>(SubversiveSubstituteLine)
" nmap S <plug>(SubversiveSubstituteToEndOfLine)
" nmap <leader>s <plug>(SubversiveSubstituteRange)
" xmap <leader>s <plug>(SubversiveSubstituteRange)
" nmap <leader>ss <plug>(SubversiveSubstituteWordRange)

"--------------------------------------------------------
" Vimtex: latex in vim
"--------------------------------------------------------
"Plug 'lervag/vimtex'


"--------------------------------------------------------
" Vimmarkdown: markdown syntax highlighting
"--------------------------------------------------------
" TODO: test
Plug 'plasticboy/vim-markdown'




""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visuals:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------------
" Statusbars:
"--------------------------------------------------------
Plug 'bling/vim-airline'
Plug 'powerline/fonts'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1


"--------------------------------------------------------
" Colorschemes: different colorschemes
"--------------------------------------------------------
"TODO: test!
Plug 'vim-scripts/256-jungle'
Plug 'KeitaNakamura/neodark.vim'
"Plug 'altercation/vim-colors-solarized'
"Plug 'icymind/NeoSolarized'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------------
" Vimhardtime: Make life harder, but easier
"--------------------------------------------------------
""Plug 'takac/vim-hardtime'
"let g:hardtime_default_on = 1
"let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+"]


call plug#end()
