function! ToggleFold()
    try
        if( b:folded == 0 )
            exec "normal! zM"
            let b:folded = 1
        else
            exec "normal! zR"
            let b:folded = 0
        endif
    catch /Undefined variable/
        exec "normal! zR"
        let b:folded = 0
    endtry
endfunction
