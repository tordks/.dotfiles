
" Plug 'tpope/vim-vinegar' " enhances netwr


" === NCM2 ===
" code completion framework
"
"Plug 'ncm2/ncm2'
"Plug 'roxma/nvim-yarp'
"
"" enable ncm2 for all buffers
"autocmd BufEnter * call ncm2#enable_for_buffer()
"
"" IMPORTANT: :help Ncm2PopupOpen for more information
"set completeopt=noinsert,menuone,noselect
"
"" NOTE: you need to install completion sources to get completions. Check
"" our wiki page for a list of sources: https://github.com/ncm2/ncm2/wiki
"" TODO: add snippet sources
"Plug 'ncm2/ncm2-bufword'
"Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-tmux'
"Plug 'ncm2/ncm2-jedi'
"Plug 'ncm2/ncm2-pyclang'
"
"let g:ncm2_pyclang#library_path = '/usr/lib/llvm-6.0/lib/libclang.so.1'
"let g:ncm2_pyclang#database_path= $COMPILEDB_JSON
"
"" goto declaration
"autocmd FileType c,cpp nnoremap <buffer> gd :<c-u>call ncm2_pyclang#goto_declaration()<cr>


"--------------------------------------------------------
" Deoplete: code completion framework
"--------------------------------------------------------
"Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " code completion framework
"Plug 'deoplete-plugins/deoplete-jedi' " deoplete source for jedi
"Plug 'zchee/deoplete-clang'
"
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#auto_complete_delay = 0
"let g:deoplete#auto_refresh_delay = 0
""
"inoremap <expr> <C-n>  deoplete#mappings#manual_complete()
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
"" remap tab to switch key
"inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
"inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
"
"" clang
"let g:deoplete#sources#clang#libclang_path = '/usr/lib/llvm-6.0/lib/libclang.so.1'
"let g:deoplete#sources#clang#clang_header = '/usr/include/clang/6.0/include/'
"let g:deoplete#sources#clang#clang_complete_database = $COMPILEDB_JSON


"--------------------------------------------------------
" Jedi: auto completion + static analysis
"--------------------------------------------------------
"Plug 'davidhalter/jedi-vim' " autocompletion + static analysis for python
"let g:jedi#completions_enabled = 0
"
"let g:jedi#goto_command = "<leader>d"
"let g:jedi#goto_assignments_command = "<leader>g"
"let g:jedi#goto_definitions_command = ""
""let g:jedi#documentation_command = "K"
""let g:jedi#usages_command = "<leader>n"
""let g:jedi#completions_command = "<C-Space>"
"let g:jedi#rename_command = "<leader>r"


"--------------------------------------------------------
" Cocvim: Intellisense engine for vim8 & neovim
"--------------------------------------------------------
" TODO: Test
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'neoclide/coc-tsserver', {'do': 'yarn install --frozen-lockfile'}
"Plug 'neoclide/coc-snippets', {'do': 'yarn install --frozen-lockfile'}

"--------------------------------------------------------
" Ale: Asynchronous Lint Engine
"--------------------------------------------------------
" Plug 'w0rp/ale'


"--------------------------------------------------------
" Neomake: Asynchronous linting and make framework
"--------------------------------------------------------
"Plug 'neomake/neomake'
""call neomake#configure#automake('w')
""TODO: make a test and decide to set python or python3
"let g:neomake_python_python_exe = 'python3'
"let g:neomake_logfile = '/tmp/neomake.log'
"let g:neomake_tempfile_dir = '/tmp/'
"let g:neomake_verbose=1
"let g:neomake_open_list = 0
"autocmd! BufWritePost,BufEnter * Neomake


"--------------------------------------------------------
" Ployglot: A collection of language packs with 
"--------------------------------------------------------
" Plug 'sheerun/vim-polyglot'


"--------------------------------------------------------
" Ultisnips: Snippet solution
"--------------------------------------------------------
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'  
"let g:UltiSnipsExpandTrigger="qw"
"let g:UltiSnipsJumpForwardTrigger="qw"
"let g:UltiSnipsJumpBackwardTrigger="wq"


"--------------------------------------------------------
" Black: Uncompromising automatic python code formatter
"--------------------------------------------------------
" Plug 'python/black'
"autocmd BufWritePost *.py execute ':Black'


"--------------------------------------------------------
" Vim_easymotion:
"--------------------------------------------------------
" Plug 'easymotion/vim-easymotion'


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
" Notescli: notetaking
"--------------------------------------------------------
"Plug 'rhysd/notes-cli'

"--------------------------------------------------------
" Vimhardtime: Make life harder, but easier
"--------------------------------------------------------
""Plug 'takac/vim-hardtime'
"let g:hardtime_default_on = 1
"let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+"]
