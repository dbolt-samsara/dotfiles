" See ~/.vim/bundle/vim-go/ftplugin/.go.vim 
"
let g:go_bin_path = "/Users/derekbolt/go/bin"
let g:go_def_mapping_enabled = 0
let g:go_list_type = "quickfix"
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_operators = 1
let g:go_auto_sameids = 1
let g:go_test_timeout = '60s'
let g:go_fmt_command = 'goimports'
let g:go_fmt_options = {
    \ 'gofmt': '-s',
\ }
let g:go_debug_windows = {
    \ 'vars':       'leftabove 30vnew',
    \ 'stack':      'leftabove 20new',
    \ 'goroutines': 'botright 10new',
    \ 'out':        'botright 5new',
\ }
let g:go_debug_mappings = {
    \ '(go-debug-continue)':   {'key': '<F5>'},
    \ '(go-debug-print)':      {'key': '<F6>'},
    \ '(go-debug-breakpoint)': {'key': '<F9>'},
    \ '(go-debug-next)':       {'key': '<F10>'},
    \ '(go-debug-step)':       {'key': '<F11>'},
    \ '(go-debug-halt)':       {'key': '<F8>'},
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
