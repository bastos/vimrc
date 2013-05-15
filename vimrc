set nocompatible               " be iMproved
filetype off                   " required!
syntax on
set laststatus=2
set encoding=utf-8
let mapleader = ","

" http://stackoverflow.com/questions/14802689/macvim-wont-load-specific-color-scheme-by-default
let macvim_skip_colorscheme=1

" Add a bit extra margin to the left
set foldcolumn=1

" Set to auto read when a file is changed from the outside
set autoread

set rtp+=~/.vim/bundle/vundle/
" Plugins " {{{
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

"Vundles
Bundle "tpope/vim-markdown"
Bundle "tpope/vim-repeat"
Bundle "tpope/vim-dispatch"
Bundle "terryma/vim-multiple-cursors"
Bundle "https://github.com/vim-ruby/vim-ruby.git"
Bundle 'kien/ctrlp.vim'
Bundle 'godlygeek/tabular'
Bundle "jQuery"
Bundle "rails.vim"
Bundle "fugitive.vim"
Bundle "commentary.vim"
Bundle "ack.vim"
Bundle "SuperTab"
Bundle 'unimpaired.vim'
Bundle 'Solarized'
Bundle 'VimClojure'
Bundle "molokai"
Bundle "uggedal/go-vim"
Bundle "Go-Syntax"
Bundle "Raimondi/delimitMate"
Bundle "tpope/vim-surround"
Bundle "Gundo"
Bundle "majutsushi/tagbar"
Bundle "szw/vim-tags"
Bundle "Syntastic"
Bundle 'airblade/vim-gitgutter'
Bundle 'gcmt/psearch.vim'
Bundle "scrooloose/nerdtree"
Bundle 'jistr/vim-nerdtree-tabs'
Bundle 'rizzatti/funcoo.vim'
Bundle 'rizzatti/dash.vim'
Bundle 'slim-template/vim-slim'

"store lots of :cmdline history
set backupdir=~/.vim/backup,/tmp
set directory=~/.vim/backup,/tmp
set backupskip=/.vim/backup/*,/tmp
set nobackup
set noswapfile
set history=1000
set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
set incsearch   "find the next match as we type the search
set hlsearch    "hilight searches by default
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
" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
set wildignore+=**/vendor/plugins/**,**/vendor/gems/**,**/temp/**,**/tmp/**
"Font
set guifont=Monaco:h14
"disable visual bell
set visualbell t_vb=
"some stuff to get the mouse going in term
set mouse=a
set ttymouse=xterm2
"hide buffers when not displayed
set hidden
" Completion
" imap <Tab> <C-P>
set complete=.,b,u,]
set wildmode=longest,list:longest
set completeopt=menu,preview
" Display extra whitespace
set list listchars=tab:»·,trail:·
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/tmp/*,*.so,*.swp,*.zip
" make searches case-sensitive only if they contain upper-case characters
set ignorecase
set smartcase
set shell=zsh
set cmdheight=1

" Use Ack instead of Grep when available
if executable("ack")
  "set grepprg=ack\ -H\ --nogroup\ --nocolor
  let g:ackprg = 'ag --nogroup --nocolor --column'
endif

" Ack
noremap <LocalLeader># "ayiw:Ack <C-r>a<CR>
vnoremap <LocalLeader># "ay:Ack <C-r>a<CR>

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" Remember info about open buffers on close
set viminfo^=%

" Syntastic
let g:syntastic_mode_map = { 'mode': 'passive',
      \ 'active_filetypes': ['ruby', 'puppet', 'yaml', 'erlang', 'c', 'python'],
      \ 'passive_filetypes': [] }

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

filetype plugin indent on

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

" clean last search results
nnoremap <leader>lr <esc>:let @/ = ""<cr>:<esc>

" W also saves
command! W w

" Q also quits
command! Q q

" Commentary
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

"key mapping for window navigation
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

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

" Save
nmap <leader>w :w!<cr>

" NerdTree
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark
map <leader>nf :NERDTreeFind<cr>

" Gundo
nnoremap <F5> :GundoToggle<CR>

" Nerdtree
map <Leader>nt <plug>NERDTreeTabsToggle<CR>

" PSearch

map <leader>f :PSearch

" CtrlP
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/](\.git|\.hg|\.svn|build|bin)$',
      \ 'file': '\.class$\|\.so$\|\.db$\|\.swp$',
      \ }
let g:ctrlp_user_command = 'find %s -type f'
map <C-b> :CtrlPBuffer<CR>
":map <C-p> :CtrlPMixed<CR>

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

" Le wildmenu
set wildmenu
set wildmode=list:longest,full

" Search
" set hlsearch!
nnoremap <F3> :set hlsearch!<CR>

syntax enable

" Solarized
let g:solarized_termcolors=256
let g:solarized_contrast="high"
let g:solarized_visibility="high"

" Set search highlight off
nnoremap <leader>lr <esc>:let @/ = ""<cr>:<esc>

" Tagbar
nmap <leader><F8> :TagbarToggle<CR>

" Delete trailing spaces
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
au BufWrite * :call DeleteTrailingWS()

" Rename Current File
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

if has('gui_running')
  set background=light
  set guioptions=egmrt

  colorscheme Tomorrow-Bastos
else
  set background=dark
  colorscheme molokai
endif

" Change Font size
let s:pattern = '^\(.* \)\([1-9][0-9]*\)$'
let s:minfontsize = 6
let s:maxfontsize = 16
function! AdjustFontSize(amount)
  if has("gui_gtk2") && has("gui_running")
    let fontname = substitute(&guifont, s:pattern, '\1', '')
    let cursize = substitute(&guifont, s:pattern, '\2', '')
    let newsize = cursize + a:amount
    if (newsize >= s:minfontsize) && (newsize <= s:maxfontsize)
      let newfont = fontname . newsize
      let &guifont = newfont
    endif
:  else
    echoerr "You need to run the GTK2 version of Vim to use this function."
  endif
endfunction

function! LargerFont()
  call AdjustFontSize(1)
endfunction
command! LargerFont call LargerFont()

function! SmallerFont()
  call AdjustFontSize(-1)
endfunction
command! SmallerFont call SmallerFont()

" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" Vimgutter
highlight clear SignColumn
