""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 256 Color stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set t_Co=256
" set t_AB=^[[48;5;%dm
" set t_AF=^[[38;5;%dm

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Editor Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

syntax enable
syntax sync fromstart
set nocompatible
set encoding=utf-8
set laststatus=2
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set scrolloff=5

" set statusline=%F%m%r%h%w\ [Format=%{&ff}]\ [Type=%Y]\ [ASCII=\%03.3b]\ [Hex=\%02.2B]\ [Pos=%04l,%04v][%p%%]\ [Len=%L]\ [Buf=%n]
set history=1000
set nowrap
set nowrap sidescroll=8
set sidescrolloff=8
set showmatch
set scrollopt=hor,ver,jump
set ttyfast
set backspace=indent,eol,start
set modeline
set colorcolumn=80,132
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<

" Search behaviour

set incsearch
set hlsearch
set ignorecase
set smartcase

" Fix annoyances in smart indent

set autoindent                              "Retain indentation on next line
set smartindent                             "Turn on autoindenting of blocks

inoremap # X<C-H>#|                         "And no magic outdent for comments
nnoremap <silent> >> :call ShiftLine()<CR>| "And no shift magic on comments

function! ShiftLine()
    set nosmartindent
    normal! >>
    set smartindent
endfunction

set dictionary+=/usr/share/dict/words
set thesaurus+=/home/gold/.vim/mthesaur.txt

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem,*.pyc,*.pyo

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

set mouse=a

" Undo stuff
if has('persistent_undo')
    " Save all undo files in a single location (less messy, more risky)...
    set undodir=$HOME/tmp/.VIM_UNDO_FILES

    " Save a lot of back-history...
    set undolevels=5000

    " Actually switch on persistent undo
    set undofile
endif

" Visual mode betterizing
" Square up visual selections
set virtualedit=block

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Filetype stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

filetype plugin indent on
filetype plugin on

au BufRead,BufNewFile *.txt setlocal ft=txt

" Forces .vimrc to reload when it is written. A bit goofy in my environmnent
"augroup VimReload
"    autocmd!
"    autocmd BufWritePost $MYVIMRC source $MYVIMRC
"augroup END

"====[ Goto last location in non-empty files ]=======

autocmd BufReadPost *  if line("'\"") > 1 && line("'\"") <= line("$")
                   \|     exe "normal! g`\""
                   \|  endif

au BufRead,BufNewFile *.lt setlocal ft=make

let perl_fold=1 
let perl_fold_blocks = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Keyboard mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Make jumping around windows easier
nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l
imap <C-H> <C-W>h
imap <C-J> <C-W>j
imap <C-K> <C-W>k
imap <C-L> <C-W>l

" Page down with space
nnoremap <SPACE> <PAGEDOWN>
nnoremap <C-SPACE> <PAGEUP>

" Instant access to .vimrc
nmap <silent> ;v :next $MYVIMRC<CR>

nnoremap <F9> :set nonumber!<CR>:set foldcolumn=0<CR>

" Display/hide whitespace characters
map <unique> <leader>c    :set list<cr>
map <unique> <leader>C    :set list!<cr>

" Turn off arrow keys
noremap  <Up> ""
" noremap! <Up> <Esc>
noremap  <Down> ""
" noremap! <Down> <Esc>
noremap  <Left> ""
" noremap! <Left> <Esc>
noremap  <Right> ""
" noremap! <Right> <Esc>

" use :w!! to write to a file using sudo if you forgot to 'sudo vim file'
" (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" Toggle paste mode
"nmap <silent> <F4> :set invpaste<CR>:set paste?<CR>
"imap <silent> <F4> <ESC>:set invpaste<CR>:set paste?<CR>

" format the entire file
nmap <leader>fef ggVG=

" upper/lower word
nmap <leader>u mQviwU`Q
nmap <leader>l mQviwu`Q

" upper/lower first char of word
nmap <leader>U mQgewvU`Q
nmap <leader>L mQgewvu`Q

" cd to the directory containing the file in the buffer
" nmap <silent> <leader>cd :lcd %:h<CR>

" Create the directory containing the file in the buffer
" nmap <silent> <leader>md :!mkdir -p %:p:h<CR>

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Swap two words
nmap <silent> gw :s/\(\%#\w\+\)\(\_W\+\)\(\w\+\)/\3\2\1/<CR>`'

" Underline the current line with '='
nmap <silent> <leader>ul :t.\|s/./=/g\|:nohls<cr>

" set text wrapping toggles
nmap <silent> <leader>tw :set invwrap<CR>:set wrap?<CR>

" find merge conflict markers
nmap <silent> <leader>fc <ESC>/\v^[<=>]{7}( .*\|$)<CR>

" Map the arrow keys to be based on display lines, not physical lines
" map <Down> gj
" map <Up> gk

" Toggle hlsearch with <leader>hs
nmap <leader>hs :set hlsearch! hlsearch?<CR>

" Adjust viewports to the same size
map <Leader>= <C-w>=

if has("gui_macvim") && has("gui_running")
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <D-]> >gv
  vmap <D-[> <gv

  nmap <D-]> >>
  nmap <D-[> <<

  omap <D-]> >>
  omap <D-[> <<

  imap <D-]> <Esc>>>i
  imap <D-[> <Esc><<i

  " Bubble single lines
  nmap <D-Up> [e
  nmap <D-Down> ]e
  nmap <D-k> [e
  nmap <D-j> ]e

  " Bubble multiple lines
  vmap <D-Up> [egv
  vmap <D-Down> ]egv
  vmap <D-k> [egv
  vmap <D-j> ]egv

  " Map Command-# to switch tabs
  map  <D-0> 0gt
  imap <D-0> <Esc>0gt
  map  <D-1> 1gt
  imap <D-1> <Esc>1gt
  map  <D-2> 2gt
  imap <D-2> <Esc>2gt
  map  <D-3> 3gt
  imap <D-3> <Esc>3gt
  map  <D-4> 4gt
  imap <D-4> <Esc>4gt
  map  <D-5> 5gt
  imap <D-5> <Esc>5gt
  map  <D-6> 6gt
  imap <D-6> <Esc>6gt
  map  <D-7> 7gt
  imap <D-7> <Esc>7gt
  map  <D-8> 8gt
  imap <D-8> <Esc>8gt
  map  <D-9> 9gt
  imap <D-9> <Esc>9gt
else
  " Map command-[ and command-] to indenting or outdenting
  " while keeping the original selection in visual mode
  vmap <A-]> >gv
  vmap <A-[> <gv

  nmap <A-]> >>
  nmap <A-[> <<

  omap <A-]> >>
  omap <A-[> <<

  imap <A-]> <Esc>>>i
  imap <A-[> <Esc><<i
 
  " Bubble single lines
  nmap <C-Up> [e
  nmap <C-Down> ]e
  nmap <C-k> [e
  nmap <C-j> ]e

  " Bubble multiple lines
  vmap <C-Up> [egv
  vmap <C-Down> ]egv
  vmap <C-k> [egv
  vmap <C-j> ]egv

  " Make shift-insert work like in Xterm
  map <S-Insert> <MiddleMouse>
  map! <S-Insert> <MiddleMouse>

  " Map Control-# to switch tabs
  map  <C-0> 0gt
  imap <C-0> <Esc>0gt
  map  <C-1> 1gt
  imap <C-1> <Esc>1gt
  map  <C-2> 2gt
  imap <C-2> <Esc>2gt
  map  <C-3> 3gt
  imap <C-3> <Esc>3gt
  map  <C-4> 4gt
  imap <C-4> <Esc>4gt
  map  <C-5> 5gt
  imap <C-5> <Esc>5gt
  map  <C-6> 6gt
  imap <C-6> <Esc>6gt
  map  <C-7> 7gt
  imap <C-7> <Esc>7gt
  map  <C-8> 8gt
  imap <C-8> <Esc>8gt
  map  <C-9> 9gt
  imap <C-9> <Esc>9gt
endif

""
"" Command-Line Mappings
""

" Insert the current directory into a command-line path
cmap <C-P> <C-R>=expand("%:p:h") . "/"<CR>

nmap <silent> <BS> :nohlsearch

" Make BS/DEL work as expected in visual modes - delete text
vmap <BS> x

"=====[ Search folding ]=====================

" Toggle on and off...
nmap <silent> <expr>  zz  FS_ToggleFoldAroundSearch({'context':1})

" Show only Perl sub defns...
nmap <silent> <expr>  zp  FS_FoldAroundTarget('^\s*sub\s\+\w\+',{'context':1})

" Show only Perl sub defns and comments...
nmap <silent> <expr>  za  FS_FoldAroundTarget('^\s*\%(sub\s.*\\|#.*\)',{'context':0, 'folds':'invisible'})

" Show only C #includes...
nmap <silent> <expr>  zu  FS_FoldAroundTarget('^\s*use\s\+\S.*;',{'context':1})


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Functions
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Strip trailing whitespace
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    "let @/=_s
    call cursor(l, c)
endfunction
" autocmd BufWritePre * :call <SID>StripTrailingWhitespaces()

" Toggle opening/closing the location list (syntastic errors)

let g:location_list_is_open = 0

function! LocationListToggle()
    if g:location_list_is_open
        lclose
        let g:location_list_is_open = 0
        execute g:location_list_return_to_window . "wincmd w"
    else
        let g:location_list_return_to_window = winnr()
        lopen
        let g:location_list_is_open = 1
    endif
endfunction

nnoremap <F6> :call LocationListToggle()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Rope
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

source /home/gold/.vim/rope/rope.vim

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" INFECT!
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call pathogen#infect() 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin keyboard mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <F3> :GundoToggle<CR>
map <F5> :TagbarToggle<CR>
map <F4> :NERDTreeToggle<CR>
map <S-F4> :Project<CR>
map <C-F6> :new +ConqueTerm\ bash<CR>

" Mapping for more intuitive window resizing
noremap <silent> <C-Up> :ObviousResizeUp<CR> 
noremap <silent> <C-Down> :ObviousResizeDown<CR> 
noremap <silent> <C-Left> :ObviousResizeLeft<CR> 
noremap <silent> <C-Right> :ObviousResizeRight<CR> 
 
" Buffer explorer
nmap <silent> <unique> <F7> :BufExplorer<CR>
nmap <silent> <unique> <C-F7> :BufExplorerHorizontalSplit<CR>
nmap <silent> <unique> <S-F7> :BufExplorerVerticalSplit<CR>

" Snipmate

ino <silent> <f2> <c-r>=TriggerSnippet()<cr>
snor <silent> <f2> <esc>i<right><c-r>=TriggerSnippet()<cr>

" Syntastic

" map <silent> <F6> :lw<CR>
" map <silent> <S-F6> :lcl<CR>

" Project

map <S-F7> <Plug>ToggleProject

" Scroll Colors

map <silent> <S-F6> :NEXTCOLOR<CR> 
map <silent> <S-F5> :PREVCOLOR<CR> 


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Mini Buffer Explorer

"let g:miniBufExplMapWindowNavVim = 1 
"let g:miniBufExplMapWindowNavArrows = 0 
"let g:miniBufExplMapCTabSwitchBufs = 1 
"let g:miniBufExplModSelTarget = 1 
  
" Source Explorer (srcexpl.vim)

" // The switch of the Source Explorer 
nmap <F8> :SrcExplToggle<CR> 

" // Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 8 

" // Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 100 

" // Set "Enter" key to jump into the exact definition context 
" let g:SrcExpl_jumpKey = "<ENTER>" 

" // Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<SPACE>" 

" // In order to Avoid conflicts, the Source Explorer should know what plugins 
" // are using buffers. And you need add their bufname into the list below 
" // according to the command ":buffers!" 
let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
        \ "_NERD_tree_", 
        \ "Source_Explorer" 
    \ ] 

" // Enable/Disable the local definition searching, and note that this is not 
" // guaranteed to work, the Source Explorer doesn't check the syntax for now. 
" // It only searches for a match with the keyword according to command 'gd' 
let g:SrcExpl_searchLocalDef = 1 

" // Do not let the Source Explorer update the tags file when opening 
let g:SrcExpl_isUpdateTags = 0 

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to 
" //  create/update a tags file 
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 

" // Set "<F12>" key for updating the tags file artificially 
let g:SrcExpl_updateTagsKey = "<S-F8>" 


" Powerline

let g:Powerline_symbols = 'fancy' 

call Pl#Theme#InsertSegment('ws_marker', 'after', 'lineinfo')

" NERDTree

let NERDTreeIgnore = ['\.pyc$', '\~$', '\.swp$', '\.pyo$', '\.class$', '\.o$', '\.out$', '\.obj$', '\.rbc$', '\.rbo$', '\.zip$', '\.gz$', '\.bz$', '\.rar$', '^core$', '\.so\.[0-9]*$', '\.jpg$', '\.png$', '\.gif$', '\.mp[34]$']

" MRU
let MRU_Max_Entries = 1000 

let g:syntastic_phpcs_conf = "--standard=/home/gold/dev/dg/phpcs/CodeSniffer/Standards/dg/ruleset.xml"
let g:syntastic_python_checker = 'pylint'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin Color Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" OTHER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Post pathogen key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Make sure ^HJKL work

nmap <C-H> <C-W>h
nmap <C-J> <C-W>j
nmap <C-K> <C-W>k
nmap <C-L> <C-W>l

" Tasks
inoremap <silent> <buffer> <S-F8> <ESC>:call Toggle_task_status()<CR>i
noremap <silent> <buffer> <S-F8> :call Toggle_task_status()<CR>

" Search/Filtering

noremap <C-F8> :call FilteringNew().addToParameter('alt', @/).run()<CR>

noremap <C-F9> :MRU<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Post Pathogen file types
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Inform7
au BufNewFile,BufRead *.ni      setf inform7 

" Pig
augroup filetypedetect 
    au BufNewFile,BufRead *.pig set filetype=pig syntax=pig 
augroup END 

" Tasks
autocmd BufNewFile,BufRead todo.txt,*.task,*.tasks  setfiletype task

" Avro IDL files
au BufRead,BufNewFile *.avdl,*.avsc setlocal filetype=avro-idl

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Final settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

colorscheme freya

" Color themes are also controlled by pathogen, so any additional tweaks
" should be done after pathogen infects.

highlight Folded ctermbg=DarkBlue ctermfg=Yellow
" colorscheme watermark
hi MatchParen ctermfg=blue ctermbg=black
highlight ColorColumn ctermbg=darkblue guibg=gray10

set background=dark

au BufRead,BufWrite *.hive set filetype=hive
au BufRead,BufWrite *.hql set filetype=hive

