let g:EclimProjectTreeAutoOpen=0 " open Eclipse project tree automatically
let g:EclimProjectTreeExpandPathOnOpen=1
let g:EclimProjectTreeSharedInstance=1 " share tree instance through all tabs
" use tabnew instead of split for new action
let g:EclimProjectTreeActions = [ {'pattern': '.*', 'name': 'Tab', 'action': 'edit'} ]
let g:EclimJavaSearchSingleResult = 'edit'
let g:EclimLocateFileDefaultAction = 'edit'
let g:EclimDefaultFileOpenAction = 'edit'
let g:EclimCompletionMethod = 'omnifunc'

nnoremap <leader>je :Java<CR>
nnoremap <leader>jt :ProjectTreeToggle<CR>
nnoremap <leader>ji :JavaImportOrganize<CR>
nnoremap <leader>f :JavaFormat<CR>
nnoremap <leader>jd :JavaDocPreview<CR>
nnoremap <leader>jc :JavaCorrect<CR>
nnoremap <leader>j :lnext<CR>
nnoremap <leader>k :lprev<CR>
nnoremap <leader>o :lopen<CR>

" Unit testing
nnoremap <leader>ju :JUnit<CR>

" Searching
nnoremap <leader>js :JavaSearch<CR>
nnoremap <leader>jr :JavaSearch -x references<CR>
