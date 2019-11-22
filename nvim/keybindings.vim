
let mapleader = " "

" Move between buffers
nnoremap <A-h> :bp<cr> 
nnoremap <A-l> :bn<cr>

" Move between splits with ctr-j instead of ctrl-w and then j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
"
" Move between windows in terminal window for neovim
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l


" disable line numbers in terminal
autocmd TermOpen * setlocal nonumber

" Delete buffer from split"
nnoremap <leader>d :bp\|bd # <cr>

" space open/closes folds
" nnoremap <space> za " 

" highlight last inserted text
nnoremap gV `[v`]

"map visual shift to shift and reselect
vnoremap < <gv
vnoremap > >gv

"function keys for addons
nnoremap <silent> <Leader>u :GundoToggle<CR>
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>t :Ttoggle<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>r :Rg<CR>
