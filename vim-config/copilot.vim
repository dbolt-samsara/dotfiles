function! CoPilotToggle()
    redir => copilot
    silent execute 'Copilot status'
    redir END

    if stridx(copilot, "Copilot: Disabled") >= 0
        echo "Copilot Enabled"
        execute 'Copilot enable'
    else
        echo "Copilot Disabled"
        execute 'Copilot disable'
    endif
endfunction
nnoremap <C-_> :call CoPilotToggle()<CR>
