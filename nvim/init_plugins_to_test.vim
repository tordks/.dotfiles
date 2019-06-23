
" TODO: investigate ctags
" TODO: investigate ack vs ag

call plug#begin('~/.config/nvim/plugged')

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Management:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"--------------------------------------------------------
" Vim_vinegar: vinegar.vim enhances netrw,
"--------------------------------------------------------
" TODO: test this and netrw. replacesment for NERDTree?
" Plug 'tpope/vim-vinegar'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Coding:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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

"
"--------------------------------------------------------
" Ale: Asynchronous Lint Engine
"--------------------------------------------------------
" TODO: test
"Plug 'w0rp/ale'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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


""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visuals:
""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""

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
