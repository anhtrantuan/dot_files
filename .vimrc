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
set history=200		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set number		" show line numbers
set showmatch		" show matching brackets
set cindent
set smartindent
set tabstop=2
set shiftwidth=2
set expandtab

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
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

execute pathogen#infect()
execute pathogen#helptags()

colorscheme fu

let g:NERDTreeShowLineNumbers = 1
let g:nerdtree_tabs_open_on_console_startup = 1
let g:Powerline_symbols = 'fancy'
let g:ycm_key_list_select_completion = ["<C-SPACE>", "<DOWN>"]
let g:ycm_key_list_previous_completion = ["<C-S-SPACE>", "<UP>"]
let g:SuperTabDefaultCompletionType = "<C-SPACE>"
let g:UltiSnipsExpandTrigger = "<TAB>"
let g:UltiSnipsJumpForwardTrigger = "<TAB>"
let g:UltiSnipsJumpBackwardTrigger = "<S-TAB>"

function! CheckSyntasticErrors()
	SyntasticCheck

	Errors
endfunction

function! ToggleSyntasticErrors()
	if empty(filter(tabpagebuflist(), 'getbufvar(v:val, "&buftype") is# "quickfix"'))
		Errors
	else
		lclose
	endif
endfunction

autocmd BufWritePost * call CheckSyntasticErrors()
autocmd BufWinLeave * lclose

map <F8> :TagbarToggle<CR>
map <F9> :SCCompile<CR>
map <F10> :SCCompileRun<CR>
map r<LEFT> :<C-U>exec "vertical resize -".v:count1<CR>
map r<DOWN> :<C-U>exec "resize -".v:count1<CR>
map r<UP> :<C-U>exec "resize +".v:count1<CR>
map r<RIGHT> :<C-U>exec "vertical resize +".v:count1<CR>
map <C-e> :call ToggleSyntasticErrors()<CR>

highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE

set nrformats=

runtime macros/matchit.vim

set smartcase
