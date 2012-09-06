"Vundle
set nocompatible               " be iMproved
filetype off                   " required!
syntax on
set laststatus=2
set encoding=utf-8

set rtp+=~/.vim/bundle/vundle/
" Plugins " {{{
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

"Vundles
Bundle "Markdown"
Bundle "https://github.com/vim-ruby/vim-ruby.git"
"Bundle "Command-T"
Bundle 'kien/ctrlp.vim'
let g:CommandTMatchWindowAtTop=1 " show window at top
Bundle "jQuery"
Bundle "rails.vim"
Bundle "fugitive.vim"
Bundle "tComment"
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>
Bundle "ack.vim"
noremap <LocalLeader># "ayiw:Ack <C-r>a<CR>
vnoremap <LocalLeader># "ay:Ack <C-r>a<CR>
Bundle "SuperTab"
Bundle 'unimpaired.vim'
Bundle 'Solarized'
Bundle 'VimClojure'
"Bundle "git://github.com/Lokaltog/vim-powerline.git"
Bundle "molokai"
Bundle "go"
Bundle "Go-Syntax"
"Bundle "Railscasts-Theme-GUIand256color"
"Bundle "Wombat"
" " }}}

"store lots of :cmdline history
set backupdir=~/.vim/backup,/tmp
set directory=~/.vim/backup,/tmp
set backupskip=/.vim/backup/*,/tmp
set writebackup

set history=1000

set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom

set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default

" make uses real tabs
au FileType make set noexpandtab

" Go
au BufRead,BufNewFile *.go set filetype=go

"Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" make Python follow PEP8 ( http://www.python.org/dev/peps/pep-0008/ )
au FileType python set softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79

set number      "add line numbers
set showbreak=...
set wrap linebreak nolist

set tabstop=4		                " tab stops
set softtabstop=2
set shiftwidth=2	                " number of spaces to use for each step of (auto)indent
set shiftround                      " Round indents to multiples of shiftwidth
set autoindent
set smartindent
set expandtab
set smarttab
set backspace=indent,eol,start

" Status Line
if has("statusline") && !&cp
  set laststatus=2  " always show the status bar

  " statusline
  " cf the default statusline: %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
  " format markers:
  "   %< truncation point
  "   %n buffer number
  "   %f relative path to file
  "   %m modified flag [+] (modified), [-] (unmodifiable) or nothing
  "   %r readonly flag [RO]
  "   %y filetype [ruby]
  "   %= split point for left and right justification
  "   %-35. width specification
  "   %l current line number
  "   %L number of lines in buffer
  "   %c current column number
  "   %V current virtual column number (-n), if different from %c
  "   %P percentage through buffer
  "   %) end of width specification
  set statusline=%<\ %n:%f\ %m%r%y%=%-35.(line:\ %l\ of\ %L,\ col:\ %c%V\ (%P)%)
endif

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
set wildignore+=**/vendor/plugins/**,**/vendor/gems/**,**/temp/**,**/tmp/**

filetype plugin indent on

"Font
set guifont=Monaco:h14

"disable visual bell
set visualbell t_vb=

"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2

"hide buffers when not displayed
set hidden

"key mapping for window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"key mapping for saving file
nmap <C-s> :w<CR>

"key mapping for tab navigation
nmap <Tab> gt
nmap <S-Tab> gT

"Key mapping for textmate-like indentation
nmap <D-[> <<
nmap <D-]> >>
vmap <D-[> <gv
vmap <D-]> >gv

"Command T
"let g:CommandTAcceptSelectionMap = '<C-t>'
"let g:CommandTAcceptSelectionTabMap = '<CR>'
"map <D-\> :CommandT<cr>

"# ctrlp.vim
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_user_command = 'find %s -type f'

if has("gui_macvim") && has("gui_running")
  map  <D-\> :CtrlP<CR>
  imap <D-\> <ESC>:CtrlP<CR>
else
  map <C-t> :CtrlP<CR>
  imap <C-t> <ESC>:CtrlP<CR>
endif

let g:ctrlp_open_new_file = 't'


" Settings for VimClojure
let vimclojure#HighlightBuiltins = 1
let vimclojure#ParenRainbow = 1
let vimclojure#WantNailgun = 1
let vimclojure#NailgunClient = "/usr/local/bin/ng"

" Search
" set hlsearch!
nnoremap <F3> :set hlsearch!<CR>

syntax enable
let g:solarized_termcolors=256

" Completion
" imap <Tab> <C-P>
set complete=.,b,u,]
set wildmode=longest,list:longest
set completeopt=menu,preview

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif

if has('gui_running')
  set background=light
  set guioptions=egmrt
  colorscheme Tomorrow-Bastos
else
  set background=dark
  colorscheme molokai
endif
