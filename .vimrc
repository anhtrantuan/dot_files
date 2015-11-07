" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file
endif

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has("mouse")
  set mouse=a
endif

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

set history=1000		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number		" show line numbers
set showmatch		" show matching brackets
set cindent
set autoindent
set copyindent
set tabstop=2
set shiftwidth=2
set expandtab
set smartcase
set undolevels=1000
set title
set visualbell
set noerrorbells
set relativenumber
set nrformats=
set foldcolumn=1
" set foldmethod=syntax
set nofoldenable
set laststatus=2
set pastetoggle=<F2>

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

Bundle 'gmarik/vundle'

Bundle 'mileszs/ack.vim'
Bundle 'kien/ctrlp.vim'
Bundle 'jimmyhchan/dustjs.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'flazz/vim-colorschemes'
Bundle 'junegunn/vim-easy-align'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-haml'
Bundle 'plasticboy/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'thoughtbot/vim-rspec'
Bundle 'tpope/vim-surround'
Bundle 'avakhov/vim-yaml'

call vundle#end()

colorscheme kolor

let g:kolor_italic=1
let g:kolor_bold=1
let g:kolor_underlined=0
let g:kolor_alternative_matchparen=0

function! ToggleRelativeNumber()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunction

nmap gct :exec "!ctags -R ."<CR>

nmap r<LEFT> :<C-U>exec "vertical resize -".v:count1<CR>
nmap r<DOWN> :<C-U>exec "resize -".v:count1<CR>
nmap r<UP> :<C-U>exec "resize +".v:count1<CR>
nmap r<RIGHT> :<C-U>exec "vertical resize +".v:count1<CR>

nmap <C-n> :call ToggleRelativeNumber()<CR>

nmap th :exec 'tabmove ' . (tabpagenr() - 2)<CR>
nmap tl :exec 'tabmove ' . tabpagenr()<CR>

nmap Tt :call RunCurrentSpecFile()<CR>
nmap Ts :call RunNearestSpec()<CR>
nmap Tl :call RunLastSpec()<CR>
nmap Ta :call RunAllSpecs()<CR>

vmap <Enter> <Plug>(EasyAlign)
nmap =a <Plug>(EasyAlign)

highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE

runtime macros/matchit.vim

set rtp+=$GOROOT/misc/vim
