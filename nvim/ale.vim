
let g:ale_fix_on_save = 0
let g:ale_completion_enabled = 0

"nnoremap <silent> K :ALEHover<CR>
"nnoremap <silent> gd :ALEGoToDefinition<CR>
"nnoremap <silent> <F2> :ALEFindReferences<CR>
nnoremap <leader>af :ALEFix<CR>

let g:ale_linters = {
\ 'cpp': ['ccls', 'clang'],
\ 'c': ['ccls', 'clang'],
\ 'python': ['flake8']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\ 'cpp': ['clangtidy'],
\ 'c': ['clangtidy'],
\ 'python': ['black', 'isort']
\}

let g:ale_python_flake8_executable = expand('~/.pyenv/versions/neovim3/bin/flake8')
let g:ale_python_flake8_use_global = 1
let g:ale_python_black_executable = expand('~/.pyenv/versions/neovim3/bin/black')
let g:ale_python_black_use_global = 1
let g:ale_python_isort_executable = expand('~/.pyenv/versions/neovim3/bin/isort')
let g:ale_python_isort_use_global = 1
let g:ale_python_mypy_executable = expand('~/.pyenv/versions/neovim3/bin/mypy')
let g:ale_python_mypy_use_global = 1



let g:ale_python_black_options="--line-length=80"

" make sure linters and fixers conform to black
let g:ale_python_flake8_options="--extend-ignore=E203, W503"
let g:ale_python_pylint_options="--disable=C0330, C0326"
"let g:ale_python_isort="--multi_line_output=3"

" isort
"multi_line_output = 3
"include_trailing_comma = True
"force_grid_wrap = 0
"use_parentheses = True
"line_length = 88

" === YAPF ===
"let g:yapf_style = "pep8"
"nnoremap <leader>y :Yapf<cr>
