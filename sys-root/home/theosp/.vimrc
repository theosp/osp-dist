" <env_var>
    let $UNDER_VIM='True'
" </env_var>

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
        set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%{&ft}]\ [SYNTAX=%{&syntax}]\ [%p%%]\ %{fugitive#statusline()}
    " </statusline>
" </settings>

" <auto>
    " jump to the last position when reopening a file
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

    " Save file's current folding on window close and reload it next time
    au BufWinLeave ?* mkview
    au BufWinEnter ?* silent loadview
" </auto>

" <maps>
    " <f>
        noremap <F2> :NERDTreeToggle<CR>
        noremap <F3> :set invrl<CR>
        noremap <F4> :set invspell<CR>
        noremap <F5> :set invpaste<CR>
    " </f>

    " <folding>
        noremap <buffer> f za
        noremap <buffer> F :call ToggleFold()<CR>
    " </folding>

    " <git>
        noremap <Leader>gC :!git cola<CR>
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
        " diff undos
        " (http://stackoverflow.com/questions/945023/undoing-diff-put-when-copying-lines-between-vimdiff-windows)
        noremap du :wincmd w<CR>:normal u<CR>:wincmd w<CR>

        vnoremap do :diffget<CR>
        vnoremap dp :diffput<CR>
    " </diff>

    " <yankring>
        nnoremap <silent> <F11> :YRShow<CR>
    " </yankring>
" </maps>

" <command>
    command Wr w !sudo tee % > /dev/null %
    command W w
    command HelptagsLocal helptags $HOME/.vim/doc
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
