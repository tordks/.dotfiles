
let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 0

nnoremap <leader>ah :ALEHover<CR>
nnoremap <leader>ad :ALEGoToDefinition<CR>
nnoremap <leader>ar :ALEFindReferences<CR>
nnoremap <leader>af :ALEFix<CR>

let g:ale_linters = {
\ 'cpp': ['ccls', 'clang'],
\ 'c': ['ccls', 'clang'],
\ 'python': ['pyls', 'flake8']
\}


let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'cpp': ['clangtidy'],
\ 'c': ['clangtidy'],
\ 'python': ['black', 'isort'],
\ 'sql': ['pgformatter']
\}

let g:ale_python_flake8_executable = expand('~/.pyenv/versions/neovim/bin/flake8')
let g:ale_python_flake8_use_global = 1
let g:ale_python_isort_executable = expand('~/.pyenv/versions/neovim/bin/pyls')
let g:ale_python_isort_use_global = 1
let g:ale_python_black_executable = expand('~/.pyenv/versions/neovim/bin/black')
let g:ale_python_black_use_global = 1
let g:ale_python_isort_executable = expand('~/.pyenv/versions/neovim/bin/isort')
let g:ale_python_isort_use_global = 1
" let g:ale_python_sqlint_executable = expand('~/.pyenv/versions/neovim/bin/sqlint')
" let g:ale_python_sqlint_use_global = 1
" let g:ale_python_mypy_executable = expand('~/.pyenv/versions/neovim/bin/mypy')
" let g:ale_python_mypy_use_global = 1



let g:ale_python_black_options="--line-length=80 -S"

" make sure linters and fixers conform to black
let g:ale_python_flake8_options="--extend-ignore=E116,E203,W503 --max-line-length=80"
"let g:ale_python_pylint_options="--disable=C0330,C0326"
let g:ale_python_isort_options="--multi-line-output=3 --use-parentheses=True --include-trailing-comma=True --line-length=80 --force-grid-wrap=0"


" === YAPF ===
"let g:yapf_style = "pep8"
"nnoremap <leader>y :Yapf<cr>
