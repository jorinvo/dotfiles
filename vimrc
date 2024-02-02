"
" Plugins
"

if !empty(glob('~/.vim/autoload/plug.vim'))
  call plug#begin('~/.vim/plugged')

  " Using full urls for `gx` command

  " Misc
  Plug 'https://github.com/nelstrom/vim-visual-star-search'
  Plug 'https://github.com/github/copilot.vim'
  Plug 'https://github.com/stevearc/dressing.nvim'
  Plug 'https://github.com/ziontee113/icon-picker.nvim'
  Plug 'https://github.com/willothy/flatten.nvim'
  Plug 'https://github.com/windwp/nvim-autopairs'
  Plug 'https://github.com/gennaro-tedesco/nvim-peekup'

  function! UpdateRemotePlugins(...)
    " Needed to refresh runtime files
    let &rtp=&rtp
    UpdateRemotePlugins
  endfunction
  Plug 'https://github.com/gelguy/wilder.nvim', { 'do': function('UpdateRemotePlugins') }
  " Theme
  Plug 'https://github.com/shaunsingh/nord.nvim'
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
  " Language server support, auto-completion, diagnostics, docs, go-to-def, ...
  Plug 'https://github.com/prabirshrestha/vim-lsp'
  Plug 'https://github.com/mattn/vim-lsp-settings'
  Plug 'https://github.com/prabirshrestha/asyncomplete.vim'
  Plug 'https://github.com/prabirshrestha/asyncomplete-lsp.vim'
  " Languages
  Plug 'https://github.com/pangloss/vim-javascript', { 'for': 'javascript' }
  Plug 'https://github.com/leafgarland/typescript-vim', { 'for': ['typescript', 'typescriptreact'] }
  Plug 'https://github.com/peitalin/vim-jsx-typescript', { 'for': 'typescriptreact' }
  Plug 'https://github.com/moll/vim-node', { 'for': ['javascript', 'typescript', 'typescriptreact'] } " gf command for path and modules in js
  Plug 'https://github.com/prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production', 'branch': 'release/0.x' }

  Plug 'https://github.com/elzr/vim-json', { 'for': 'json' }

  Plug 'https://github.com/fatih/vim-go', { 'for': 'go', 'do': 'nvim +GoInstallBinaries +qall' }

  Plug 'https://github.com/Olical/conjure', { 'for': 'clojure' }
  Plug 'https://github.com/guns/vim-sexp', { 'for': 'clojure' }
  Plug 'https://github.com/tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }

  " Cannot pin to elixir only. Otherwise doesn't detect heex files and so on.
  Plug 'https://github.com/elixir-editors/vim-elixir', { 'for': ['elixir', 'eelixir'] }

  Plug 'https://github.com/preservim/vim-markdown', { 'for': 'markdown' }

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
" Enable italic
hi htmlArg    cterm=italic
hi htmlItalic cterm=italic
hi Comment    cterm=italic
hi Type       cterm=italic


"
" Basics
"

" Show replacement incrementally in NeoVim
set inccommand=nosplit


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

set spellfile=~/.vimspell.add


augroup filetypedetect
  au BufNewFile,BufRead *.babelrc setfiletype json
  au BufNewFile,BufRead *.eslintrc setfiletype json
  au BufNewFile,BufRead Dockerfile.* setfiletype dockerfile
  au BufNewFile,BufRead *.eex,*.heex,*.leex,*.sface,*.lexs set filetype=eelixir
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

" Automatically open quickfix /location list after quickfix ran
augroup quickfix
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd QuickFixCmdPost l*    lwindow
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
tnoremap <esc> <C-\><C-n>

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
nnoremap gtp :term<space>

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

" go search string
nnoremap gss :silent grep<space>
vnoremap gss "vy:silent grep "<C-R>v"<space>

" Git stuff

" git status
nnoremap gst :Git<CR>
vnoremap gst :Git<CR>

" gl: Go Log command
" puts a line or a visual selection into a log/print statement
" Support for: js, go, py, md
function! JsLog()
  nmap gl ^iconsole.log(<esc>lx$a);<esc>
  vmap gl cconsole.log(<esc>pa);<esc>
  nmap gjl ^iconsole.log(JSON.stringify(<esc>lxx$a, null, 2));<esc>
  vmap gjl cconsole.log(JSON.stringify(<esc>pa, null, 2));<esc>
endfunction
autocmd BufNewFile,BufRead *.js,*.jsx,*.ts :call JsLog()
function! GoLog()
  nmap gl ^ifmt.Println(<esc>lx$a)<esc>
  vmap gl cfmt.Println(<esc>lxpa)<esc>
endfunction
autocmd BufNewFile,BufRead *.go :call GoLog()
function! ElixirLog()
  nmap gl ^iIO.inspect(<esc>l$a)<esc>
  vmap gl cIO.inspect(<esc>pa)<esc>
endfunction
autocmd BufNewFile,BufRead *.ex,*.exs :call ElixirLog()

vnoremap < <gv
vnoremap > >gv


"
" Commands
"

command JSONFormat :%!jq '.'

" Expanding links allows me to better use git and file browser
command RC execute "e ".resolve(expand("~/.vimrc"))
command Todo execute "e ".resolve(expand("~/todo.md"))
command Biz execute "e ".resolve(expand("~/notes/biz/todo.md"))


"
" Plugin configuration
"

" LSP
let g:lsp_settings_filetype_elixir = ['elixir-ls', 'tailwindcss-intellisense']
let g:lsp_settings_filetype_eelixir = ['elixir-ls', 'html-languageserver', 'tailwindcss-intellisense']
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre * call execute('LspDocumentFormatSync')
endfunction
augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

" asynccomplete
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"

" Golang
" disable all linters as that is taken care of by coc.nvim
let g:go_diagnostics_enabled = 0
let g:go_metalinter_enabled = []
" don't jump to errors after metalinter is invoked
let g:go_jump_to_error = 0
" run go imports on file save
let g:go_fmt_command = "goimports"
" automatically highlight variable your cursor is on
let g:go_auto_sameids = 0
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_generate_tags = 1

" TypeScript
let g:typescript_compiler_binary = 'tsc'
let g:typescript_compiler_options = ''


" JSON
let g:vim_json_syntax_conceal = 0


" Fugitive
set diffopt=filler,vertical


augroup clojure_bindings
  autocmd!
  autocmd FileType clojure nmap <buffer> cro :Eval<CR>:Eval (do (in-ns 'dev.reload) (reload-browser))<CR>
augroup end

" Markdown
set conceallevel=2
let g:vim_markdown_frontmatter = 1
augroup markdown_bindings
  autocmd!
  autocmd FileType markdown setlocal spell
augroup end

lua << EOF

vim.cmd[[colorscheme nord]]
--require('lualine').setup {
  --options = {
    --theme = 'nord'
  --}
--}

vim.g.mapleader = ","

require("icon-picker").setup({ disable_legacy_commands = true })
vim.keymap.set("n", "ge", "<cmd>IconPickerNormal emoji<cr>", { noremap = true, silent = true })

require("flatten").setup({
  -- your config
})

require("nvim-autopairs").setup {}

local wilder = require('wilder')
wilder.setup({modes = {':', '/', '?'}})
wilder.set_option('pipeline', {
  wilder.branch(
    wilder.cmdline_pipeline({
      fuzzy = 1,
      set_pcre2_pattern = 1,
    }),
    wilder.python_search_pipeline({
      pattern = 'fuzzy',
    })
  ),
})
local highlighters = {
  wilder.pcre2_highlighter(),
  wilder.basic_highlighter(),
}
wilder.set_option('renderer', wilder.popupmenu_renderer(
  wilder.popupmenu_border_theme({
    highlighter = highlighters,
    highlights = {
      border = 'Normal', -- highlight to use for the border
    },
    -- 'single', 'double', 'rounded' or 'solid'
    -- can also be a list of 8 characters, see :h wilder#popupmenu_border_theme() for more details
    border = 'rounded',
  })
))

EOF

" TODO: Give nvim lua things a try
" https://github.com/elixir-tools/elixir-tools.nvim
" better fzf https://github.com/nvim-telescope/telescope.nvim
" package manager https://github.com/folke/lazy.nvim
" install LSP and other tools https://github.com/williamboman/mason.nvim
" config built-in LSP https://github.com/neovim/nvim-lspconfig
" improve LSP https://github.com/nvimdev/lspsaga.nvim
" completion https://github.com/ms-jpq/coq_nvim or https://github.com/hrsh7th/nvim-cmp
" copilot in lua https://github.com/zbirenbaum/copilot.lua (more efficient than vimscript)
" better highlighting https://github.com/nvim-treesitter/nvim-treesitter
" lua version of surround https://github.com/kylechui/nvim-surround
" history manager https://github.com/AckslD/nvim-neoclip.lua
" statusline https://github.com/nvim-lualine/lualine.nvim
" icons in UI https://github.com/nvim-tree/nvim-web-devicons
" open files in current nvim https://github.com/willothy/flatten.nvim
" magit inspired git interface https://github.com/NeogitOrg/neogit
" git integration https://github.com/lewis6991/gitsigns.nvim
" fast motions https://github.com/ggandor/leap.nvim
" commenting https://github.com/numToStr/Comment.nvim
