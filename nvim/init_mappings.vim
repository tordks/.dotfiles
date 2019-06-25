
" Change paste setting by pressing F2
nnoremap <F2> :set invpaste paste?<CR>

" Delete buffer from split"
nnoremap <C-c> :bp\|bd # <cr>

" jk is escape and don't move back one character
" TODO: change this map.. Makes writing j slow.
inoremap jk <esc>l
vnoremap jk <esc>

" terminal emulator esc
tnoremap <Esc> <C-\><C-n>
tnoremap jk <C-\><C-n>

" TODO: another key if leader -> space
" space open/closes folds
nnoremap <space> za " 

" highlight last inserted text
nnoremap gV `[v`]

" TODO: Change this map?
nnoremap <A-h> :bp<cr> 
nnoremap <A-l> :bn<cr>


"Move between splits with ctr-j instead of ctrl-w and then j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>


" Move between windows in terminal window for neovim
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Open terminal in new split window and start in insert mode
" nnoremap <leader>n  :20sp <cr> <C-W>r :terminal <cr>

" move to beginning/end of line
nnoremap B ^
nnoremap E $

" $/^ doesn't do anything
nnoremap $ <nop>
nnoremap ^ <nop>
