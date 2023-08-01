let g:ycm_key_list_select_completion = ['<TAB>', '<C-j>']
let g:ycm_key_list_previous_completion = ['<S-TAB>', '<C-k>']
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 0
let g:ycm_confirm_extra_conf = 0

" Call YCM GoTo or vim-go GoTo depending on file type.
function! GoToDef()
    if &ft == 'go'
        execute 'GoDef'
    else
        execute 'YcmCompleter GoTo'
    endif
endfunction
nnoremap <leader>g :call GoToDef()<CR>

" Call YCM GoToReferences or vim-go GoReferrers depending on file type.
function! GoToReferences()
    if &ft == 'go'
        execute 'GoReferrers'
    else
        execute 'YcmCompleter GoToReferences'
    endif
endfunction
nnoremap <leader>gr :call GoToReferences()<CR>

"nnoremap <leader>g :YcmCompleter GoTo<CR>
"nnoremap <leader>gr :YcmCompleter GoToReferences<CR>
nnoremap <leader>gt <plug>(YCMHover)
"nnoremap <leader>gt :YcmCompleter GetType<CR>
nnoremap <leader>gtt :YcmCompleter GoToType<CR>

" Customize the quickfix open command
function! s:CustomizeYcmQuickFixWindow()
  " Move the window to the right of the screen.
  wincmd J
  " Set the window height to 10.
  10wincmd _
endfunction

autocmd User YcmQuickFixOpened call s:CustomizeYcmQuickFixWindow()

" https://github.com/ycm-core/YouCompleteMe/issues/3272
autocmd User YcmQuickFixOpened autocmd! ycmquickfix WinLeave

" https://github.com/ycm-core/YouCompleteMe/blob/master/README.md#symbol-search
nmap <leader>ss <Plug>(YCMFindSymbolInWorkspace)
nmap <leader>yfw <Plug>(YCMFindSymbolInWorkspace)
