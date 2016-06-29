set nocompatible

"
" Plugins
"
if !empty(glob('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.vim/plugged')

  " Using full urls for gx command

  " Theme
  Plug 'https://github.com/w0ng/vim-hybrid' " Theme
  Plug 'https://github.com/bling/vim-airline'
  Plug 'https://github.com/vim-airline/vim-airline-themes'
  Plug 'https://github.com/edsono/vim-matchit'
  Plug 'https://github.com/junegunn/goyo.vim' " Distraction-free mode
  Plug 'https://github.com/mhinz/vim-startify' " Fancy start screen
  " Navigation
  Plug 'https://github.com/tpope/vim-vinegar' " Enhance netrw - the default directory browser
  Plug 'https://github.com/tpope/vim-rsi' "Readline Style Insertion
  Plug 'https://github.com/junegunn/vim-peekaboo'
  " Git
  Plug 'https://github.com/tpope/vim-fugitive'
  Plug 'https://github.com/airblade/vim-gitgutter'
  Plug 'https://github.com/junegunn/gv.vim' " Commit log
  " Shortcuts
  Plug 'https://github.com/tpope/vim-repeat'
  Plug 'https://github.com/tpope/vim-surround'
  Plug 'https://github.com/tpope/vim-commentary'
  Plug 'https://github.com/tpope/vim-unimpaired' " Pairwise shortcuts
  Plug 'https://github.com/bronson/vim-visual-star-search'
  " File search
  Plug 'https://github.com/Shougo/unite.vim'
  Plug 'https://github.com/rking/ag.vim'
  " Motions
  Plug 'https://github.com/bkad/CamelCaseMotion'
  Plug 'https://github.com/michaeljsmith/vim-indent-object'
  " Completion
  Plug 'https://github.com/Shougo/deoplete.nvim'
  " Linting
  Plug 'https://github.com/benekastah/neomake', { 'for': 'javascript' }

  " Languages
  Plug 'https://github.com/hail2u/vim-css3-syntax', { 'for': 'css' }
  Plug 'https://github.com/groenewege/vim-less', { 'for': 'less' }

  Plug 'https://github.com/pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'https://github.com/mxw/vim-jsx', { 'for': 'javascript' }
  Plug 'https://github.com/ternjs/tern_for_vim', { 'do': 'npm i -g tern', 'for': 'javascript' } " For navigation and doc commands
  Plug 'https://github.com/carlitux/deoplete-ternjs', { 'for': 'javascript' } " For completion

  Plug 'https://github.com/elzr/vim-json', { 'for': 'json' }

  Plug 'https://github.com/cespare/vim-toml', { 'for': ['toml', 'markdown'] }
  Plug 'https://github.com/plasticboy/vim-markdown', { 'for': 'markdown' }

  Plug 'https://github.com/fatih/vim-go', { 'for': 'go' }
  Plug 'https://github.com/zchee/deoplete-go', { 'do': 'make', 'for': 'go' }
  Plug 'https://github.com/nsf/gocode', { 'for': 'go', 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

  Plug 'https://github.com/jvirtanen/vim-octave', { 'for': ['matlab', 'octave']}

  Plug 'https://github.com/klen/python-mode', { 'for': 'python' } " For linting, syntax, motions
  Plug 'https://github.com/davidhalter/jedi-vim', { 'for': 'python' } " For navigation and doc commands
  Plug 'https://github.com/zchee/deoplete-jedi', { 'for': 'python' } " For completion


  " Add plugins to &runtimepath
  call plug#end()
endif


set encoding=utf-8


" Theme
set background=light
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
silent! colorscheme hybrid

" Enable syntax highlighting
syntax on
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Only redraw when necessary.
set lazyredraw
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
" Doens't really help me.
" Also it makes hjkl move way slower.
set norelativenumber
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
" Disable closing of all folds
set nofoldenable

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
  " Treat .md files as Markdown
  autocmd BufNewFile,BufRead *.md setlocal filetype=markdown
" Enable spell checking only for md files. See :help mkspell
  autocmd BufNewFile,BufRead *.md setlocal spell spelllang=en_us
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
let g:airline_left_sep=''
let g:airline_right_sep=''
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_symbols.branch = '⎇'
let g:airline_theme='light'

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

" Restore cursor position when opening file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif



" Shortcut Mappings

" SPACE to save
nmap <space> :w<CR>
" Clear search highlight
nnoremap g/ :noh<CR>

" Overwrite Y to behave like other uppercase commands
nmap Y y$

" Go to Settings - Opens vimrc
" (Overwrites built in sleep command. Sleep, seriously?)
nnoremap gs :e $MYVIMRC<CR>

nnoremap gt v:term<CR>
vnoremap gt "tyv:term t<CR>

" Command line history completion with ctrl-p and ctrl-n
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

if has('nvim')
  " ESC in terminal to exit insert mode
  tnoremap <esc><esc> <C-\><C-n>
endif


" Switch between the last two files with TAB
nnoremap <tab> <c-^>

" Allow dot command in visual mode
vnoremap . :norm.<CR>
vnoremap @ :norm@

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

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
vnoremap gl cconsole.log(")<Esc>



" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  let g:unite_source_rec_async_command = ['ag', '--follow', '--nocolor', '--nogroup', '-g', '']
endif

" Unite
silent! call unite#filters#matcher_default#use(['matcher_fuzzy'])
nnoremap <C-p> :Unite -start-insert buffer file_rec/neovim:!<CR>

" Neomake
let g:neomake_javascript_enabled_makers = ['standard']
" Open location window and keep cursor position
let g:neomake_open_list = 2
augroup neo_make
  autocmd!
  autocmd! BufWritePost *.js Neomake
augroup END


" JS
" Use deoplete.
let g:tern_request_timeout = 1
let g:tern_show_signature_in_pum = 0  " This do disable full signature type on autocomplete
" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
augroup tern_docs
  autocmd!
  autocmd Filetype javascript noremap K :TernDocBrowse<CR>
  autocmd Filetype javascript noremap gd :TernDef<CR>
  autocmd Filetype javascript noremap gr :TernRename<CR>
  autocmd Filetype javascript noremap <leader>u :TernRefs<CR>
augroup END

" JSON
let g:vim_json_syntax_conceal = 0

" CamelCaseMotion
silent! call camelcasemotion#CreateMotionMappings('<leader>')

" Fugitive
set diffopt=filler,vertical

" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#align_class = 1

" Go
let g:go_fmt_command = "goimports"

" Python
let g:pymode_python = 'python3'
let g:pymode_rope = 0
let g:jedi#completions_enabled = 0
let g:jedi#goto_command = "gD"
let g:jedi#goto_assignments_command = "gd"
let g:jedi#usages_command = "<leader>u"
let g:jedi#rename_command = "gr"

" Startify
let g:startify_list_order = ['sessions', 'files', 'dir']
let g:startify_files_number = 5
let g:startify_change_to_dir = 1
let g:startify_session_persistence = 1