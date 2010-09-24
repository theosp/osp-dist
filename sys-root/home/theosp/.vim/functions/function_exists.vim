" return 1 if function exists 0 if not
function! FunctionExists(functionName)
    try
        call function(a:functionName)
    catch /E700.*/ " E700 raised when the function doesn't exists
        return 0
    endtry

    return 1
endfunction
