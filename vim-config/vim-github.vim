" ============================================================================
" File:        vim-github.vim
" Maintainer:  Derek Bolt <derebolt@itbit.com>
" ============================================================================

function! LinkToGitHub() range
    let b:repoRoot = ChompedSystem('git rev-parse --show-toplevel')
    let b:urlRoot = ChompedSystem('git config --get remote.origin.url | sed "s/git@github.com:/github.com\//" | sed "s/.git$//"')
    let b:branch = ChompedSystem('git status -sb | grep "...origin/" | sed "s/.*origin\///"')
    let b:filePathRelativeToRepoRoot = substitute(expand('%:p'), b:repoRoot, '', '')
    let b:startLine = getpos("'<")[1]
    let b:endLine = getpos("'>")[1]

    let b:url = b:urlRoot."/tree/master/".b:filePathRelativeToRepoRoot."#L".b:startLine."-L".b:endLine
    let @* = b:url
    echo b:url
endfunction

function! ChompedSystem( ... )
    return substitute(call('system', a:000), '\n\+$', '', '')
endfunction

command! -range LinkToGitHub :call LinkToGitHub()

"Default is LEADER-cx
vmap <silent> <leader>cx :LinkToGitHub<CR>
