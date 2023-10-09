" See ~/.vim/bundle/vim-go/ftplugin/.go.vim 
"
let g:go_def_mapping_enabled = 0
let g:go_list_type = "quickfix"
let g:go_highlight_operators = 1
let g:go_auto_sameids = 1
let g:go_test_timeout = '60s'
let g:go_fmt_command = 'goimports'
  let g:go_fmt_options = {
    \ 'gofmt': '-s',
    \ 'goimports': '-local github.com/paxosglobal',
    \ }

nnoremap <leader>ga :GoAlternate<CR>
nnoremap <leader>gd :GoDeclsDir<CR>
nnoremap <leader>gp :GoDefPop<CR>
nnoremap <leader>gi :GoImplements<CR>

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#test#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

autocmd FileType go nmap <leader>gb :<C-u>call <SID>build_go_files()<CR>
