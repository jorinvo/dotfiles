set nocompatible

set rtp+=~/.vim/bundle/Vundle.vim
runtime autoload/vundle.vim

"Check if Vundle is installed
if exists( '*vundle#rc' )
  filetype off
  " set the runtime path to include Vundle and initialize
  call vundle#begin()
  " let Vundle manage Vundle, required
  Plugin 'gmarik/Vundle.vim'

  " My plugins:

  Plugin 'Soares/solarized.vim'
  Plugin 'bling/vim-airline'
  Plugin 'tpope/vim-rsi'
  Plugin 'tpope/vim-sleuth'
  Plugin 'tpope/vim-surround'
  Plugin 'tpope/vim-repeat'
  Plugin 'tpope/vim-commentary'
  Plugin 'bronson/vim-visual-star-search'
  Plugin 'jiangmiao/auto-pairs'
  " Plugin 'kien/ctrlp.vim'
  " Plugin 'scrooloose/syntastic'
  Plugin 'tpope/vim-speeddating'
  Plugin 'airblade/vim-gitgutter'
  " Plugin 'Valloric/YouCompleteMe'
  " Plugin 'rking/ag.vim'
  Plugin 'edsono/vim-matchit'
  Plugin 'tpope/vim-vinegar'
  " Plugin 'pangloss/vim-javascript'
  " Plugin 'groenewege/vim-less'
  Plugin 'bkad/CamelCaseMotion'
  Plugin 'michaeljsmith/vim-indent-object'
  " Plugin 'ap/vim-css-color'
  " Plugin 'hail2u/vim-css3-syntax'
  " Plugin 'terryma/vim-expand-region'
  " Plugin 'tpope/vim-abolish'
  " Plugin 'marijnh/tern_for_vim'

  " All of your Plugins must be added before the following line
  call vundle#end()            " required by Vundle
  filetype plugin indent on    " required by Vundle
endif " End Vundle


" Theme
silent! colorscheme solarized
autocmd ColorScheme * highlight LineNr cterm=NONE ctermfg=256 ctermbg=NONE

" Enable syntax highlighting
syntax on
" Enable spell checking. See :help mkspell
set spell spelllang=en_us
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Don’t add empty newlines at the end of files
set binary
set noeol
" Respect modeline in files
set modeline
set modelines=4
" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable line numbers
set number
" Not sure if it really helps me.
" Also it makes hjkl moves way slower.
set relativenumber
" Highlight current line
set cursorline
set list
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase smartcase
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the filename in the window titlebar
set title
" Allow to hide unsaved buffer
set hidden

" Softtabs, 2 spaces
set tabstop=2
set shiftwidth=2
set shiftround
set expandtab

" Automatic commands

" Enable file type detection
filetype on
" Treat .json files as .js
autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
" Treat .md files as Markdown
autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
" autocmd BufRead,BufNewFile *.md set complete+=kspell


set autoread "to reload files changed outside vim

" swap files are boring
set noswapfile
set nobackup
set nowb
" Centralize undo history
if exists("&undodir")
  set undofile
  set undodir=~/.vim/undo
endif

set complete-=i
set smarttab

set nrformats-=octal

set ttimeout
set ttimeoutlen=100

set incsearch

" Airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

set noshowmode " Mode is already in Airline
set laststatus=2 " Always show status line
set ruler
set showcmd
set wildmenu

if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j " Delete comment character when joining commented lines
endif

if has('path_extra')
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

set fileformats+=mac

set history=1000
set viminfo^=!
set sessionoptions-=options

set splitbelow
set splitright

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Strip trailing whitespace
function! StripWhitespace()
	let save_cursor = getpos(".")
	let old_query = getreg('/')
	:%s/\s\+$//e
	call setpos('.', save_cursor)
	call setreg('/', old_query)
endfunction
autocmd BufWrite * :call StripWhitespace()

" Shortcut Mappings

nmap <space> :w<CR>
nnoremap g/ :noh<CR>

" Switch between the last two files
nnoremap <tab> <c-^>

" Save a file as root (\W)
" noremap <leader>W :w !sudo tee % > /dev/null<CR>
nnoremap <leader>s :% s//

" No surprises with long lines
nmap <silent> j gj
nmap <silent> k gk

" Allow dot command in visual mode
vnoremap . :norm.<CR>
vnoremap @ :norm@

" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

noremap ; :

" Jump to first character or column
nnoremap <silent> 0 :call FirstCharOrFirstCol()<cr>
function! FirstCharOrFirstCol()
  let current_col = virtcol('.')
  normal ^
  let first_char = virtcol('.')
  if current_col == first_char
    normal! 0
  endif
endfunction

" vmap v <Plug>(expand_region_expand)
" vmap <C-v> <Plug>(expand_region_shrink)

nmap n nzz
nmap N Nzz

" Syntastic
if exists("*Syntastic")
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  let g:syntastic_javascript_checkers = ['eslint']
  " let g:syntastic_javascript_checkers = ['standard']
  let g:syntastic_css_checkers = ['csslint']
  let g:syntastic_less_checkers = ['lessc']
  let g:syntastic_markdown_checkers = ['mdl']
endif " End Syntastic

" CtrlP
let g:ctrlp_working_path_mode = 'c'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'