" <env_var>
    let $UNDER_VIM='True'
" </env_var>

" <logging>
    let Log = {}

    " g:Log.New(log_file="/var/log/vim")
    fu Log.New(...)
        let new_log = copy(self)

        if a:0 == 0
            let new_log.log_file = "/var/log/vim"
        else
            let new_log.log_file = a:1
        endif

        return new_log
    endfu

    fu Log.log(type, str)
        exec 'silent:!echo ' . a:type . ': ' . a:str . ' >> ' . self.log_file | redraw!
    endfu

    fu Log.debug(str)
        call self.log('debug', a:str)
    endfu

    fu Log.info(str)
        call self.log('info', a:str)
    endfu

    fu Log.warn(str)
        call self.log('warn', a:str)
    endfu

    fu Log.error(str)
        call self.log('error', a:str)
    endfu

    fu Log.critical(str)
        call self.log('critical', a:str)
    endfu

    fu Log.clear()
        exec 'silent:! > ' . self.log_file | redraw!
    endfu

    fu Log.view()
        exec ':pedit ' . self.log_file
    endfu

    " The default log object
    let log = Log.New()
    command! -n=1 LogDebug :call g:log.debug(<f-args>)
    command! -n=1 LogInfo :call g:log.info(<f-args>)
    command! -n=1 LogWarn :call g:log.warn(<f-args>)
    command! -n=1 LogError :call g:log.error(<f-args>)
    command! -n=1 LogCritical :call g:log.critical(<f-args>)
    command! -n=0 LogClear :call g:log.clear(<f-args>)
    command! -n=0 LogView :call g:log.view(<f-args>)
" </logging>

" <settings>
    " <general>
        set nocompatible
        set history=50 " keep 50 lines of command line history
        set backup
        set backupdir=~/.vim/backup
        set directory=~/.vim/tmp
        set backspace=2
        set magic " Allows pattern matching with special characters. (Example :%s/,/ /g)
        set modeline " Enable modelines
        set shell=/bin/bash\ -l\ -O\ expand_aliases
    " </general>

    " <bash_like_tab_completion>
        set wildmode=longest,list,full
        set wildmenu
    " </bash_like_tab_completion>

    " <folding>
        set foldcolumn=1
    " </folding>

    " <display>
        syntax on
        set ruler		                 " show the cursor position all the time
        set showmatch                    " When a bracket is inserted, briefly jump to the matching one
        set number                       " Print the line number in front of each line
        set background=dark              " When set to "dark", Vim will try to use colors that look good
                                         " on a dark background.
        set visualbell t_vb=             " When no beep or flash is wanted, use ":set vb t_vb=".
                                         " Tabs to spaces

        set nohlsearch                   " Disable search result highlighting

        colorscheme desert256            " For more info about set
    " </display>

    " <tabs>
        set expandtab                    " In Insert mode: Use the appropriate number of spaces to insert
                                         " a <tTab>
        set tabstop=4                    " Number of spaces that a <Tab> in the file counts for.
        set shiftwidth=4                 " Number of spaces to use for each step of (auto)indent.
    " </tabs>

    " <search>
        set ignorecase
    " </search>

    " <format>
        " auto formatting settings (:help fo-table):
        " For auto-wrapping add t
        set formatoptions=croql
        set textwidth=79
    " </format>

    " <splitted_view>
        " Set window's minimal height
        set wh=40
        set previewheight=50
    " </splitted_view>

    " <persistent_undo>
        set undodir=~/.vim/undo/
        set undofile
        set undolevels=1000 "maximum number of changes that can be undone
        set undoreload=10000 "maximum number lines to save for undo on a buffer reload
    " </persistent_undo>

    " <filetype>
        filetype indent on
        filetype plugin on " Enable ftplugins
    " </filetype>

    " <statusline>
        set laststatus=2
        " <full path to the file in the buffer>\
        " <modified flag><readonly flag><help buffer flag>\
        " <preview window flag> [<fileformat>/<filetype>/<syntax>] \
        " [<line>/<column>/<percentage through file in lines>] \
        " <fugitive plugin git status>
        set statusline=%F%m%r%h%w\ [%{&ff}/%{&ft}/%{&syntax}]\ [%l,%v\|%p%%]
    " </statusline>
" </settings>

" <auto>
    " jump to the last position when reopening a file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

    " Save file's current folding on window close and reload it next time
    " au BufWinLeave ?* mkview
    " au BufWinEnter ?* silent loadview

    " Workaround for what seems to be a bug with previewheight
    au BufEnter * call PreviewHeightWorkAround()
    func! PreviewHeightWorkAround()
        if &previewwindow
            exec 'setlocal winheight='.&previewheight
        endif
    endfunc

    " diff mode specific maps
    au FilterWritePre * call DiffModeMaps()

    " <resource_vimrc_onchange>
        autocmd! bufwritepost .vimrc source %
    " </resource_vimrc_onchange>
" </auto>

" <maps>
    " <f>
        noremap <F2> :NERDTreeToggle<CR>
        noremap <F3> :set invrl<CR>
        noremap <F4> :set invspell<CR>
        noremap <F5> :set invpaste<CR>
    " </f>

    " <folding>
        noremap <silent> <S-F> :call ToggleFold()<CR>
        noremap f zA
        noremap <space> za
        vnoremap <space> zf
    " </folding>

    " <git>
        noremap <Leader>gC :!git cola<CR>
        noremap <Leader>gc :Gcommit<CR>
        noremap <Leader>gs :Gstatus<CR>
        noremap <Leader>gS :call GitDiffColorFlawWorkAround()<CR>
        func! GitDiffColorFlawWorkAround()
            Gdiff
            redraw!
            wincmd h
        endfunc
        noremap <Leader>gd :!gd<CR>
        noremap <Leader>gD :!gD<CR>
    " </git>

    " <windows_navigation>
        noremap <C-J> <C-W>j
        noremap <C-K> <C-W>k
        noremap <C-H> <C-W>h
        noremap <C-L> <C-W>l
    " </windows_navigation>

    " <reloading>
        noremap <silent> <leader>rs :call ReloadAllSnippets()<CR>
        noremap <silent> <leader>rh :HelptagsLocal<CR>
    " </reloading>

    " <diff>
        func! DiffModeMaps()
            " diff undos
            " (http://stackoverflow.com/questions/945023/undoing-diff-put-when-copying-lines-between-vimdiff-windows)
            nnoremap du :wincmd w<CR>:normal u<CR>:wincmd w<CR>

            vnoremap do :diffget<CR>
            vnoremap dp :diffput<CR>

            augroup diff
                au BufWinLeave <buffer> call RemoveDiffModeMaps()
            augroup END
        endfunc

        func! RemoveDiffModeMaps()
            nunmap du

            vunmap do
            vunmap dp

            augroup diff
                au!
            augroup END
        endfunc
    " </diff>

    " <logging>
        noremap <silent> <leader>l :call log.view()<CR>
        noremap <silent> <leader>cl :call log.clear()<CR>
    " </logging>

    " <yankring>
        nnoremap <silent> <F11> :YRShow<CR>
    " </yankring>

    " <resource_current_file>
        nnoremap <silent> <F12> :so %<CR>
    " </resource_current_file>
" </maps>

" <command>
    command! Wr w! !sudo tee % > /dev/null %
    command! W w
    command! HelptagsLocal helptags $HOME/.vim/doc
" </command>

" <plugins>
    " <nerdtree>
        let NERDTreeWinPos = "right"
    " </nerdtree>
    " <supertab>
        "let g:SuperTabMappingBackward   = '<tab>'
        "let g:SuperTabMappingForward    = '<k-tab>'
        "let g:SuperTabMappingTabLiteral = '<s-tab>'
    " </supertab>
    " <pathogen>
        call pathogen#runtime_append_all_bundles()
        call pathogen#helptags()
    " </pathogen>
    " <localvimrc>
        let g:localvimrc_ask = 0 " Ask before sourcing local vimrc files. 
        let g:localvimrc_sandbox = 0 " Don't source the found local vimrc files in a sandbox
    " </localvimrc>
" </plugins>

" <source_functions>
    so ~/.vim/functions/toggle_fold.vim
" </source_functions>
