syntax on
set hlsearch
set smartcase
set ignorecase
set number
" set relativenumber
inoremap jk <Esc>
nnoremap <Enter> :call append(line('.'), '')<CR>
nnoremap <S-Enter> :call append(line('.')-1, '')<CR>

noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>

set cursorline
hi CursorLine term=bold cterm=bold guibg=Grey40
