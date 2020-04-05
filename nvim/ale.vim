
let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 0

"nnoremap <silent> K :ALEHover<CR>
"nnoremap <silent> gd :ALEGoToDefinition<CR>
"nnoremap <silent> <F2> :ALEFindReferences<CR>
nnoremap <leader>af :ALEFix<CR>

let g:ale_linters = {
\ 'cpp': ['ccls', 'clang'],
\ 'c': ['ccls', 'clang'],
\ 'python': ['pylint', 'flake8']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'cpp': ['clangtidy'],
\ 'c': ['clangtidy'],
\ 'python': ['yapf', 'isort', ]
\}
