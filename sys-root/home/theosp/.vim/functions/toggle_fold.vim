function! ToggleFold()
    if( &foldlevel == 0 )
        normal! zR
    else
        normal! zM
    endif
endfunction
