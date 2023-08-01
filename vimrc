" *********************************************
" Plugins
" *********************************************
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

" Add plugins here. String routes to github location.
Plugin 'VundleVim/Vundle.vim' "Vim package manager, makes all the vim plugins work

"Style / Themes / Aesthetics
Plugin 'flazz/vim-colorschemes' "Vim color schemes
Plugin 'powerline/fonts' "Powerline fonts
Plugin 'edkolev/tmuxline.vim' "Tmux integration with vim-airline
Plugin 'bling/vim-airline' "Status line for VIM
Plugin 'vim-airline/vim-airline-themes' "VIM-airline themes
Plugin 'Yggdroot/indentLine' "Highlights indents
Plugin 'kien/rainbow_parentheses.vim' "Colored parenthesis, brackets, and curly braces


"IDE Like Stuff
Plugin 'kien/ctrlp.vim' "Type ctrl+p and serach for files easily
Plugin 'scrooloose/nerdtree' "Easy to use file browser, type ctrl+t
Plugin 'scrooloose/nerdcommenter' "Vim plugin for intensely orgasmic commenting
Plugin 'scrooloose/syntastic' "Syntax checking hacks for vim, displays errors on left after save
Plugin 'ycm-core/YouCompleteMe' "Auto complete while you type
Plugin 'Raimondi/delimitMate' "Auto add dual quotes, parenthesis, brackets, etc.
Plugin 'preservim/tagbar' "See your tags in code, functions, variables, classes, etc.
Plugin 'tpope/vim-surround' "Surrounds words with parentheses, brackets, quotes, XML tags, and more.

"Searching / Movement / Selection
Plugin 'rking/ag.vim' "Easy AG with VIM
Plugin 'haya14busa/incsearch.vim' "Improved vim search, '/'
Plugin 'easymotion/vim-easymotion' "Vim motion on speed
Plugin 'terryma/vim-multiple-cursors' "Submlime multiple text selection

" Python
Plugin 'vim-python/python-syntax' "Python syntax highlighting for Vim
Plugin 'nvie/vim-flake8' "Flake8 plugin for Vim, press F7 to see output
Plugin 'vim-scripts/indentpython.vim' "match indentation for PEP 8
Plugin 'psf/black' "The uncompromising Python code formatter
Plugin 'fisadev/vim-isort' "Vim plugin to sort python imports

" Go
Plugin 'fatih/vim-go' "This plugin adds Go language support for Vim

" Yaml
Plugin 'stephpy/vim-yaml' "Override default vim yaml

Plugin 'tpope/vim-fugitive' "Git wrapper so awesome, it should be illegal
Plugin 'Konfekt/vim-alias' "Vim aliases, make aliases over vim functions

" PlantUML
Plugin 'tyru/open-browser.vim'
Plugin 'aklt/plantuml-syntax' 
Plugin 'weirongxu/plantuml-previewer.vim'

" To find duplicate mappings.  E.g. <leader>p duplicates:
" :verbose map <leader>p

" ********************************************
" ********** Important defaults **************
" ********************************************

"Allow backspacing breaks
set backspace=indent,eol,start

syntax on
filetype plugin indent on
set autoindent
set autowrite
set clipboard=unnamed

"See flazz/vim-colorschemes for other color schemes
colorscheme smyck
"colorscheme monokai
"set termguicolors
set t_Co=256

"Use spaces instead of tabs
set tabstop=4 softtabstop=4 expandtab shiftwidth=4

" Persistent undo
set undodir=~/.vim/undodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

" Set swapfile directory
set directory=~/.vim/swapfiles//

" Remove trailing whitespace
"autocmd BufWritePre * %s/\s\+$//e

" Setup json files to use javascript formatting
autocmd BufNewFile,BufRead *.json set ft=javascript

" Add spell check and line length to gitcommit
autocmd Filetype gitcommit setlocal spell textwidth=72

" copy / paste
if has("clipboard")
  set clipboard=unnamed " copy to the system clipboard

  if has("unnamedplus") " X11 support
    set clipboard+=unnamedplus
  endif
endif

" Enable folding
set foldmethod=indent
set foldlevel=99

" *************************************************
" *************** Remap common keys ***************
" *************************************************

" Remap leader to space
let mapleader="\<Space>"
set timeoutlen=250 ttimeoutlen=0

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
inoremap <C-d> <Esc>lxi

inoremap <silent><expr> <CR> pumvisible() ? "\<Esc>\<CR>" : "\<CR>"

" Map F2 to paste toggle
set pastetoggle=<F2>

" Set absolute line number
set nu

" Toggle line numbers
nmap <Leader>n :set rnu!<CR>

" Map Ag (silver search) to leader-A
nmap <Leader>a :Ag<CR>

" Press F3 to toggle highlighting on/off, and show current value.
:noremap <F3> :set hlsearch! hlsearch?<CR>

" Map F5 to toggle spell check
:map <F5> :setlocal spell! spelllang=en_us<CR>

map  <C-A> <Home>
imap <C-A> <Home>
vmap <C-A> <Home>
map  <C-E> <End>
imap <C-E> <End>
vmap <C-E> <End>

" *************************************************************
" ***************** Buffer interactions ***********************
" *************************************************************

"Map Ctrl-W j,i,k,l to Ctrl-j,i,k,l. Used for switching to vim buffers easily
nmap <silent> <C-k> :wincmd k<CR>
nnoremap <silent> <C-j> :wincmd j<CR>
nnoremap <silent> <C-h> :wincmd h<CR>
nnoremap <silent> <C-l> :wincmd l<CR>

" https://stackoverflow.com/questions/31805805/vim-close-buffer-with-nerdtree
" close buffer
nnoremap <Leader>d :bp\|bd #<CR>

" close split, keep buffer open
nnoremap <silent><Leader>ds :close<CR>

" inspired by https://stackoverflow.com/questions/16082991/vim-switching-between-files-rapidly-using-vanilla-vim-no-plugins
" next buffer
nnoremap ) :bn<CR>

" previous buffer
nnoremap ( :bp<CR>

" go to last buffer
nnoremap _ :e #<CR>

" list buffer prompt
nnoremap <Leader>l :ls<CR>:b<Space>

" horizontal split buffer
nnoremap <silent><Leader>hs :sp<CR>:wincmd j<CR>

" vertical split buffer
nnoremap <silent><Leader>vs :vs<CR>:wincmd l<CR>

"highlight VertSplit guibg=Orange guifg=Black ctermbg=6 ctermfg=0

" *************************************************************
" ***************** Quick Fix interactions ********************
" *************************************************************

" Quick Fix keys. http://vimdoc.sourceforge.net/htmldoc/quickfix.html#quickfix-window
" https://stackoverflow.com/questions/1747091/how-do-you-use-vims-quickfix-feature
nnoremap ]q          :cnext<CR>
nnoremap [q          :cprevious<CR>
nnoremap ]Q          :clast<CR>
nnoremap [Q          :cfirst<CR>
 
" https://github.com/fatih/vim-go/issues/108
" Position the (global) quickfix window at the very bottom of the window
" (useful for making sure that it appears underneath splits)
" NOTE: Using a check here to make sure that window-specific location-lists
" aren't effected, as they use the same `FileType` as quickfix-lists.
autocmd FileType qf if (getwininfo(win_getid())[0].loclist != 1) | wincmd J | endif

" Toggle Quickfix Window
" https://vim.fandom.com/wiki/Toggle_to_open_or_close_the_quickfix_window
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  " Auto adjust window height to min 3, max 10
  au FileType qf call AdjustWindowHeight(3, 10)

  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

function! QuickFixOpenBig()
    au FileType qf call AdjustWindowHeight(3, 50)
endfunction

"nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>c :call ToggleList("Quickfix List", 'c')<CR>
nmap <silent> <leader>cb :call QuickFixOpenBig()<CR>


" *************************************************************
" ***************** Cool helper functions *********************
" *************************************************************

" Set 'vp' to not replace paste buffer
" http://stackoverflow.com/questions/290465/vim-how-to-paste-over-without-overwriting-register
function! RestoreRegister()
    let @" = s:restore_reg
    if &clipboard == "unnamed"
        let @* = s:restore_reg
    endif
    return ''
endfunction
function! s:Repl()
    let s:restore_reg = @"
    return "p@=RestoreRegister()\<cr>"
endfunction
vmap <silent> <expr> p <sid>Repl()

" Zoom / Restore window.
" http://stackoverflow.com/questions/13194428/is-better-way-to-zoom-windows-in-vim-than-zoomwin
function! s:ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
command! ZoomToggle call s:ZoomToggle()
nnoremap <silent> <leader>z :ZoomToggle<CR>

" ************************************************************
" ** Look at ~/.vim/config/**.*.vim for VIM plugin dotfiles **
" ************************************************************
runtime! config/**/*.vim

" ************************************************************
" ** Look at ~/.vim/after/vimrc.vim **
" ************************************************************
if exists('s:loaded_vimafter')
  silent doautocmd VimAfter VimEnter *
else
  let s:loaded_vimafter = 1
  augroup VimAfter
    autocmd!
    autocmd VimEnter * source ~/.vim/after/vimrc.vim
  augroup END
endif
