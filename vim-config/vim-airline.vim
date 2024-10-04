"auto load airline status line
set laststatus=2

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_type = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_splits = 1

let g:airline#extensions#ctrlp#enabled = 1
let g:airline#extensions#nerdtree#enabled = 1
let g:airline#extensions#tmuxline#enabled = 1
let g:airline#extensions#eclim#enabled = 1
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#tagbar#enabled = 1

set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8
let g:airline_powerline_fonts = 1

" Tmux line formats
"let g:tmuxline_preset = 'nightly_fox'
