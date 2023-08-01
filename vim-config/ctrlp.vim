" See https://github.com/kien/ctrlp.vim/blob/master/doc/ctrlp.txt

" Ignore these directories
set wildignore+=*/build/**
set wildignore+=*/eclipse-bin/**
set wildignore+=*/virtualenv/**

" Set search directory to...
" 'c' - the directory of the current file.
" 'r' - the nearest ancestor that contains one of these directories or files: .git .hg .svn .bzr _darcs
" 'a' - like c, but only if the current working directory outside of CtrlP is not a direct ancestor of
"let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.workspace']
let g:ctrlp_mruf_last_entered = 1
let g:ctrlp_mruf_exclude = '\v\.git/(MERGE_MSG|rebase-merge|COMMIT_EDITMSG|PULLREQ_EDITMSG|index)'

" If non-zero, this will enable opening multiple files with <c-z> and <c-o>
let g:ctrlp_open_multiple_files = 'i'

" Use this option to specify how the newly created file is to be opened when pressing <c-y>
let g:ctrlp_open_new_file = 'i'

nnoremap <Leader>p :CtrlP<CR>
nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>m :CtrlPMRU<CR>

" Make Ctrl+P faster by using Silver searcher
let g:ctrlp_use_caching = 0
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor

    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
else
  let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
  let g:ctrlp_prompt_mappings = {
    \ 'AcceptSelection("e")': ['<space>', '<cr>', '<2-LeftMouse>'],
    \ }
endif
