"
" Plugins
"

if !empty(glob('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.vim/plugged')

  " Using full urls for `gx` command

  " Misc
  Plug 'https://github.com/tpope/vim-speeddating'
  Plug 'https://github.com/tpope/vim-eunuch'
  Plug 'https://github.com/nelstrom/vim-visual-star-search'
  Plug 'https://github.com/junegunn/vim-easy-align'
  " Theme
  Plug 'https://github.com/jeffkreeftmeijer/vim-dim'
  " Navigation
  Plug 'https://github.com/tpope/vim-vinegar' " Enhance netrw - the default directory browser
  Plug 'https://github.com/tpope/vim-rsi' "Readline Style Insertion
  Plug 'https://github.com/google/vim-searchindex' " Show match count for search
  Plug 'https://github.com/junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
  Plug 'https://github.com/junegunn/fzf.vim'
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
  Plug 'https://github.com/wellle/targets.vim' " i text object
  Plug 'https://github.com/kana/vim-textobj-user' " Reqired for ones below
  Plug 'https://github.com/kana/vim-textobj-entire' " e text object
  Plug 'https://github.com/kana/vim-textobj-line' " l text object
  " Completion
  if has('nvim')
    Plug 'https://github.com/Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'https://github.com/zchee/deoplete-go', { 'do': 'make', 'for': 'go' }
    Plug 'https://github.com/zchee/deoplete-jedi', { 'for': 'python' }
  endif
  " Linting
  Plug 'https://github.com/w0rp/ale' " Lint and fix
  " Languages
  Plug 'https://github.com/pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'https://github.com/moll/vim-node', { 'for': ['javascript', 'typescript'] } " gf command for path and modules in js
  Plug 'https://github.com/leafgarland/typescript-vim', { 'for': 'typescript' }
  Plug 'https://github.com/jiangmiao/auto-pairs', { 'for': ['javascript', 'typescript'] }

  Plug 'https://github.com/elzr/vim-json', { 'for': 'json' }

  Plug 'https://github.com/fatih/vim-go', { 'for': 'go', 'do': 'nvim +GoInstallBinaries +qall' }

  Plug 'https://github.com/klen/python-mode', { 'for': 'python' } " For linting, syntax, motions
  Plug 'https://github.com/davidhalter/jedi-vim', { 'for': 'python' } " For navigation and doc commands

  Plug 'https://github.com/chr4/nginx.vim'

  Plug 'https://github.com/tpope/vim-fireplace', { 'for': 'clojure' }
  " Plug 'https://github.com/clojure-vim/async-clj-omni', { 'for': 'clojure' }
  Plug 'https://github.com/guns/vim-sexp', { 'for': 'clojure' }
  Plug 'https://github.com/tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }

  " Add plugins to &runtimepath
  call plug#end()
endif


"
" Theme
"

" Enable syntax highlighting
" Needs to be first.
syntax on
set background=dark
silent! colorscheme dim
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

  set laststatus=2                " Always show status line
  set encoding=utf-8              " Set default encoding to UTF-8
  set autoread                    " Automatically reread changed files without asking me anything
  set autoindent
  set backspace=indent,eol,start  " Makes backspace key more powerful.
  set incsearch                   " Shows the match while typing
  set hlsearch                    " Highlight found searches
  set mouse=a
endif

" Show replacement incrementally in NeoVim
if exists('&inccommand')
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
set nonumber

" swap files are boring
set noswapfile
set nobackup
set nowb

set fileformats+=mac

set history=10000
set viminfo^=!
set sessionoptions-=options

set splitbelow
set splitright

" Centralize undo history
if exists('&undodir')
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

set listchars=tab:→\ ,nbsp:␣,trail:·

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has('patch541')
  set formatoptions+=j
endif

" Ignore dirs for path expansion
set wildignore+=*.gif,*.jpg,*.png,*.ico,*.pdf
set wildignore+=node_modules/*,bower_components/*,vendor/*,.git/*

set spellfile=~/.vimspell.add


augroup filetypedetect
  au BufNewFile,BufRead *.boot setfiletype clojure
  au BufNewFile,BufRead *.babelrc setfiletype json
  au BufNewFile,BufRead *.eslintrc setfiletype json
  au BufNewFile,BufRead Dockerfile.* setfiletype dockerfile
augroup END


"
" Auto-commands
"
augroup rc_cmds
  " Strip trailing whitespace on save
  function! StripWhitespace()
    let save_cursor = getpos('.')
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
  endfunction
  autocmd BufWrite * :call StripWhitespace()

  " Restore cursor position when opening file
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line('$') | exe "norm! g`\"" | endif
augroup end


"
" Shortcut Mappings
"

" see this bug: https://github.com/neovim/neovim/issues/4612
if executable('xdg-open')
  nmap <silent> gx :silent !xdg-open <cWORD><cr>
elseif executable('open')
  nmap <silent> gx :silent !open <cWORD><cr>
endif

" `ESC` in terminal to exit insert mode
" Can still escape in nested vim using ctrl-c
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
nnoremap Q <C-w>c

nmap ; :

" Go terminal - Open a terminal
nnoremap gtt :term<CR>i
nnoremap gtvt <C-w><C-v>:term<CR>i
nnoremap gtp :term<space>
nnoremap gtvp <C-w><C-v>:term<space>

" SPACE to save and also disable highlighting of last search
nmap <space> :nohlsearch <bar> w<CR>

nnoremap <silent> "" :registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>

" Switch between the last two files
nnoremap <tab> <c-^>

" Go buffer - list buffers and open prompt
noremap gb :Buffers<CR>
" Fuzzy open file.
map gp :Files<CR>
" Also make them work in file browser
augroup netrw_mapping
    autocmd!
    autocmd filetype netrw call NetrwMapping()
augroup END
function! NetrwMapping()
    noremap <buffer> gp :Files<CR>
    noremap <buffer> gb :Buffers<CR>
endfunction

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

" `gr`ep
nnoremap gr :silent grep<space>
vnoremap gr "vy:silent grep "<C-R>v"<space>

" Git stuff

" git status
nnoremap gst :Gstatus<CR>
vnoremap gst :Gstatus<CR>
" git search branch
nnoremap gsb :term bash -i -c 'fco'<CR>:f fco<CR>i
" git stage stage
nnoremap gss :GitGutterStageHunk<CR>
" git stage undo
nnoremap gsu :GitGutterUndoHunk<CR>

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
  nmap gl ^iconsole.log(<esc>lx$a)<esc>
  vmap gl cconsole.log(<esc>pa)<esc>
endfunction
autocmd BufNewFile,BufRead *.js,*.jsx,*.ts :call JsLog()
function! GoLog()
  nmap gl ^ifmt.Println(<esc>lx$a)<esc>
  vmap gl cfmt.Println(<esc>lxpa)<esc>
endfunction
autocmd BufNewFile,BufRead *.go :call GoLog()

vnoremap < <gv
vnoremap > >gv


"
" Commands
"

command JSONFormat :%!jq '.'

" Expanding links allows me to better use git and file browser
command RC execute "e ".resolve(expand("~/.vimrc"))
command Todo execute "e ".resolve(expand("~/todo.md"))

command Scratch norm :term bash -i -c 'scratch'<CR>:f clj-scratch<CR>:e .scratchpad.clj<CR>


"
" Plugin configuration
"

" Go
let g:go_fmt_command = 'goimports'
let g:go_metalinter_autosave = 1
let g:go_metalinter_deadline = '10s'
let g:go_metalinter_enabled = ['vet', 'golint', 'errcheck', 'staticcheck', 'unused']
augroup go_bindings
  autocmd!
  autocmd Filetype go noremap gm :GoRename<CR>
  autocmd Filetype go noremap gtr :GoReferrers<CR>
  autocmd Filetype go :GoPath ~/go
augroup end


" Linting
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 1
let g:ale_linters = {'javascript': ['eslint'], 'typescript': ['eslint', 'tsserver'], 'clojure': ['clj-kondo']}
" TODO they are broken for some reason
" let g:ale_fix_on_save = 0
let g:ale_fixers = {'javascript': ['eslint'], 'typescript': ['eslint']}

" TypeScript
command ESLintFix norm :silent !cd %:p:h; npx eslint --fix %:t<CR>
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''
augroup ts_bindings
  autocmd!
  autocmd Filetype typescript noremap gd :ALEGoToDefinition<CR>
  autocmd Filetype typescript noremap K :ALEHover<CR>
  autocmd Filetype typescript noremap gK :ALEDetail<CR>
  autocmd Filetype typescript noremap gtr :ALEFindReferences<CR>
  autocmd Filetype typescript noremap gm :ALERename<CR>
  autocmd Filetype typescript noremap ]s :ALENextWrap<CR>
  autocmd Filetype typescript noremap [s :ALEPreviousWrap<CR>
  autocmd FileType typescript nmap <buffer> cro <C-L>i<C-P><CR><ESC><C-H>
  autocmd FileType javascript nmap <buffer> cro <C-L>i<C-P><CR><ESC><C-H>
augroup end


" Python
let g:pymode_python = 'python3'
let g:pymode_rope = 0
if has('nvim')
  let g:jedi#completions_enabled = 0
endif
let g:jedi#goto_command = 'gD'
let g:jedi#goto_assignments_command = 'gd'
let g:jedi#usages_command = 'gr'
let g:jedi#rename_command = 'gm'


" JSON
let g:vim_json_syntax_conceal = 0


" Fugitive
set diffopt=filler,vertical


" Deoplete
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#align_class = 1
" Use fuzzy matches
" if !empty(glob('~/.vim/plugged/deoplete.nvim')) && has('nvim')
  " call deoplete#custom#option('keyword_patterns', {'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'})
" end

augroup clojure_bindings
  autocmd!
  autocmd FileType clojure nmap <buffer> cro :Eval<CR>:Eval (do (in-ns 'dev.reload) (reload-browser))<CR>
  autocmd FileType clojure nmap <buffer> gd ]<C-D>
  autocmd FileType clojure nmap gl ysaebaprn<space><esc><esc>
augroup end

" Markdown
let g:vim_markdown_frontmatter = 1
augroup markdown_bindings
  autocmd!
  autocmd FileType markdown setlocal spell
augroup end

