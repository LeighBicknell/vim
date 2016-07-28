let $HOME = "/home/leigh"

" Neovim segregation support
if has('nvim')
    let s:editor_root=expand($HOME . "/.nvim")
    let $editor_root=s:editor_root
else
    let s:editor_root=expand($HOME . "/.vim")
    let $editor_root=s:editor_root
endif


" .vimrc.before {
    " CYGWIN {
         if has("win32") && $SHELL == "/bin/bash" && executable("C:/cygwin/bin/bash")
            let $TMP = $HOME . "/AppData/Local/Temp/"
            set shell=C:/cygwin/bin/bash
            set shellcmdflag=-c
            set shellxquote=\"
            let g:cygwin=1
        endif
    " }

    let g:bundle_groups=['general', 'programming', 'php', 'javascript', 'html']
    let g:php_refactor_command='php-refactor'
    let g:xml_syntax_folding=1
    "au FileType xml setlocal foldmethod=syntax
"}

" Environment {

    " Basics {
        set nocompatible        " Must be first line
        if !(has('win16') || has('win32') || has('win64'))
            set shell=/bin/bash
        endif
    " }

    " Windows Compatible {
        " On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
        " across (heterogeneous) systems easier.
        if has('gui_running')
            if has('win32') || has('win64')
                let &rtp = s:editor_root .','.$VIMRUNTIME

                " Be nice and check for multi_byte even if the config requires
                " multi_byte support most of the time
                if has("multi_byte")
                    " Windows cmd.exe still uses cp850. If Windows ever moved to
                    " Powershell as the primary terminal, this would be utf-8
                    set termencoding=cp850
                    " Let Vim use utf-8 internally, because many scripts require this
                    set encoding=utf-8
                    setglobal fileencoding=utf-8
                    " Windows has traditionally used cp1252, so it's probably wise to
                    " fallback into cp1252 instead of eg. iso-8859-15.
                    " Newer Windows files might contain utf-8 or utf-16 LE so we might
                    " want to try them first.
                    set fileencodings=ucs-bom,utf-8,utf-16le,cp1252,iso-8859-15
                endif
            endif
        endif
    " }
    " Setup Bundle Support {
        filetype on
        filetype off
        " Add YCM to path
        "set rtp+=$HOME/.vim/vim-ycm
        " Add PHPMAN to path
        let &rtp = &rtp . ',' . s:editor_root . '/vim-PHPMAN'
        " add Vundle to path
        let &rtp = &rtp . ',' . s:editor_root . '/bundle/vundle'
        call vundle#rc(s:editor_root . '/bundle')
    " }

" }

" Bundles {

    " Deps {
        Bundle 'gmarik/vundle'
        Bundle 'MarcWeber/vim-addon-mw-utils'
        Bundle 'tomtom/tlib_vim'
        Bundle 'Shougo/vimproc.vim'
        "  if executable('ack-grep')
        "       let g:ackprg="ack-grep -H --nocolor --nogroup --column"
        "       Bundle 'mileszs/ack.vim'
        "   elseif executable('ack')
        "       Bundle 'mileszs/ack.vim'
        "   elseif executable('ag')
        "       Bundle 'mileszs/ack.vim'
        "       let g:ackprg = 'ag --nogroup --nocolor --column --smart-case --path-to-agignore '.s:editor_root.'/.agignore'
        "   endif
        Bundle 'mhinz/vim-grepper'
    " }

    " General {
        if count(g:bundle_groups, 'general')
            Bundle 'godlygeek/csapprox'
            Bundle 'altercation/vim-colors-solarized'
            Bundle 'tpope/vim-repeat'
            Bundle 'tpope/vim-surround'
            Bundle 'tpope/vim-abolish.git'
            Bundle 'tpope/vim-unimpaired'
            Bundle 'tpope/vim-eunuch'
            Bundle 'matchit.zip'
            Bundle 'mbbill/undotree'
            Bundle 'nathanaelkane/vim-indent-guides'
            Bundle 'scrooloose/nerdtree'
            Bundle 'Tab-Name'
            Bundle 'vim-scripts/tcd.vim'
            Bundle 'SirVer/ultisnips'
            Bundle 'mattn/emmet-vim'
            Bundle 'moll/vim-bbye'
            Bundle 'wincent/Command-T'
            "Bundle 'oplatek/Conque-Shell' "Replaced by dispatch
            Bundle 'tpope/vim-dispatch'
            Bundle 'will133/vim-dirdiff'
            " Open browser
            Bundle 'tyru/open-browser.vim'
        endif
    " }

    "
    " General Programming {
        if count(g:bundle_groups, 'programming')
            Plugin 'luochen1990/rainbow'
            Bundle 'scrooloose/syntastic'
            "Git integration
            Bundle 'tpope/vim-fugitive'
            " Syntax, indent and filetype plugins for git, gitcommit, gitconfig
            " etc Earlier versions shipped with VIM
            Bundle 'tpope/vim-git'
            " Git details in gutter
            Bundle 'airblade/vim-gitgutter'
            Bundle 'mattn/webapi-vim'
            Bundle 'scrooloose/nerdcommenter'
            Bundle 'godlygeek/tabular'
            Bundle 'vcscommand.vim'
            Bundle 'vim-scripts/cscope_macros.vim'
            Bundle 'Valloric/YouCompleteMe'
            Bundle 'ap/vim-css-color'
            if has('unix')
                " Requires unix system
                Bundle 'zenbro/mirror.vim'
            endif
        endif
    " }

    " PHP {
        if count(g:bundle_groups, 'php')
            Bundle 'StanAngeloff/php.vim'
            " "This is needed by pdv :/
            Bundle 'tobyS/vmustache'
            " PHPDocBlocks
            Bundle 'shawncplus/phpcomplete.vim'
            Bundle 'FlickerBean/pdv'
            Bundle 'arnaud-lb/vim-php-namespace'
            Bundle 'rayburgemeestre/phpfolding.vim'
            Bundle 'FlickerBean/vim-php-refactoring'
            Bundle 'joonty/vim-phpunitqf'
            Bundle 'stephpy/vim-php-cs-fixer'
            " Wordpress
            " Bundle 'dsawardekar/wordpress.vim'
        endif
    " }

    " Python {
        if count(g:bundle_groups, 'python')
            " Pick either python-mode or pyflakes & pydoc
            Bundle 'klen/python-mode'
            Bundle 'python.vim'
            Bundle 'python_match.vim'
        endif
    " }

    " Javascript {
        if count(g:bundle_groups, 'javascript')
            Bundle 'elzr/vim-json'
            Bundle 'briancollins/vim-jst'
        endif
    " }

    " Java {
        if count(g:bundle_groups, 'scala')
            Bundle 'derekwyatt/vim-scala'
            Bundle 'derekwyatt/vim-sbt'
        endif
    " }

    " Haskell {
        if count(g:bundle_groups, 'haskell')
            Bundle 'travitch/hasksyn'
            Bundle 'dag/vim2hs'
            Bundle 'Twinside/vim-haskellConceal'
            Bundle 'lukerandall/haskellmode-vim'
            Bundle 'ujihisa/neco-ghc'
            Bundle 'eagletmt/ghcmod-vim'
            Bundle 'adinapoli/cumino'
            Bundle 'bitc/vim-hdevtools'
        endif
    " }

    " Ruby {
        if count(g:bundle_groups, 'ruby')
            Bundle 'tpope/vim-rails'
            let g:rubycomplete_buffer_loading = 1
        endif
    " }

    " Go Lang {
        if count(g:bundle_groups, 'go')
            Bundle 'jnwhiteh/vim-golang'
            Bundle 'spf13/vim-gocode'
        endif
    " }

    " Misc {
        if count(g:bundle_groups, 'misc')
            Bundle 'tpope/vim-markdown'
            Bundle 'spf13/vim-preview'
            Bundle 'tpope/vim-cucumber'
            Bundle 'quentindecock/vim-cucumber-align-pipes'
            Bundle 'Puppet-Syntax-Highlighting'
        endif
    " }

    " Twig {
        if count(g:bundle_groups, 'twig')
            Bundle 'beyondwords/vim-twig'
        endif
    " }
" }

" General {
    set fileformats=unix,dos
    " set autowrite                 " automatically write a file when leaving a modified buffer
    set shortmess+=filmnrxoOtT      " Abbrev. of messages (avoids 'hit enter')
    set background=dark             " Assume a dark background
    if !has('gui') && !has('nvim')
        set term=$TERM              " Make arrow and other keys work
    endif
    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    " This linux if isn't working :/
    if has ('unix') && (has ('gui') || has('nvim')) " On Linux use + register for copy-paste
            set clipboard=unnamedplus
    elseif has ('gui')          " On mac and Windows, use * register for copy-paste
        set clipboard=unnamed
    endif

    set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
    set history=1000                    " Store a ton of history (default is 20)
    set hidden                          " Allow buffer switching without saving
    "set foldlevel=1

    " Instead of reverting the cursor to the last position in the buffer, we
    " set it to the first line when editing a git commit message
    au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])

    " http://vim.wikia.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
    " Restore cursor to file position in previous editing session
    " To disable this, add the following to your .vimrc.before.local file:
    "   let g:no_restore_cursor = 1
    if !exists('g:no_restore_cursor')
        function! ResCur()
            if line("'\"") <= line("$")
                normal! g`"
                return 1
            endif
        endfunction

        augroup resCur
            autocmd!
            autocmd BufWinEnter * call ResCur()
        augroup END
    endif

    " Setting up the directories {
        set backup                      " Backups are nice ...
        if has('persistent_undo')
            set undofile                " So is persistent undo ...
            set undolevels=10000        " Maximum number of changes that can be undone
            set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
        endif

    " }
    " Diff ignore all whitespace hack {
        set diffopt+=iwhite
        set diffexpr=
        " disable hack, this disables all whitespace vs changes in amount of
        " whitespace
        " So why did I disable it? re-enabled
        set diffexpr=DiffW()
        function! DiffW()
            let opt = ""
            if &diffopt =~ "icase"
                let opt = opt . "-i "
            endif
            if &diffopt =~ "iwhite"
                let opt = opt . "-w " " vim uses -b by default
            endif
            silent execute "!diff -a --binary " . opt .
                        \ v:fname_in . " " . v:fname_new .  " > " . v:fname_out
        endfunction
    " }
" }

" Vim UI {

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    highlight clear SignColumn      " SignColumn should match background for
                                    " things like vim-gitgutter

    highlight clear LineNr          " Current line number row will have same background color in relative mode.
                                    " Things like vim-gitgutter will match LineNr highlight
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
                                    " This actually stops the cursor vanishing
                                    " for some reason!
    endif

    if has('statusline')
        set laststatus=2

        " Broken down into easily includeable segments
        "set statusline=%<%f\                     " Filename
        "set statusline+=%w%h%m%r                 " Options
        "set statusline+=%{fugitive#statusline()} " Git Hotness
        "set statusline+=\ [%{&ff}/%Y]            " Filetype
        "set statusline+=\ [%{getcwd()}]          " Current dir
        "set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info

        "statusline setup (scrooloose)
        set statusline =%#identifier#
        set statusline+=[%t] "tail of the filename
        set statusline+=%*

        "display a warning if fileformat isnt unix
        set statusline+=%#warningmsg#
        set statusline+=%{&ff!='unix'?'['.&ff.']':''}
        set statusline+=%*

        "display a warning if file encoding isnt utf-8
        set statusline+=%#warningmsg#
        set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
        set statusline+=%*

        set statusline+=%h "help file flag
        set statusline+=%y "filetype

        "read only flag
        set statusline+=%#identifier#
        set statusline+=%r
        set statusline+=%*

        "modified flag
        set statusline+=%#identifier#
        set statusline+=%m
        set statusline+=%*

        " Seriously slows down vim over network
        "set statusline+=%{fugitive#statusline()}

        "display a warning if &et is wrong, or we have mixed-indenting
        set statusline+=%#error#
        set statusline+=%{StatuslineTabWarning()}
        set statusline+=%*

        set statusline+=%{StatuslineTrailingSpaceWarning()}

        set statusline+=%{StatuslineLongLineWarning()}

        set statusline+=%#warningmsg#
        set statusline+=%{SyntasticStatuslineFlag()}
        set statusline+=%*

        "display a warning if &paste is set
        set statusline+=%#error#
        set statusline+=%{&paste?'[paste]':''}
        set statusline+=%*

        set statusline+=%= "left/right separator
        set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
        set statusline+=%c, "cursor column
        set statusline+=%l/%L "cursor line/total lines
        set statusline+=\ %P "percent through file
        set laststatus=2

        "recalculate the trailing whitespace warning when idle, and after saving
        autocmd cursorhold,bufwritepost * unlet! b:statusline_trailing_space_warning

        "return '[\s]' if trailing white space is detected
        "return '' otherwise
        function! StatuslineTrailingSpaceWarning()
            if !exists("b:statusline_trailing_space_warning")

                if !&modifiable
                    let b:statusline_trailing_space_warning = ''
                    return b:statusline_trailing_space_warning
                endif

                if search('\s\+$', 'nw') != 0
                    let b:statusline_trailing_space_warning = '[\s]'
                else
                    let b:statusline_trailing_space_warning = ''
                endif
            endif
            return b:statusline_trailing_space_warning
        endfunction


        "return the syntax highlight group under the cursor ''
        function! StatuslineCurrentHighlight()
            let name = synIDattr(synID(line('.'),col('.'),1),'name')
            if name == ''
                return ''
            else
                return '[' . name . ']'
            endif
        endfunction

        "recalculate the tab warning flag when idle and after writing
        autocmd cursorhold,bufwritepost * unlet! b:statusline_tab_warning

        "return '[&et]' if &et is set wrong
        "return '[mixed-indenting]' if spaces and tabs are used to indent
        "return an empty string if everything is fine
        function! StatuslineTabWarning()
            if !exists("b:statusline_tab_warning")
                let b:statusline_tab_warning = ''

                if !&modifiable
                    return b:statusline_tab_warning
                endif

                let tabs = search('^\t', 'nw') != 0

        "find spaces that arent used as alignment in the first indent column
                let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0

                if tabs && spaces
                    let b:statusline_tab_warning = '[mixed-indenting]'
                elseif (spaces && !&et) || (tabs && &et)
                    let b:statusline_tab_warning = '[&et]'
                endif
            endif
            return b:statusline_tab_warning
        endfunction

        "recalculate the long line warning when idle and after saving
        autocmd cursorhold,bufwritepost * unlet! b:statusline_long_line_warning

        "return a warning for "long lines" where "long" is either &textwidth or 80 (if
        "no &textwidth is set)
        "
        "return '' if no long lines
        "return '[#x,my,$z] if long lines are found, were x is the number of long
        "lines, y is the median length of the long lines and z is the length of the
        "longest line
        function! StatuslineLongLineWarning()
            if !exists("b:statusline_long_line_warning")

                if !&modifiable
                    let b:statusline_long_line_warning = ''
                    return b:statusline_long_line_warning
                endif

                let long_line_lens = s:LongLines()

                if len(long_line_lens) > 0
                    let b:statusline_long_line_warning = "[" .
                                \ '#' . len(long_line_lens) . "," .
                                \ 'm' . s:Median(long_line_lens) . "," .
                                \ '$' . max(long_line_lens) . "]"
                else
                    let b:statusline_long_line_warning = ""
                endif
            endif
            return b:statusline_long_line_warning
        endfunction

        "return a list containing the lengths of the long lines in this buffer
        function! s:LongLines()
            let threshold = (&tw ? &tw : 80)
            let spaces = repeat(" ", &ts)
            let line_lens = map(getline(1,'$'), 'len(substitute(v:val, "\\t", spaces, "g"))')
            return filter(line_lens, 'v:val > threshold')
        endfunction

        "find the median of the given array of numbers
        function! s:Median(nums)
            let nums = sort(a:nums)
            let l = len(nums)

            if l % 2 == 1
                let i = (l-1) / 2
                return nums[i]
            else
                return (nums[l/2] + nums[(l/2)-1]) / 2
            endif
        endfunction
    endif

    set backspace=indent,eol,start  " Backspace for dummies
    set diffopt+=vertical           " Vertical diff
    set linespace=0                 " No extra spaces between rows (-1 for a few more lines on a screen)
    set nu                          " Line numbers on
    "set relativenumber              " Relative numbering, slow but handy
    "set cursorline                  " Highlight current line, slow but handy
    "set cursorcolumn                " Now we've got smooth scroll we may aswell go all out!
    "au VimEnter * NoMatchParen
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=longest,list,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    "set scrolljump=5                " Lines to scroll when cursor leaves screen
    "set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:>\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
    set timeout                     " Wait for timeouts
    set timeoutlen=2000             " Wait 2 seconds for mapping timeouts (ysiw etc)
    set ttimeoutlen=100             " Wait 100ms for keycode mappings

" }

" Formatting {

    set wrap                        " Wrap because of formatoptions only wrapping comments
    set formatoptions=qwbcj         " gq format comments, " removed autowrap comments, due to fiblock
                                    " autoformat comments, remove comment tags when joining lines
    set textwidth=79
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set matchpairs+=<:>             " Match, to be used with %
    set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    highlight ColorColumn ctermbg=235
    let &colorcolumn="81,".join(range(121,999),",") " Highlight column 81 and then 121 onwards
    autocmd FileType c,cpp,css,less,scss,sass,java,go,php,php.wordpress,javascript,python,twig,xml,yml autocmd BufWritePre <buffer> if !exists('g:keep_trailing_whitespace') | call StripTrailingWhitespace() | endif
    autocmd FileType go autocmd BufWritePre <buffer> Fmt
    autocmd BufNewFile,BufRead *.html.twig set filetype=html.twig
    autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2
    autocmd BufNewFile,BufRead *.coffee set filetype=coffee

    " Workaround vim-commentary for Haskell
    autocmd FileType haskell setlocal commentstring=--\ %s
    " Workaround broken colour highlighting in Haskell
    autocmd FileType haskell setlocal nospell

" }

" Key (re)Mappings {

    " The default leader is '\', but many people prefer ',' as it's in a standard
    " location. To override this behavior and set it back to '\' (or any other
    " character) add the following to your .vimrc.before.local file:
    "   let g:leader='\'
    if !exists('g:leader')
        let mapleader = ','
    else
        let mapleader=g:leader
    endif

    " Fix syntax highlighting
    noremap <F12> <Esc>:syntax sync fromstart<CR>
    inoremap <F12> <C-o>:syntax sync fromstart<CR>

    nmap <c-s> :update<CR>
    vmap <c-s> <Esc><c-s>gv
    imap <c-s> <Esc><c-s>

    " Yank from the cursor to the end of the line, to be consistent with C and D.
    noremap Y y$

    " Code folding options
    nmap <leader>f0 :set foldlevel=0<CR>
    nmap <leader>f1 :set foldlevel=1<CR>
    nmap <leader>f2 :set foldlevel=2<CR>
    nmap <leader>f3 :set foldlevel=3<CR>
    nmap <leader>f4 :set foldlevel=4<CR>
    nmap <leader>f5 :set foldlevel=5<CR>
    nmap <leader>f6 :set foldlevel=6<CR>
    nmap <leader>f7 :set foldlevel=7<CR>
    nmap <leader>f8 :set foldlevel=8<CR>
    nmap <leader>f9 :set foldlevel=9<CR>

    " Most prefer to toggle search ighlighting rather than clear the current
    " search results. To clear search highlighting rather than toggle it on
    " and off, add the following to your .vimrc.before.local file:
    "   let g:clear_search_highlight = 1
    if exists('g:clear_search_highlight')
        nmap <silent> <leader>/ :nohlsearch<CR>
    else
        nmap <silent> <leader>/ :set invhlsearch<CR>
    endif


    " Find merge conflict markers
    map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cabbr cwd lcd %:p:h
    cabbr cd. lcd %:p:h

    " For when you forget to sudo.. Really Write the file.
    cabbr w!! w !sudo tee % >/dev/null

    " Some helpers to edit mode
    " http://vimcasts.org/e/14
    cnoremap %% <C-R>=expand('%:h').'/'<CR>
    map <leader>ew :e %%
    map <leader>es :sp %%
    map <leader>ev :vsp %%
    map <leader>et :tabe %%

    " Adjust viewports to the same size
    map <Leader>= <C-w>=

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    map zl zL
    map zh zH

    " Multipage (scrollbind)
    "nmap <silent> <Leader>ef :vsplit<bar>wincmd l<bar>exe "norm! Ljz<c-v><cr>"<cr>:set scb<cr>:wincmd h<cr> :set scb<cr>


    " NeoVim Mappings {
    if has('nvim')
        " Terminal esc
        tnoremap <Esc> <C-\><C-N>

        " Terminal window change mappings
        tnoremap <A-h> <C-\><C-n><C-w>h
        tnoremap <A-j> <C-\><C-n><C-w>j
        tnoremap <A-k> <C-\><C-n><C-w>k
        tnoremap <A-l> <C-\><C-n><C-w>l
        nnoremap <A-h> <C-w>h
        nnoremap <A-j> <C-w>j
        nnoremap <A-k> <C-w>k
        nnoremap <A-l> <C-w>l
    endif
    " }
" }

" Plugins {

    " Misc {
        let g:NERDShutUp=1
        let b:match_ignorecase = 1
        " vim-css-color for scss and sass (and less)
        autocmd FileType less,sass,scss,stylus,vim syn cluster sassCssAttributes add=@cssColors
    " }

    " Ack-grep {
        "nnoremap <Leader>pa :Ack --php <c-r><c-w><CR>
    " }

    " Bbye {
        nnoremap <Leader>q :Bdelete<CR>
        nnoremap <Leader>Q :Bdelete!<CR>
    " }

    " Cscope {
        set cst
        if filereadable("cscope.out")
            "shut up msgs
            set nocsverb
            cs add cscope.out -C
            "msgs back on
            set csverb
            "I'd rather do these separately and know which is comeing from
            "where
            set nocscopetag
        endif

        " Create cscope connection (we only want one connection at once, due to
        " multiple projects open at once (one per tab) we could auto add
        " connection on tab change but it isn't worth the slowdown
        nnoremap <F9> :cs kill -1<CR>
                    \:cs add cscope.out . -C<CR>

        "Automatically generate cscope database, Takes a while due to slow remote
        "network drives :(
        nnoremap <F10> :Start find -name '*.php' > cscope.files 
                    \-not -path "*/_archive/*" 
                    \-not -path "*/_archived/*" 
                    \-not -path "*/.git/*" 
                    \-not -path "*/.svn/*" 
                    \-not -path "*/node_modules/*" 
                    \&& cscope -b -i ./cscope.files -f ./cscope.out 
                    \&& rm ./cscope.files -f<CR> 
                    \:cs reset<CR>

        "tags
        nnoremap <F11> :Start -title='ctags-php' ctags-php -R 
                    \--fields=+aimS 
                    \--languages=php 
                    \--exclude="\.svn" 
                    \--exclude="\.git" 
                    \--exclude="*.CVS" 
                    \--exclude="_archive" 
                    \--exclude="_archived" 
                    \--exclude="node_modules" 
                    \--tag-relative=yes 
                    \--totals=yes<CR>

        " These are mapped in the CSCOPE-maps plugin to <C-@> which is
        " interpreted as <NUL> which for some reason doesn't work

        nmap <C-Space>s :scs find s <C-R>=expand("<cword>")<CR><CR>
        nmap <C-Space>g :scs find g <C-R>=expand("<cword>")<CR><CR>
        nmap <C-Space>c :scs find c <C-R>=expand("<cword>")<CR><CR>
        nmap <C-Space>t :scs find t <C-R>=expand("<cword>")<CR><CR>
        nmap <C-Space>e :scs find e <C-R>=expand("<cword>")<CR><CR>
        nmap <C-Space>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
        nmap <C-Space>i :scs find i <C-R>=expand("<cfile>")<CR><CR>
        nmap <C-Space>d :scs find d <C-R>=expand("<cword>")<CR><CR>


        " Hitting CTRL-space *twice* before the search type does a vertical
        " split instead of a horizontal one (vim 6 and up only)

        nmap <C-Space><C-Space>s :vert scs find s <C-R>=expand("<cword>")<CR><CR>
        nmap <C-Space><C-Space>g :vert scs find g <C-R>=expand("<cword>")<CR><CR>
        nmap <C-Space><C-Space>c :vert scs find c <C-R>=expand("<cword>")<CR><CR>
        nmap <C-Space><C-Space>t :vert scs find t <C-R>=expand("<cword>")<CR><CR>
        nmap <C-Space><C-Space>e :vert scs find e <C-R>=expand("<cword>")<CR><CR>
        nmap <C-Space><C-Space>f :vert scs find f <C-R>=expand("<cfile>")<CR><CR>
        nmap <C-Space><C-Space>i :vert scs find i <C-R>=expand("<cfile>")<CR><CR>
        nmap <C-Space><C-Space>d :vert scs find d <C-R>=expand("<cword>")<CR><CR>
    " }

    " CommandT {
        " Use find tool for file searching
        let g:CommandTFileScanner = 'find'
        " Start searching at current directory
        let g:CommandTTraverseSCM = 'pwd'
        let g:CommandTMaxHeight = 30
    " }

    " Ctags {
        set tags=./tags,tags,../tags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }

    " delimitMate {
        au FileType php let b:delimitMate_expand_cr = 1
        au FileType php let b:delimitMate_expand_space = 1
        au FileType php.wordpress let b:delimitMate_expand_cr = 1
        au FileType php.wordpress let b:delimitMate_expand_space = 1
        au FileType css let b:delimitMate_expand_cr = 1
        au FileType css let b:delimitMate_expand_space = 1
        au FileType scss let b:delimitMate_expand_cr = 1
        au FileType scss let b:delimitMate_expand_space = 1
        au FileType less let b:delimitMate_expand_cr = 1
        au FileType less let b:delimitMate_expand_space = 1
        au FileType sass let b:delimitMate_expand_cr = 1
        au FileType sass let b:delimitMate_expand_space = 1
    " }

    " DirDiff {
        " ignore white space in diff
        let g:DirDiffAddArgs = "-w" 
        let g:DirDiffEnableMappings = 1
    " }

    " dispatch {
        "let g:dispatch_compilers =
        nnoremap <Leader>D :Dispatch<CR>
        nnoremap <Leader>nbb :Start npm run build<CR>
        nnoremap <Leader>nfb :Start npm run fastbuild<CR>
        nnoremap <Leader>nbc :Start npm run build:css<CR>
        nnoremap <Leader>nfc :Start npm run fastbuild:css<CR>
        nnoremap <Leader>nbj :Start npm run build:js<CR>
        nnoremap <Leader>nbw :Start npm run watch<CR>
    " }

    " eclim {
        "command! -range -nargs=* Phpman call eclim#web#SearchEngine('http://uk3.php.net/results.php?l=en&p=all&q=<query>', <q-args>, <line1>, <line2>)
        "command! -range -nargs=* Google call eclim#web#SearchEngine('http://www.google.com/search?q=<query>', <q-args>, <line1>, <line2>)
        "let g:EclimPhpIndentDisabled=1
        "let g:EclimCssIndentDisabled=1
        "let g:EclimJavascriptIndentDisabled=1
        "let g:EclimHtmlIndentDisabled=1
        "let g:EclimXmlIndentDisabled=1

        "let g:EclimFileTypeValidate=0
        "let g:EclimPhpValidate=0
        "let g:EclimPhpHtmlValidate=0
        "let g:EclimCssValidate=0
        "let g:EclimHtmlValidate=0
        "let g:EclimLogLevel=0
        "let g:EclimLocateFileDefaultAction='edit'
        "let g:EclimMenus=0
        "let g:EclimProjectTabTreeAutoOpen=0
        "let g:EclimProjectTreeExpandPathOnOpen=1
        "let g:EclimCompletionMethod = 'omnifunc'
        " Turned off because if eclipse closes and re-opens, there's no way to
        " reconntect nailgun without closing and reopening vim :/
        "let g:EclimNailgunKeepAlive=1
        "let g:EclimBufferTabTracking=0

        " Make eclim update eclipses local history (:History command)
        " Turned this off, as I have persistant undo and undo tree, so .....
        " Note to self: I turned this off because DLTK indexing blocks saves
        " until it's finished!
        "let g:EclimKeepLocalHistory=1

        "nmap cop :ProjectTreeToggle<CR>
        "cabbr pt ProjectTab
        "cabbr lf LocateFile
    " }

    " Emmet {
        let g:user_emmet_leader_key = '<c-e>'
    " }

    " Fugitive {
        nnoremap <silent> <leader>gs :Gstatus<CR>
        nnoremap <silent> <leader>gd :Gdiff<CR>
        nnoremap <silent> <leader>gc :Gcommit<CR>
        nnoremap <silent> <leader>gb :Gblame<CR>
        nnoremap <silent> <leader>gl :Glog<CR>
        nnoremap <silent> <leader>gp :Git push<CR>
        nnoremap <silent> <leader>gr :Gread<CR>:GitGutter<CR>
        nnoremap <silent> <leader>gw :Gwrite<CR>:GitGutter<CR>
        nnoremap <silent> <leader>ge :Gedit<CR>
        nnoremap <silent> <leader>gg :GitGutterToggle<CR>
        nnoremap <silent> <leader>ga :GitGutterStageHunk<CR>
        nmap [g <Plug>GitGutterPrevHunk
        nmap ]g <Plug>GitGutterNextHunk
        " Auto remove fugitive buffers
        autocmd BufReadPost fugitive://* set bufhidden=delete
        " Go to parent directory when browsing a tree:
        autocmd User fugitive 
          \ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
          \   nnoremap <buffer> .. :edit %:h<CR> |
          \ endif
    " }
    
    " Grepper {
         " Mimic :grep and make ag the default tool.
        let g:grepper = {
            \ 'tools': ['ag', 'git', 'grep'],
            \ 'open':  1,
            \ 'jump':  0,
            \ 'ag': {
            \   'grepprg': 'ag --vimgrep --smart-case --path-to-agignore="'.$editor_root.'/.agignore"',
            \   }
            \ }
        nnoremap <leader>git :Grepper -tool git -noswitch<cr>
        nnoremap <leader>ag  :Grepper -tool ag -noswitch -cword<cr>
        nnoremap <leader>*   :Grepper -tool ag -noswitch -cword -noprompt<cr>
    " }

    " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
    " }

    " NerdTree {
        nmap cot :NERDTreeToggle<CR>
        nmap coT :NERDTreeFind<CR>

        let NERDTreeShowBookmarks=1
        let NERDTreeIgnore=['\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
        let NERDTreeChDirMode=0
        let NERDTreeMouseMode=1
        let NERDTreeShowHidden=0
        let NERDTreeKeepTreeInNewTab=0
        let NERDTreeHighlightCursorline=0
        "Stop NERDTree hijacking netRW until NERDTree's root opening path is
        "fixed.
        " (I manually fixed this )
            " lib/nerdtree/path.vim
            " function! s:Path._strForEdit()
            "   ...
            "   ...
            "   return fnamemodify(p, ':.') " This line
            " endfunction
        " vcscommand doesn't work on directories in NERDTree
        let NERDTreeHijackNetrw=0
        let g:nerdtree_tabs_open_on_gui_startup=0
    " }

    " OmniComplete {
        if has("autocmd") && exists("+omnifunc")
            autocmd Filetype *
                \if &omnifunc == "" |
                \setlocal omnifunc=syntaxcomplete#Complete |
                \endif
        endif

        hi Pmenu  guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
        hi PmenuSbar  guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermbg=lightgray cterm=NONE
        hi PmenuThumb  guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermbg=darkcyan cterm=NONE

        " Some convenient mappings
        "inoremap <expr> <Esc>      pumvisible() ? "\<C-e>" : "\<Esc>"
        "inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"
        inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
        inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
        inoremap <expr> <C-d>      pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
        inoremap <expr> <C-u>      pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

        " Automatically open and close the popup menu / preview window
        au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
        set complete-=i
        set complete-=t
        set completeopt=menu
    " }

    " PDV {
        let g:pdv_template_dir = $HOME ."/.vim/custom-snippets/pdv"
        nnoremap <leader>pd :call pdv#DocumentWithSnip()<CR>
    " }

    " phpComplete {
        let g:phpcomplete_enhance_jump_to_definition = 1
        let g:phpcomplete_parse_docblock_comments = 1

        "extended {
            "autocmd  FileType  php setlocal omnifunc=phpcomplete_extended#CompletePHP
            let g:phpcomplete_index_composer_command='composer'
        " }
    " }

    " php-cs-fixer {
        " use ,pcd for PhpCsFixerFixDirectory and ,pcf for PhpCsFixerFixFile
        let g:php_cs_fixer_level = "psr2"                 " which level ?
        let g:php_cs_fixer_config = "default"             " configuration
        let g:php_cs_fixer_php_path = "php"               " Path to PHP
        " If you want to define specific fixers:
        let g:php_cs_fixer_fixers_list = "linefeed,short_tag,indentation"
        let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
        let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
        let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
    " }

    " phpfolding.vim {
        let g:DisableAutoPHPFolding = 1
        map <F5> <Esc>:EnableFastPHPFolds<Cr>
        map <F6> <Esc>:EnablePHPFolds<Cr>
        map <F7> <Esc>:DisablePHPFolds<Cr>
    " }

    " PHPMAN {
        " (my own, PIV is too heavy, don't need folding, syntax (7.4
        " includes syntax, etc)

        " Set help for php files properyly
        autocmd FileType php set kp=:help
        autocmd FileType php.wordpress set kp=:help
    " }

    " PyMode {
        let g:pymode_lint_checker = "pyflakes"
        let g:pymode_utils_whitespaces = 0
        let g:pymode_options = 0
    " }

    " PythonMode {
        " Disable if python support not present
        if !has('python')
            let g:pymode = 1
        endif
    " }

    " Rainbow {
        let g:rainbow_active=0
        noremap <Leader>R :RainbowToggle<Cr>
    " }

    " Surround {
        " yss- = php tags
        autocmd FileType php let b:surround_45 = "<?php \r ?>"
    " }

    " syntastic {
        let g:syntastic_check_on_open=0
        let g:syntastic_auto_jump=0
        let g:syntastic_auto_loc_list=1

        " SCSS {

            " Doesn't seem to work with sassc for some reason, use sass for now
            " remember: 
            " sudo apt-get install ruby-dev 
            " sudo gem install --no-user-dir compass
            let g:syntastic_scss_scss_sass_exe="/usr/local/bin/sass"
            let g:syntastic_scss_scss_lint_exe="/usr/local/bin/scss-lint"

            let g:syntastic_scss_checkers=['scss_lint', 'sass']
            let g:syntastic_scss_error_checkers = ['sass']
            let g:syntastic_scss_syntax_checkers = ['scss_lint', 'sass']
        " }


        " PHP {
            let g:syntastic_php_phpcs_args="--standard=PSR2"
            let g:syntastic_php_phpmd_post_args="~/.phpmd/ruleset.xml"

            let g:syntastic_php_checkers = ['php']
            let g:syntastic_php_error_checkers = ['php']
            let g:syntastic_php_syntax_checkers = ['php', 'phpcs', 'phpmd']
            let g:syntastic_wordpress_checkers = ['php']
        " }
        "
        let g:syntastic_mode_map = { 'mode': 'passive',
                                   \ 'active_filetypes': ['php'],
                                   \ 'passive_filetypes': [] }

        nmap <Leader>sc :SyntasticCheck<CR>

        " Switch to 'syntax mode' (Custom mode that checks syntax also)
        function! SyntasticSyntaxMode()
            let g:syntastic_scss_checkers = g:syntastic_scss_syntax_checkers
            let g:syntastic_php_checkers = g:syntastic_php_syntax_checkers
            let g:syntastic_aggregate_errors = 1
        endfunction
        command! SyntasticSyntaxMode call SyntasticSyntaxMode()
        nmap <Leader>ss :SyntasticSyntaxMode<CR>

        " Switch to 'error mode' (custom mode to only check for critical 
        " errors)
        function! SyntasticErrorMode()
            let g:syntastic_php_checkers = g:syntastic_php_error_checkers
            let g:syntastic_scss_checkers = g:syntastic_scss_error_checkers
            let g:syntastic_aggregate_errors = 0
        endfunction
        command! SyntasticErrorMode call SyntasticErrorMode()
        nmap <Leader>se :SyntasticErrorMode<CR>
    " }

    " Tabularize {
        nmap <Leader>a& :Tabularize /&<CR>
        vmap <Leader>a& :Tabularize /&<CR>
        nmap <Leader>a= :Tabularize /=<CR>
        vmap <Leader>a= :Tabularize /=<CR>
        nmap <Leader>a: :Tabularize /:<CR>
        vmap <Leader>a: :Tabularize /:<CR>
        nmap <Leader>a:: :Tabularize /:\zs<CR>
        vmap <Leader>a:: :Tabularize /:\zs<CR>
        nmap <Leader>a, :Tabularize /,<CR>
        vmap <Leader>a, :Tabularize /,<CR>
        nmap <Leader>a,, :Tabularize /,\zs /l0<CR>
        vmap <Leader>a,, :Tabularize /,\zs /l0<CR>
        nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        nmap <Leader>a> :Tabularize /=><CR>
        vmap <Leader>a> :Tabularize /=><CR>
        nmap <Leader>a@ :Tabularize /@\S\{-}\zs /l0<CR>
        vmap <Leader>a@ :Tabularize /@\S\{-}\zs /l0<CR>
        nmap <Leader>a@p :Tabularize /@\S\{-} \S\{-}\zs \S\{-} /l0<CR>
        vmap <Leader>a@p :Tabularize /@\S\{-} \S\{-}\zs \S\{-} /l0<CR>
        nmap <Leader>ap :Tabularize /,\zs /l0r0<CR>
        vmap <Leader>ap :s/,\([^ ]\)/, \1/g<CR>:Tabularize /,\zs /l0r0<CR>
    " }

    " Ultisnips {
        let g:UltiSnipsSnippetDirectories=["UltiSnips", "default-snippets", "custom-snippets"]
        let g:UltiSnipsExpandTrigger="<C-CR>"
        let g:UltiSnipsJumpForwardTrigger="<C-CR>"
        let g:UltiSnipsJumpBackwardTrigger="<S-C-CR>"
        let g:UltiSnipsSnippetsDir=$editor_root . "/custom-snippets"
        let g:UltiSnipsEditSplit='vertical'
        let g:UltiSnipsUsePythonVersion=2
    " }

    " UndoTree {
        nnoremap <Leader>u :UndotreeToggle<CR>
        nmap cou :UndotreeToggle<CR>
        " If undotree is opened, it is likely one wants to interact with it.
        let g:undotree_SetFocusWhenToggle=1
    " }

    " Wordpress.vim {
        " This screws up indenting on some lines... highly annoying
        let g:wordpress_vim_php_syntax_highlight=0
        let g:wordpress_vim_dont_generate_tags=1
    " }

    " VCS (subversion) {
        let g:netrw_mousemaps=0
        let g:VCSCommandMapPrefix = "<Leader>v"
        nmap ,vb ,vn
        nmap ,vB ,vN
    " }

    " YCM {
        " Disable until I have more ram (7mb tags file causes 175mb ram
        " usage!)
        "let g:ycm_collect_identifiers_from_tags_files=1

        " Disable auto omni completion for these filetypes, trigger manually
        " instead
        let g:ycm_filetype_specific_completion_to_disable = { 'vim':1, 'txt':1, 'javascript':1, 'php':1 }
        let g:ycm_complete_in_comments = 1
        let g:ycm_complete_in_strings = 1
        let g:ycm_collect_identifiers_from_comments_and_strings = 1
        " Get php main functions/keywords from syntax file
        let g:ycm_seed_identifiers_with_syntax = 1
        " }

" }

" GUI Settings {{{

    " GVIM- (here instead of .gvimrc)
    if has('gui_running')
        set guioptions-=T           " Remove the toolbar
        set guioptions-=m           " Remove the menu
        "set lines=40                " 40 lines of text instead of 24
        set guifont=Source\ Code\ Pro\ Medium\ 12,Andale\ Mono\ Regular\ 16,Menlo\ Regular\ 15,Consolas\ Regular\ 16,Courier\ New\ Regular\ 18
        set linespace=-1 " Font rendering isn't as nice as windows at 8, but we can remove 2px from each line to fit more lines on the screen
        if has("gui_mac")
            set guifont=Source\ Code\ Pro:h8,Andale\ Mono\ Regular:h16,Menlo\ Regular:h15,Consolas\ Regular:h16,Courier\ New\ Regular:h18
        elseif has("gui_win32")
            set guifont=Source\ Code\ Pro:h8,Andale_Mono:h10,Menlo:h10,Consolas:h10,Courier_New:h10
            au GUIEnter * simalt ~x
        endif
        nnoremap <C-Up> :silent! let &guifont = substitute(
         \ &guifont,
         \ ':h\zs\d\+',
         \ '\=eval(submatch(0)+1)',
         \ 'g')<CR>
        nnoremap <C-Down> :silent! let &guifont = substitute(
         \ &guifont,
         \ ':h\zs\d\+',
         \ '\=eval(submatch(0)-1)',
         \ 'g')<CR>
        " Maximize
    else
        set t_Co=256            " Enable 256 colors to stop the CSApprox warning and make xterm vim shine
        if &term == 'xterm' || &term == 'screen'
        endif
        "set term=builtin_ansi       " Make arrow and other keys work
    endif

    let g:solarized_degrade=0
    let g:solarized_bold=0 " Causes odd characters sometimes in term
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
    let g:solarized_termtrans=0    "default value is 0
    let g:solarized_termcolors=256    "default value is 16
    if has('nvim')
        let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    syntax enable
    set background=dark
    colorscheme solarized

    " Indent_guides {
        if !has('gui_running')
            let g:no_indent_guides_autocolor = 1
            let g:indent_guides_auto_colors = 0
        endif
        if !exists('g:no_indent_guides_autocolor')
            let g:indent_guides_auto_colors = 1
        else
            " @TODO check bg = light or dark here and alter accoringly
            " For some colorschemes, autocolor will not work (eg: 'desert', 'ir_black')
            autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=235
            autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=236
        endif
        let g:indent_guides_start_level = 2
        let g:indent_guides_guide_size = 1
        let g:indent_guides_enable_on_vim_startup = 1
    " }

    " Custom syntax {{{
        "php {{{
            " Section jumping: [[ and ]] provided by Antony Scriven <adscriven at gmail dot com>
            let s:function = '\(abstract\s\+\|final\s\+\|private\s\+\|protected\s\+\|public\s\+\|static\s\+\)*function'
            let s:class = '\(abstract\s\+\|final\s\+\)*class'
            let s:interface = 'interface'
            let s:section = '\(.*\%#\)\@!\_^\s*\zs\('.s:function.'\|'.s:class.'\|'.s:interface.'\)'
            "These two lines throw a 'range not allowed/expected' type error
            "au FileType php exe 'vno <buffer> <silent> [[ ?' . escape(s:section, '|') . '?<CR>:nohls<CR>'
            "au FileType php exe 'vno <buffer> <silent> ]] /' . escape(s:section, '|') . '/<CR>:nohls<CR>'
        " }}}

    " }}}

" }}}

" Functions {
    function! Ptab(tabdir, tabname)
        execute "tabnew"
        execute "Tcd ".a:tabdir
        execute "TName ".a:tabname
    endfunction
    command! -complete=dir -nargs=+ Ptab call Ptab(<f-args>)

    function! FileFix()
        execute "set ff=unix"
        execute "%s///ge"
        execute "retab"
    endfunction
    command! FileFix call FileFix()
    nmap <Leader>FF :call FileFix()<CR>

    function! Popen(tabdir, tabname)
        execute "Tcd ".a:tabdir
        execute "TName ".a:tabname
    endfunction
    command! -complete=dir -nargs=+ Popen call Popen(<f-args>)

    function! s:DiffWithSaved()
      let filetype=&ft
      diffthis
      vnew | r # | normal! 1Gdd
      diffthis
      exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
    endfunction
    com! DiffSaved call s:DiffWithSaved()

    " UnBundle {
    function! UnBundle(arg, ...)
      let bundle = vundle#config#init_bundle(a:arg, a:000)
      call filter(g:bundles, 'v:val["name_spec"] != "' . a:arg . '"')
    endfunction

    com! -nargs=+         UnBundle
    \ call UnBundle(<args>)
    " }

    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " To specify a different directory in which to place the vimbackup,
        " vimviews, vimundo, and vimswap files/directories, add the following to
        " your .vimrc.before.local file:
        "   let g:consolidated_directory = <full path to desired directory>
        "   eg: let g:consolidated_directory = $HOME . '/.vim/'
        if exists('g:consolidated_directory')
            let common_dir = g:consolidated_directory . prefix
        else
            let common_dir = parent . '/.' . prefix
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

    " Swap directory (Don't know what all the above does... maybe later!)
    set directory=$HOME/.vimswap//
    set backupdir=$HOME/.vimbackup//
    " Adding // to the backupdir doesn't work,.. manually add the path to the
    " extension instead (backupex)
    "au BufWritePre * let &bex = '.vimbackup'
    " Virtualbox doesn't support names longer than 144 characters :(
    if !has('unix')
        au BufWritePre * let &bex = '-' . fnamemodify(fnamemodify(fnamemodify(resolve(expand("%:p")), ":gs?\/?%?"), ":gs?\\?%?"), ":gs?:?%?")
    endif
    "echo '-' . fnamemodify(fnamemodify(fnamemodify(resolve(expand("%:p")), ":gs?\/?%?"), ":gs?\\?%?"), ":gs?:?%?"). '.vimbackup'

    " Initialize NERDTree as needed {
    function! NERDTreeInitAsNeeded()
        redir => bufoutput
        buffers!
        redir END
        let idx = stridx(bufoutput, "NERD_tree")
        if idx > -1
            NERDTreeMirror
            NERDTreeFind
            wincmd l
        endif
    endfunction
    " }

    " Strip whitespace {
    function! StripTrailingWhitespace()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " do the business:
        " strip whitespace: (but leave a single blank space)
        "%s/ \s\+$/ /e
        " strip all trailing whitespace
        %s/\s\+$//e
        " strip space from lines containing only a space
        %s/^ $//e
        " strip trailing empty lines from eof (keep these now!)
        "silent! %s#\($\n\s*\)\+\%$##
        " strip ^M
        silent! %s///g
        " clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    " }

    " Shell command {
    function! s:RunShellCommand(cmdline)
        botright new

        setlocal buftype=nofile
        setlocal bufhidden=delete
        setlocal nobuflisted
        setlocal noswapfile
        setlocal nowrap
        setlocal filetype=shell
        setlocal syntax=shell

        call setline(1, a:cmdline)
        call setline(2, substitute(a:cmdline, '.', '=', 'g'))
        execute 'silent $read !' . escape(a:cmdline, '%#')
        setlocal nomodifiable
        1
    endfunction

    command! -complete=file -nargs=+ Shell call s:RunShellCommand(<q-args>)
        " e.g. Grep current file for <search_term>: Shell grep -Hn <search_term> %
    " }

    " Swap windows {
    function! MarkWindowSwap()
        let g:markedWinNum = winnr()
    endfunction

    function! DoWindowSwap()
        "Mark destination
        let curNum = winnr()
        let curBuf = bufnr( "%" )
        exe g:markedWinNum . "wincmd w"
        "Switch to source and shuffle dest->source
        let markedBuf = bufnr( "%" )
        "Hide and open so that we aren't prompted and keep history
        exe 'hide buf' curBuf
        "Switch to dest and shuffle source->dest
        exe curNum . "wincmd w"
        "Hide and open so that we aren't prompted and keep history
        exe 'hide buf' markedBuf
    endfunction

    nmap <silent> <leader>mw :call MarkWindowSwap()<CR>
    nmap <silent> <leader>pw :call DoWindowSwap()<CR>
        "eg : ,mw to mark window ,pw to swap with marked window
    " }

    " Fix grep (vimgrep too slooooow!)
    " -H, --with-filename
    " -n, --line-number
    " -s, --no-messages (suppress error msgs)
    "set grepprg=grep\ -Hns
    " XML formatter
    function! DoFormatXML() range
        " Save the file type
        let l:origft = &ft

        " Clean the file type
        set ft=

        " Add fake initial tag (so we can process multiple top-level elements)
        exe ":let l:beforeFirstLine=" . a:firstline . "-1"
        if l:beforeFirstLine < 0
            let l:beforeFirstLine=0
        endif
        exe a:lastline . "put ='</PrettyXML>'"
        exe l:beforeFirstLine . "put ='<PrettyXML>'"
        exe ":let l:newLastLine=" . a:lastline . "+2"
        if l:newLastLine > line('$')
            let l:newLastLine=line('$')
        endif

        " Remove XML header
        exe ":" . a:firstline . "," . a:lastline . "s/<\?xml\\_.*\?>\\_s*//e"

        " Recalculate last line of the edited code
        let l:newLastLine=search('</PrettyXML>')

        " Execute external formatter
        exe ":silent " . a:firstline . "," . l:newLastLine . "!xmllint --noblanks --format --recover -"

        " Recalculate first and last lines of the edited code
        let l:newFirstLine=search('<PrettyXML>')
        let l:newLastLine=search('</PrettyXML>')

        " Get inner range
        let l:innerFirstLine=l:newFirstLine+1
        let l:innerLastLine=l:newLastLine-1

        " Remove extra unnecessary indentation
        exe ":silent " . l:innerFirstLine . "," . l:innerLastLine "s/^  //e"
        " Remove fake tag
        exe l:newLastLine . "d"
        exe l:newFirstLine . "d"

        " Put the cursor at the first line of the edited code
        exe ":" . l:newFirstLine

        " Restore the file type
        exe "set ft=" . l:origft
    endfunction
    command! -range=% FormatXML <line1>,<line2>call DoFormatXML()
    nmap <silent> <leader>fx :%FormatXML<CR>
    vmap <silent> <leader>fx :FormatXML<CR>


    function! DoFormatHTML() range
        " Save the file type
        let l:origft = &ft

        " Clean the file type
        set ft=

        " Execute external formatter
        exe ":silent '<,'>!xmllint --html --noblanks --format --recover --nowrap -"

        " Restore the file type
        exe "set ft=" . l:origft
    endfunction
    command! -range FormatHTML <line1>,<line2>call DoFormatHTML()
    nmap <silent> <leader>fh :%FormatHTML<CR>
    vmap <silent> <leader>fh :FormatHTML<CR>

    function! DoFormatJSON() range
        " Save the file type
        let l:origft = &ft

        " Clean the file type
        set ft=

        " Execute external formatter
        exe ":silent %!python -m json.tool"

        " Restore the file type
        exe "set ft=" . l:origft
    endfunction
    command! -range=% FormatJSON <line1>,<line2>call DoFormatJSON()
    nmap <silent> <leader>fj :%FormatJSON<CR>
    vmap <silent> <leader>fj :FormatJSON<CR>

    function! DoFormatSASS() range
        let l:origft = &ft
        set ft=
        exe ":silent '<,'>!sass-convert --stdin --from=scss --to=scss --indent=4"
        exe "set ft=" . l:origft
    endfunction
    command! -range=% FormatSASS <line1>,<line2>call DoFormatSASS()
    nmap <silent> <leader>fs :%FormatSASS<CR>
    vmap <silent> <leader>fs :FormatSASS<CR>



    let g:FindIgnore = ['.swp', '.pyc', '.class', '.git', '.svn']
    " Find file in current directory and edit it.
    function! Find(...)
        if a:0==2
            let path=a:1
            let query=a:2
        else
            let path="./"
            let query=a:1
        endif

        if !exists("g:FindIgnore")
            let ignore = ""
        else
            let ignore = " | egrep -v '".join(g:FindIgnore, "|")."'"
        endif

        echo "find ".path." -type f -regex ".query.ignore
        let l:list=system("find ".path." -type f -regex ".query.ignore)
        let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))

        if l:num < 1
            echo "'".query."' not found"
            return
        endif

        if l:num == 1
            exe "open " . substitute(l:list, "\n", "", "g")
        else
            let tmpfile = tempname()
            exe "redir! > " . tmpfile
            silent echon l:list
            redir END
            let old_efm = &efm
            set efm=%f

            if exists(":cgetfile")
                execute "silent! cgetfile " . tmpfile
            else
                execute "silent! cfile " . tmpfile
            endif

            let &efm = old_efm

            " Open the quickfix window below the current window
            botright copen

            call delete(tmpfile)
        endif
    endfunction
    command! -nargs=* Find :call Find(<f-args>)
" }

" { Seemless editing of gpg files
    " Don't save backups of *.gpg files
    set backupskip+=*.gpg
    " To avoid that parts of the file is saved to .viminfo when yanking or
    " deleting, empty the 'viminfo' option.
    set viminfo=

    augroup encrypted
      au!
      " First make sure nothing is written to ~/.viminfo while editing
      " an encrypted file.
      autocmd BufReadPre,FileReadPre *.gpg set viminfo=
      " Disable swap files, and set binary file format before reading the file
      autocmd BufReadPre,FileReadPre *.gpg
        \ setlocal noswapfile bin
      " Decrypt the contents after reading the file, reset binary file format
      " and run any BufReadPost autocmds matching the file name without the .gpg
      " extension
      autocmd BufReadPost,FileReadPost *.gpg
        \ execute "'[,']!gpg -d -q --no-use-agent 2>/dev/null" |
        \ setlocal nobin |
        \ execute "doautocmd BufReadPost " . expand("%:r")
      " Set binary file format and encrypt the contents before writing the file
      autocmd BufWritePre,FileWritePre *.gpg
        \ setlocal bin |
        \ '[,']!gpg -c -q --no-use-agent 2>/dev/null
      " After writing the file, do an :undo to revert the encryption in the
      " buffer, and reset binary file format
      autocmd BufWritePost,FileWritePost *.gpg
        \ silent u |
        \ setlocal nobin
    augroup END
" }
