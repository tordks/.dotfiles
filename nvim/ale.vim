
let g:ale_fix_on_save = 1
let g:ale_completion_enabled = 0

nnoremap <silent> K :ALEHover<CR>
nnoremap <silent> gd :ALEGoToDefinition<CR>
nnoremap <silent> <F2> :ALEFindReferences<CR>
nnoremap <F3> :ALEFix<CR>

"let g:ale_linters = {
"\ 'cpp': ['ccls', 'clang'],
"\ 'c': ['ccls', 'clang'],
"\ 'python': ['pylint', 'flake8']
"\}
"
"let g:ale_fixers = {
"\ 'cpp': ['clangtidy'],
"\ 'c': ['clangtidy'],
"\ 'python': ['yapf']
"\}

let g:ale_linters = {
\ 'typescript': ['tslint', 'tsserver', 'typecheck', 'xo'],
\ 'rust': ['rls', 'cargo']
\}
let g:ale_fixers = {
\ 'typescript': ['prettier', 'eslint'],
\ 'javascript': ['prettier', 'eslint'],
\ 'haskell': ['brittany'],
\ 'rust': ['rustfmt']
\}
