set nocompatible

call plug#begin('~/.vim/plugged')

" Using full urls for gx command
Plug 'https://github.com/altercation/vim-colors-solarized'
Plug 'https://github.com/bling/vim-airline'
Plug 'https://github.com/tpope/vim-rsi'
Plug 'https://github.com/tpope/vim-sleuth'
Plug 'https://github.com/tpope/vim-surround'
Plug 'https://github.com/tpope/vim-repeat'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-speeddating'
Plug 'https://github.com/tpope/vim-vinegar'
Plug 'https://github.com/tpope/vim-fugitive'
Plug 'https://github.com/tpope/vim-unimpaired'
Plug 'https://github.com/bronson/vim-visual-star-search'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/kien/ctrlp.vim'
Plug 'https://github.com/airblade/vim-gitgutter'
Plug 'https://github.com/rking/ag.vim'
Plug 'https://github.com/edsono/vim-matchit'
Plug 'https://github.com/bkad/CamelCaseMotion'
Plug 'https://github.com/michaeljsmith/vim-indent-object'
Plug 'https://github.com/Valloric/YouCompleteMe'
Plug 'https://github.com/benekastah/neomake', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'https://github.com/hail2u/vim-css3-syntax', { 'for': 'css' }
Plug 'https://github.com/pangloss/vim-javascript', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'https://github.com/mxw/vim-jsx', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'https://github.com/groenewege/vim-less', { 'for': 'less' }
Plug 'https://github.com/elmcast/elm-vim', { 'for': 'elm' }
" Plug 'https://github.com/terryma/vim-expand-region'
" Plug 'https://github.com/tpope/vim-abolish'
" Plug 'https://github.com/ap/vim-css-color', { 'for': 'css' }
" Plug 'https://github.com/marijnh/tern_for_vim', { 'for': 'css' }

" Add plugins to &runtimepath
call plug#end()



set encoding=utf-8


" Theme
silent! colorscheme solarized
set background=light
let g:solarized_termcolors=256
augroup colors
  autocmd!
  autocmd ColorScheme * highlight LineNr cterm=NONE ctermfg=256 ctermbg=NONE
augroup END

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
augroup file_types
  autocmd!
  " Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript
  " Treat .md files as Markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
  " autocmd BufRead,BufNewFile *.md set complete+=kspell
augroup END


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
" Automatically populate the g:airline_symbols dictionary with the powerline symbols.
let g:airline_powerline_fonts = 1
" Overwrite ugly lien number symbol
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.linenr = '#'

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
augroup strip_whitespace
  autocmd!
  autocmd BufWrite * :call StripWhitespace()
augroup END


augroup reload_vimrc
  autocmd!
  autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END



" Shortcut Mappings

" SPACE to save
nmap <space> :w<CR>
" Clear search highlight
nnoremap g/ :noh<CR>

" Overwrite Y to behave like other uppercase commands
nmap Y y$

" Go Settings - Opens vimrc
" (Overwrites built in sleep command. Sleep, seriously?)
nnoremap gs :e $MYVIMRC<CR>

" Command line history completion for ctrl-p and ctrl-n
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

if has('nvim')
  " ESC in terminal to exit insert mode
  tnoremap <esc> <C-\><C-n>
endif


" Switch between the last two files with TAB
nnoremap <tab> <c-^>

" No surprises with long lines
nmap <silent> j gj
nmap <silent> k gk

" Allow dot command in visual mode
vnoremap . :norm.<CR>
vnoremap @ :norm@

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

"
" Javascript helpers
"

" Console log from insert mode; Puts focus inside parentheses
imap gll console.log()<Esc>==F(a
" Console log from visual mode on next line, puts visual selection inside parentheses
vmap gl cgll<Esc>p



" Neomake
let g:neomake_javascript_enabled_makers = ['standard']
let g:neomake_javascript_jsx_enabled_makers = ['standard']
let g:neomake_jsx_enabled_makers = ['standard']
" Open location window and keep cursor position
let g:neomake_open_list = 2
augroup neo_make
  autocmd!
  autocmd! BufWritePost *.js Neomake
augroup END

" Syntastic
if exists("*Syntastic")
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*

  let g:syntastic_always_populate_loc_list = 1
  let g:syntastic_auto_loc_list = 1
  let g:syntastic_check_on_open = 1
  let g:syntastic_check_on_wq = 0
  " let g:syntastic_javascript_checkers = ['eslint']
  let g:syntastic_javascript_checkers = ['standard']
  let g:syntastic_css_checkers = ['csslint']
  let g:syntastic_less_checkers = ['lessc']
  let g:syntastic_markdown_checkers = ['mdl']
endif " End Syntastic

" CtrlP
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_user_command = 'git --git-dir=%s/.git ls-files -oc --exclude-standard'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$'
  \ }


" JSX
let g:jsx_ext_required = 0