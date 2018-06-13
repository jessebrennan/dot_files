"########################################################################
"# vundle stuff
"########################################################################

" stop annoying bells
set noerrorbells visualbell t_vb=

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
"set rtp+=$HOME/.vim/bundle/vundle
"let path='$HOME/.vim/bundle'
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc('$HOME/.vim/bundle')
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

"tab stuff
Plugin 'ervandew/supertab'          " tab completion
Plugin 'Shougo/neocomplete.vim'     " smart completion
Plugin 'SirVer/ultisnips'           " for code snippets
Plugin 'honza/vim-snippets'         " the actual snippets

"tag stuff
Plugin 'taglist.vim'
Plugin 'majutsushi/tagbar'
"Plugin 'xolox/vim-easytags'
"Plugin 'xolox/vim-shell'            " makes ^ better
"Plugin 'xolox/vim-misc'             " needed for easy tags

"haskell plugins
Plugin 'eagletmt/ghcmod-vim'
Plugin 'eagletmt/neco-ghc'          " haskell tab completion
Plugin 'Shougo/vimproc.vim'
Plugin 'itchyny/vim-haskell-indent'

"Idris
Plugin 'idris-hackers/idris-vim'

" w/e
Plugin 'pthrasher/conqueterm-vim'   " terminal in vim
Plugin 'sjl/gundo.vim'              " undo tree
Plugin 'moll/vim-bbye'              " quits just buffer
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'        " file tree
Plugin 'flazz/vim-colorschemes'
Plugin 'ternjs/tern_for_vim'        " better js recognition
Plugin 'godlygeek/tabular'
Plugin 'ctrlpvim/ctrlp.vim'             " fuzzy file finder
Plugin 'vim-syntastic/syntastic'    " syntax checking???:Plugin

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" see :h vundle for more details or wiki for FAQ

"########################################################################
"# random shit
"########################################################################

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=1024	" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
if &t_Co > 2 || has("gui_running")
  syntax on
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 72 characters.
  "autocmd FileType text setlocal textwidth=72

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  "Automatically cd into the directory that the file is in
  autocmd BufEnter * execute "chdir ".escape(expand("%:p:h"), ' ')

  "Remove any trailing whitespace that is in the file
  autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

  " stop annoying bells
  set noerrorbells visualbell t_vb=
  autocmd GUIEnter * set visualbell t_vb=

  augroup END
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"########################################################################
"# tabs and stuff
"########################################################################

" tabs and stuff
set expandtab
set smarttab

set shiftwidth=3
set softtabstop=3
set shiftround

set autoindent
set copyindent

set ignorecase
set smartcase

set number " displays the line number
set numberwidth=3

set incsearch
highlight lineNr cterm=NONE ctermfg=DarkGrey
"set nohlsearch

set scrolloff=3               " keep at least 3 lines above/below

"set wrap      "wrap lines
"set linebreak   "wrap lines at convenient points
set nolist
"set textwidth=72

" autocomplete options
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set completeopt=menuone,menu,longest

" make A-] open def in vertical split
map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" togle Taglist
command Tag TlistToggle
command Bash ConqueTerm bash
command Sbash ConqueTermSplit bash
command Vsbash ConqueTermVSplit bash
" make jj do escape
inoremap jj <ESC>

" allow changing buffers without saving
set hidden

"iterm2 with osx cursor settings
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"########################################################################
"# plugin stuff
"########################################################################

" for fuzzy search of tags
let g:ctrlp_extensions = ['tag']

" for tabularize
let g:haskell_tabular = 1

" haskell highlighting settings
let hs_highlight_boolean = 1
let hs_highlight_types = 1
let hs_highlight_more_types = 1

"tagbar
let g:tagbar_left = 1
let g:tagbar_width = 30
let g:tagbar_compact = 1

" syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_mode_map = {"mode": "passive"}

" ghc with supertab
let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

"look at customize wiki for how to run these async on write
"https://github.com/eagletmt/ghcmod-vim/wiki/Customize

"########################################################################
"# key remapping
"########################################################################

" make tab go to last used buffer in normal mode
nmap <Tab> :b#<CR>

" make leader commands"
let mapleader=" "
let maplocalleader="\\"

" remap localleader
map <leader>l <LocalLeader>

" make it easy to paste from default clipboard
map <leader>e :Explore<CR>

map <leader>p "+p
map <leader>P "+P

map <Leader>n :NERDTreeToggle<CR>
map <Leader>t :TagbarToggle<CR>
map <Leader>u :GundoToggle<CR>

map <Leader>b :ConqueTerm bash<CR>
map <Leader>sb :ConqueTermSplit bash<CR>
map <Leader>vsb :ConqueTermVSplit bash<CR>

map <Leader>ff :CtrlP()<CR>
map <Leader>fa :CtrlPMixed<CR>
" maybe we want to add CtrlpbufTag(All)
map <Leader>ft :CtrlPTag<CR>

map <Leader>q :Bdelete<CR>
map <Leader>/ :let @/=""<CR>
map <Leader>T :!ctags -R<CR>
map <Leader>vv :e ~\.vimrc<CR>
map <Leader>sv :so ~\.vimrc<CR>
" check syntax
map <Leader>ss :SyntasticToggleMode<CR>
map <Leader>ht :GhcModType<CR>
map <Leader>htc :GhcModTypeClear<CR>
map <Leader>hl :GhcModLint<CR>

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

"########################################################################
"# gui stuff
"########################################################################

if has('gui_running')
   " gvim specific settings
   set background=dark
   set gfn=Menlo\ Regular:h13
   colorscheme solarized
endif

" tags bullshit
set tags+=tags;$HOME
