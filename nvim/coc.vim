
" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"


function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" goto definition
nmap <silent> gd <Plug>(coc-definition)

" Smart rename (renames the exports across all files)
nmap <leader>rn <Plug>(coc-rename)


"let g:coc_snippet_next = '<C-j>'


" TODO: This is is currently not working!
"call coc#config('coc.languageserver', {
"      \ 'ccls': {
"      \   'command': 'ccls',
"      \   'filetypes': ['c', 'cpp', 'cuda', 'objc', 'objcpp'],
"      \   'rootPatterns': ['.ccls', 'compile_commands.json', '.vim/', '.git/', '.hg/'],
"      \   'initializationOptions': { 'cache': { 'directory': '.ccls-cache' } },
"      \ },
"      \})
"call coc#config("coc.preferences.diagnostic.displayByAle", 1)
