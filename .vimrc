" Use Vim settings, rather than Vi settings (much better!).  This must be
" first, because it changes other options as a side effect.
"
set nocompatible

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Pathogen
execute pathogen#infect()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start 
set history=50		" keep 50 lines of command line history set ruler           " show the cursor position all the time
set showcmd         " display incomplete commands
set incsearch		" do incremental searching
set number          " line numbers!
set expandtab       " use spaces instead of tabs
set copyindent      " copy indentation structure
set preserveindent  " preserve indentation structure when opening new lines
set softtabstop=0
set shiftwidth=4    " how many spaces for > indentation
set tabstop=4       " tab width 

syntax on
colorscheme tabula
set autoindent

set backup
set backupdir=~/backup/
set scrolloff=8

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " NERDTree
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Pymode (does this stuff even work?)
let g:pymode_lint_options_mccabe = { 'complexity': 18 }
let g:pymode_rope_lookup_project = 0

" Treat pipes like quotes or parens for those handy 'i(n)' and 'a(round)' movements
" (handy for ruby)
nnoremap di\| T\|d,
nnoremap da\| F\|d,
nnoremap ci\| T\|c,
nnoremap ca\| F\|c,
nnoremap yi\| T\|y,
nnoremap ya\| F\|y,
nnoremap vi\| T\|v,
nnoremap va\| F\|v,

" XML
let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax

set hidden

" Rainbow parentheses
let g:rainbow_active = 1

" Airline
let g:airline_theme='tabula'
let g:airline_powerline_fonts = 1
set laststatus=2

let g:indent_guides_auto_colors = 0


noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

cnoremap <Up> <NOP>
cnoremap <Down> <NOP>
cnoremap <Left> <NOP>
cnoremap <Right> <NOP>

cabbr <expr> %% expand('$:p:h')

" Split options
set splitbelow
set splitright

au Filetype yaml setlocal sw=1 ts=1 sts=1

echom ">^.^<"

inoremap <c-u> <esc>mtvbU`ta
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

iabbrev @@ karplusstrong@gmail.com

nnoremap H _
nnoremap L $

inoremap jk <esc>
inoremap <esc> <nop>

set timeoutlen=1000
set ttimeoutlen=1000
