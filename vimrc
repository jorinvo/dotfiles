"
" Plugins
"

if !empty(glob('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.vim/plugged')

  " Using full urls for `gx` command

  " Misc
  Plug 'https://github.com/editorconfig/editorconfig-vim'
  " Theme
  Plug 'https://github.com/NLKNguyen/papercolor-theme'
  " Navigation
  Plug 'https://github.com/tpope/vim-vinegar' " Enhance netrw - the default directory browser
  Plug 'https://github.com/tpope/vim-rsi' "Readline Style Insertion
  Plug 'https://github.com/google/vim-searchindex' " Show match count for search
  " Git
  Plug 'https://github.com/tpope/vim-fugitive'
  Plug 'https://github.com/tpope/vim-rhubarb' " Support for :Gbrowse Github command
  Plug 'https://github.com/airblade/vim-gitgutter'
  " Shortcuts
  Plug 'https://github.com/tpope/vim-repeat'
  Plug 'https://github.com/tpope/vim-surround'
  Plug 'https://github.com/tpope/vim-commentary'
  Plug 'https://github.com/tpope/vim-unimpaired' " Pairwise shortcuts
  " Text objects
  Plug 'https://github.com/michaeljsmith/vim-indent-object'
  Plug 'https://github.com/wellle/targets.vim'
  Plug 'https://github.com/kana/vim-textobj-user'
  Plug 'https://github.com/kana/vim-textobj-entire'
  Plug 'https://github.com/kana/vim-textobj-line'
  " Completion
  if has('nvim')
    Plug 'https://github.com/Shougo/deoplete.nvim'
    Plug 'https://github.com/zchee/deoplete-go', { 'do': 'make', 'for': 'go' }
    Plug 'https://github.com/zchee/deoplete-jedi', { 'for': 'python' }
  endif
  " Languages
  Plug 'https://github.com/hail2u/vim-css3-syntax', { 'for': 'css' }
  Plug 'https://github.com/groenewege/vim-less', { 'for': 'less' }

  Plug 'https://github.com/pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'https://github.com/mxw/vim-jsx', { 'for': 'javascript' }
  Plug 'https://github.com/ternjs/tern_for_vim', { 'do': 'npm i -g tern', 'for': 'javascript' } " For navigation and doc commands
  Plug 'https://github.com/benekastah/neomake', { 'do': 'npm i -g standard jshint', 'for': 'javascript' } " linting

  Plug 'https://github.com/posva/vim-vue', { 'for': 'vue' }

  Plug 'https://github.com/elzr/vim-json', { 'for': 'json' }

  Plug 'https://github.com/cespare/vim-toml', { 'for': ['toml', 'markdown'] }
  Plug 'https://github.com/plasticboy/vim-markdown', { 'for': 'markdown' }

  Plug 'https://github.com/fatih/vim-go', { 'for': 'go', 'do': 'nvim +GoInstallBinaries +qall' }

  Plug 'https://github.com/lervag/vimtex', { 'for': ['tex', 'plaintex', 'bib'] }

  Plug 'https://github.com/klen/python-mode', { 'for': 'python' } " For linting, syntax, motions
  Plug 'https://github.com/davidhalter/jedi-vim', { 'for': 'python' } " For navigation and doc commands

  " Add plugins to &runtimepath
  call plug#end()
endif


"
" Theme
"

" Enable syntax highlighting
" Needs to be first.
syntax on
set background=light
let g:PaperColor_Theme_Options = { 'theme': { 'default': { 'transparent_background': 1 } } }
silent! colorscheme PaperColor
" Enable italic
hi htmlArg cterm=italic
hi Comment cterm=italic
hi Type    cterm=italic


"
" Basics
"

" These are default in NeoVim
if !has('nvim')
  set nocompatible
  filetype off
  filetype plugin indent on

  set ttyfast
  set ttymouse=xterm2
  set ttyscroll=3

  set laststatus=2 " Always show status line
  set encoding=utf-8              " Set default encoding to UTF-8
  set autoread                    " Automatically reread changed files without asking me anything
  set autoindent
  set backspace=indent,eol,start  " Makes backspace key more powerful.
  set incsearch                   " Shows the match while typing
  set hlsearch                    " Highlight found searches
  set mouse=a
endif

" Show replacement incrementally in NeoVim
if exists("&inccommand")
  set inccommand=nosplit
endif


" Statusline
"
" %y      filetype
" %w      [Preview] flag
" %r      [RO] flag
" %f      relative file name
" %m      [+] or [-] flag
" %l      current line
" %L      total lines
" %3.c    current column displayed in 3 characters
" %(\ %)  empty space, but grouped to allow at end of line
set statusline=\ %y%w%r\ %f\ %m%=%l/%L\ \|%3.c%(\ %)

" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
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
" Highlight current line
set cursorline
set list
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

set complete-=i
set smarttab

set nrformats-=octal

set ttimeout
set ttimeoutlen=100

set ruler
set showcmd
set showmode
set wildmenu
set number

" swap files are boring
set noswapfile
set nobackup
set nowb

set fileformats+=mac

set history=1000
set viminfo^=!
set sessionoptions-=options

set splitbelow
set splitright

" Centralize undo history
if exists("&undodir")
  set undofile
  set undodir=~/.vim/undo
endif

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



"
" Auto-commands
"
augroup rc_cmds
  " Spell checking
  " Enable spell checking for text files. See :help mkspell
  autocmd BufNewFile,BufRead *.md,*.txt,*.tex,*.plaintex setlocal spell spelllang=en_us
  autocmd BufNewFile,BufRead *.md,*.tex,*.plaintex setlocal complete+=kspell

  " Strip trailing whitespace on save
  function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
  endfunction
  autocmd BufWrite * :call StripWhitespace()

  " Restore cursor position when opening file
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "norm! g`\"" | endif
augroup end


"
" Shortcut Mappings
"

" `ESC` in terminal to exit insert mode
if has('nvim')
  tnoremap <esc> <C-\><C-n>
endif

" Command line history completion with ctrl-p and ctrl-n
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>

" Allow dot command in visual mode
vnoremap . :norm.<CR>

" Overwrite Y to behave like other uppercase commands
nmap Y y$

" Thx https://github.com/fatih/dotfiles/blob/master/init.vim
" Don't move on * I'd use a function for this but Vim clobbers the last search
" when you're in a function so fuck it, practicality beats purity.
nnoremap <silent> * :let stay_star_view = winsaveview()<cr>*:call winrestview(stay_star_view)<cr>

" Visual Mode */# from Scrooloose
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" Jump to first character or column
nnoremap <silent> 0 :call FirstCharOrFirstCol()<cr>
function! FirstCharOrFirstCol()
  let current_col = virtcol('.')
  norm ^
  let first_char = virtcol('.')
  if current_col == first_char
    norm! 0
  endif
endfunction

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Quit window
" (Overwrites built-in ex mode command)
nnoremap Q :q<CR>

" Go terminal - Open a terminal v-split
nnoremap gt :term<Space>
" Opens terminal and runs selction as cmd
vnoremap gt "ty<C-W>v:term <C-R>t<CR>

" SPACE to save and also disable highlighting of last search
nmap <space> :nohlsearch <bar> w<CR>

" Switch between the last two files with TAB
nnoremap <tab> <c-^>

" Go buffer - list buffers and open prompt
noremap gb :ls<CR>:b<space>

" Go path
nnoremap gp :e **/*
" Ignore dirs for path expansion
set wildignore+=*.gif,*.jpg,*.png,*.ico,*.pdf
set wildignore+=node_modules/*,bower_components/*,vendor/*,.git/*

" Use something faster than grep
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat=%f:%l:%c:%m
elseif executable('ag')
    set grepprg=ag\ --vimgrep\
    set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable('ack')
    set grepprg=ack\ --nogroup\ --nocolor\ --ignore-case\ --column
    set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" Grep search
nnoremap gs :silent grep<space>
vnoremap gs "vy:silent grep "<C-R>v"<CR>:cw<CR>

" Make quickfix list editable;
" useful to delete matches before using :cdo
:autocmd BufReadPost quickfix set modifiable
" Automatically open quickfix /location list after quickfix ran
augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
augroup end


" gl: Go Log command
" puts a line or a visual selection into a log/print statement
" Support for: js, go, py, md
function! JsLog()
  nmap gl ^iconsole.log(<esc>$a)<esc>
  vmap gl cconsole.log(<esc>pa)<esc>
endfunction
autocmd BufNewFile,BufRead *.js,*.jsx :call JsLog()
function! GoLog()
  nmap gl ^ifmt.Println(<esc>$a)<esc>
  vmap gl cfmt.Println(<esc>pa)<esc>
endfunction
autocmd BufNewFile,BufRead *.go :call GoLog()
function! MdGoLink()
  nmap gl Ea)<esc>Bi[](<esc>hi
  vmap gl Sbi[]<esc>i
endfunction
autocmd BufNewFile,BufRead *.md :call MdGoLink()
function! PyLog()
  nmap gl ^iprint(<esc>$a)<esc>
  vmap gl cprint(<esc>pa)<esc>
endfunction
autocmd BufNewFile,BufRead *.py :call PyLog()



"
" Plugin configuration
"

" Go
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 1
augroup go_bindings
  autocmd!
  autocmd Filetype go noremap gm :GoRename<CR>
  autocmd Filetype go noremap gr :GoReferrers<CR>
  autocmd Filetype go :GoPath ~/go
augroup end


" JS
let g:tern_request_timeout = 1 " Disable completion
let g:tern_show_signature_in_pum = 0  " This do disable full signature type on autocomplete
" Use tern_for_vim.
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]
augroup tern_docs
  autocmd!
  autocmd Filetype javascript noremap K :TernDocBrowse<CR>
  autocmd Filetype javascript noremap gd :TernDef<CR>
  autocmd Filetype javascript noremap gm :TernRename<CR>
  autocmd Filetype javascript noremap gr :TernRefs<CR>
augroup end
" Neomake
if filereadable(".jshintrc")
  let g:neomake_javascript_enabled_makers = ['jshint']
elseif filereadable("package.json") && match(readfile("package.json"), "\"standard\":")
  let g:neomake_javascript_enabled_makers = ['standard']
else
  let g:neomake_javascript_enabled_makers = []
endif
" Open location window and keep cursor position
let g:neomake_open_list = 2
" Run on save
augroup neo_make
  autocmd!
  autocmd! BufWritePost *.js Neomake
augroup end



" Python
let g:pymode_python = 'python3'
let g:pymode_rope = 0
if has('nvim')
  let g:jedi#completions_enabled = 0
endif
let g:jedi#goto_command = "gD"
let g:jedi#goto_assignments_command = "gd"
let g:jedi#usages_command = "gr"
let g:jedi#rename_command = "gm"


" JSON
let g:vim_json_syntax_conceal = 0


" Fugitive
set diffopt=filler,vertical


" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#align_class = 1
" Use fuzzy matches
if !empty(glob('~/.vim/plugged/deoplete.nvim')) && has("nvim")
  call deoplete#custom#set('_', 'matchers', ['matcher_fuzzy'])
end
