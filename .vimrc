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

set nocompatible
filetype off

set history=50		" keep 50 lines of command line history
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
set colorcolumn=80

set rtp+=/usr/local/opt/fzf

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

Plugin 'mileszs/ack.vim'
Plugin 'junegunn/fzf.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'jgdavey/tslime.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'flazz/vim-colorschemes'
Plugin 'junegunn/vim-easy-align'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-haml'
Plugin 'plasticboy/vim-markdown'
Plugin 'prettier/vim-prettier'
Plugin 'tpope/vim-rhubarb'
Plugin 'slim-template/vim-slim'
Plugin 'tpope/vim-surround'
Plugin 'janko-m/vim-test'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'stephpy/vim-yaml'

call vundle#end()

syntax enable
filetype plugin indent on

autocmd BufNewFile,BufRead *.thor set ft=ruby
autocmd BufNewFile,BufRead *.jbuilder set ft=ruby

colorscheme kolor

let g:kolor_italic                 = 1
let g:kolor_bold                   = 1
let g:kolor_underlined             = 0
let g:kolor_alternative_matchparen = 0

let test#strategy = "tslime"

let vim_markdown_preview_browser = "Firefox"
let vim_markdown_preview_hotkey  = "<C-m>"

let $FZF_DEFAULT_COMMAND = 'ag -g ""'

let g:ctrp_cache_dir = $HOME . '/.cache/ctrp'
if executable('ag')
  let g:ctrp_user_command = 'ag %s -l --nocolor -g ""'
endif

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

nmap th :exec "tabmove " . (tabpagenr() - 2)<CR>
nmap tl :exec "tabmove " . (tabpagenr() + 1)<CR>

let test#ruby#rspec#executable = 'bundle exec rspec'
nmap Tc <Plug>SetTmuxVars
nmap Tt :TestNearest<CR>
nmap TT :TestFile<CR>
nmap Ta :TestSuite<CR>
nmap Tl :TestLast<CR>
nmap Tg :TestVisit<CR>

vmap <Enter> <Plug>(EasyAlign)
nmap =a <Plug>(EasyAlign)

nmap <C-p> :Files<CR>

highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE

runtime macros/matchit.vim

set rtp+=$GOROOT/misc/vim
