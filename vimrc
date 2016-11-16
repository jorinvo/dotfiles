"
" Plugins
"

if !empty(glob('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.vim/plugged')

  " Using full urls for `gx` command

  " Theme
  Plug 'https://github.com/w0ng/vim-hybrid' " Theme
  Plug 'https://github.com/unblevable/quick-scope'
  Plug 'https://github.com/junegunn/goyo.vim' " Distraction-free mode
  " Navigation
  Plug 'https://github.com/tpope/vim-vinegar' " Enhance netrw - the default directory browser
  Plug 'https://github.com/tpope/vim-rsi' "Readline Style Insertion
  " Plug 'https://github.com/junegunn/vim-peekaboo'
  Plug 'https://github.com/ctrlpvim/ctrlp.vim'
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
  Plug 'https://github.com/rking/ag.vim'
  " Text objects
  Plug 'https://github.com/michaeljsmith/vim-indent-object'
  Plug 'https://github.com/wellle/targets.vim'
  Plug 'https://github.com/kana/vim-textobj-user'
  Plug 'https://github.com/kana/vim-textobj-entire'
  Plug 'https://github.com/kana/vim-textobj-line'
  " Completion
  Plug 'https://github.com/vim-scripts/delimitMate.vim'
  if has('nvim')
    Plug 'https://github.com/Shougo/deoplete.nvim'
    Plug 'https://github.com/zchee/deoplete-go', { 'do': 'make', 'for': 'go' }
    Plug 'https://github.com/zchee/deoplete-jedi', { 'for': 'python' }
  endif
  " Linting
  Plug 'https://github.com/benekastah/neomake', { 'for': 'javascript' }
  " Languages
  Plug 'https://github.com/hail2u/vim-css3-syntax', { 'for': 'css' }
  Plug 'https://github.com/groenewege/vim-less', { 'for': 'less' }

  Plug 'https://github.com/pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'https://github.com/mxw/vim-jsx', { 'for': 'javascript' }
  Plug 'https://github.com/ternjs/tern_for_vim', { 'do': 'npm i -g tern', 'for': 'javascript' } " For navigation and doc commands

  Plug 'https://github.com/posva/vim-vue', { 'for': 'vue' }

  Plug 'https://github.com/elzr/vim-json', { 'for': 'json' }

  Plug 'https://github.com/cespare/vim-toml', { 'for': ['toml', 'markdown'] }
  Plug 'https://github.com/plasticboy/vim-markdown', { 'for': 'markdown' }

  Plug 'https://github.com/fatih/vim-go', { 'for': 'go' }
  Plug 'https://github.com/nsf/gocode', { 'for': 'go', 'rtp': 'nvim', 'do': '~/.config/nvim/plugged/gocode/nvim/symlink.sh' }

  Plug 'https://github.com/jvirtanen/vim-octave', { 'for': ['matlab', 'octave']}

  Plug 'https://github.com/klen/python-mode', { 'for': 'python' } " For linting, syntax, motions
  Plug 'https://github.com/davidhalter/jedi-vim', { 'for': 'python' } " For navigation and doc commands

  " Add plugins to &runtimepath
  call plug#end()
endif

" Enable built-in plugin to open man pages using :Man command (:Man vim)
" runtime! ftplugin/man.vim



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
set inccommand=nosplit


" Theme
set background=light
let g:hybrid_custom_term_colors = 1
let g:hybrid_reduced_contrast = 1 " Remove this line if using the default palette.
silent! colorscheme hybrid


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

" Enable syntax highlighting
syntax on
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
  autocmd BufNewFile,BufRead *.md,*.txt setlocal spell spelllang=en_us
  autocmd BufNewFile,BufRead *.md setlocal complete+=kspell

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
  autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "norm! g`\"" |
      \ endif
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
  norml! gvy
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

" Global search
" (Overwrites built-in sleep command. Sleep, seriously?)
nnoremap gs :Ag<Space>

" Quit window
" (Overwrites built-in ex mode command)
nnoremap Q :q<CR>

" Go terminal - Open a terminal v-split
nnoremap gt v:term<CR>
vnoremap gt "tyv:term t<CR>

" SPACE to save and also disable highlighting of last search
nmap <space> :nohlsearch <bar> w<CR>

" Switch between the last two files with TAB
nnoremap <tab> <c-^>

" gl: Go Log command
" puts a line or a visual selection into a log/print statement
" Support for: js, py, go
function! JsLog()
  nmap gl ^iconsole.log(<esc>$a)<esc>
  vmap gl cconsole.log(<esc>pa)<esc>
endfunction
autocmd BufNewFile,BufRead *.js :call JsLog()
function! PyLog()
  nmap gl ^iprint(<esc>$a)<esc>
  vmap gl cprint(<esc>pa)<esc>
endfunction
autocmd BufNewFile,BufRead *.py :call PyLog()
function! GoLog()
  nmap gl ^ifmt.Println(<esc>$a)<esc>
  vmap gl cfmt.Println(<esc>pa)<esc>
endfunction
autocmd BufNewFile,BufRead *.go :call GoLog()


noremap gb :ls<CR>:b<Space>
set nomore

"
" Plugin configuration
"

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Make CtrlP use ag for listing the files. Way faster and no useless files.
  " Without --hidden, it never finds .travis.yml since it starts with a dot.
  let g:ctrlp_user_command = 'ag %s -l --hidden --nocolor -g ""'
  " Disable caching, ag is fast enough
  let g:ctrlp_use_caching = 0
endif


" Neomake
let g:neomake_javascript_enabled_makers = ['standard']
" let g:neomake_javascript_enabled_makers = ['jshint']
" Open location window and keep cursor position
let g:neomake_open_list = 2
augroup neo_make
  autocmd!
  autocmd! BufWritePost *.js Neomake
augroup end


" Go
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1
let g:go_auto_sameids = 1
let g:go_metalinter_autosave = 1
let g:go_metalinter_autosave_enabled = ['vet', 'golint', 'errcheck']
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'gocyclo', 'vetshadow', 'aligncheck', 'gotype', 'ineffassign', 'staticcheck', 'unused', 'varcheck', 'gosimple', 'misspell', 'goconst', 'dupl', 'gas', 'interfacer', 'lll', 'deadcode', 'unconvert', 'structcheck']

augroup go_bindings
  autocmd!
  autocmd Filetype go noremap gm :GoRename<CR>
  autocmd Filetype go noremap gr :GoReferrers<CR>
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


" Startify
let g:startify_list_order = ['sessions', 'files', 'dir']
let g:startify_files_number = 5
let g:startify_change_to_dir = 1
let g:startify_session_persistence = 1


" Quick scope
"
" Trigger a highlight in the appropriate direction when pressing these keys:
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']