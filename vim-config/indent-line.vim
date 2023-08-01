let g:indentLine_enabled = 1
nnoremap <leader>il :IndentLinesToggle<CR>

" set go files to use ¦ at a light grey color
autocmd FileType go set list lcs=tab:\¦\ "(last character is a space...)
autocmd FileType go hi SpecialKey ctermfg=237
