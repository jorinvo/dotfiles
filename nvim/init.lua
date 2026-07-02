vim.g.mapleader = ","

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
  -- Theme
  { "shaunsingh/nord.nvim" },

  -- Navigation
  { "tpope/vim-vinegar" },
  { "tpope/vim-rsi" },
  { "google/vim-searchindex" },
  {
    "junegunn/fzf",
    build = "./install --all",
    dir = "~/.fzf",
  },
  { "junegunn/fzf.vim" },

  -- Git
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  { "airblade/vim-gitgutter" },

  -- Shortcuts
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },
  { "tpope/vim-unimpaired" },

  -- Text objects
  { "michaeljsmith/vim-indent-object" },
  { "wellle/targets.vim" },
  { "kana/vim-textobj-user" },
  { "kana/vim-textobj-entire",        dependencies = { "kana/vim-textobj-user" } },
  { "kana/vim-textobj-line",          dependencies = { "kana/vim-textobj-user" } },

  -- Misc
  { "nelstrom/vim-visual-star-search" },
  { "willothy/flatten.nvim",          opts = {} },
  { "windwp/nvim-autopairs",          opts = {} },

  -- Modern LSP setup
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  -- Treesitter (only enable for languages you use)
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" }, -- Lazy load
    config = function()
      -- Defer to avoid blocking startup
      vim.defer_fn(function()
        local ok, configs = pcall(require, "nvim-treesitter.configs")
        if not ok then
          return
        end
        configs.setup({
          -- Only install parsers you actually use to save memory/CPU
          ensure_installed = {
            "javascript", "typescript", "tsx",
            "go", "python", "markdown", "json",
            "lua",
          },
          auto_install = false, -- Don't auto-install to save battery
          highlight = {
            enable = true,
            -- Disable for large files to save CPU
            disable = function(lang, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                return true
              end
            end,
          },
          indent = { enable = true },
        })
      end, 0)
    end,
  },

  -- Language-specific plugins (lazy loaded)
  { "pangloss/vim-javascript",     ft = "javascript" },
  { "leafgarland/typescript-vim",  ft = { "typescript", "typescriptreact" } },
  { "peitalin/vim-jsx-typescript", ft = "typescriptreact" },
  { "moll/vim-node",               ft = { "javascript", "typescript", "typescriptreact" } },
  { "wuelnerdotexe/vim-astro",     ft = "astro" },
  { "elzr/vim-json",               ft = "json" },
  {
    "fatih/vim-go",
    ft = "go",
    build = ":GoInstallBinaries",
  },
  { "preservim/vim-markdown",                     ft = "markdown" },
})

-- Theme
vim.cmd([[colorscheme nord]])
vim.cmd([[set background=dark]])

-- Enable syntax highlighting with italics
vim.cmd([[
  syntax on
  hi htmlArg    cterm=italic
  hi htmlItalic cterm=italic
  hi Comment    cterm=italic
  hi Type       cterm=italic
]])

-- Basic settings
vim.opt.inccommand = "nosplit"
vim.opt.statusline = " %y%w%r %f %m%=%l/%L |%3.c "
vim.opt.clipboard = "unnamed"
vim.opt.lazyredraw = true
vim.opt.gdefault = true
vim.opt.binary = true
vim.opt.eol = false
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.errorbells = false
vim.opt.startofline = false
vim.opt.title = true
vim.opt.hidden = true
vim.opt.foldenable = false

-- Indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.smarttab = true

-- Timeouts
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100

-- UI
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.wildmenu = true
vim.opt.number = false

-- No swap/backup files
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

vim.opt.fileformats:append("mac")
vim.opt.history = 10000
vim.opt.sessionoptions:remove("options")

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Undo
vim.opt.undofile = true
vim.opt.undodir = vim.fn.expand("~/.config/nvim/undo")

vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 5
vim.opt.display:append("lastline")
vim.opt.listchars = { tab = "→ ", nbsp = "␣", trail = "·" }
vim.opt.formatoptions:append("j")
vim.opt.spellfile = vim.fn.expand("~/.vimspell.add")

-- Filetype detection
vim.filetype.add({
  extension = {
    babelrc = "json",
    eslintrc = "json",
  },
  pattern = {
    ["Dockerfile.*"] = "dockerfile",
    [".*%.eex"] = "eelixir",
    [".*%.heex"] = "eelixir",
    [".*%.leex"] = "eelixir",
    [".*%.sface"] = "eelixir",
    [".*%.lexs"] = "eelixir",
  },
})

-- Auto-commands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Strip trailing whitespace on save
autocmd("BufWritePre", {
  group = augroup("strip_whitespace", { clear = true }),
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".")
    vim.cmd([[%s/\s\+$//e]])
    vim.fn.setpos(".", save_cursor)
  end,
})

-- Restore cursor position
autocmd("BufReadPost", {
  group = augroup("restore_cursor", { clear = true }),
  pattern = "*",
  callback = function()
    local line = vim.fn.line("'\"")
    if line > 1 and line <= vim.fn.line("$") then
      vim.cmd('normal! g`"')
    end
  end,
})

-- Auto-open quickfix/location list
autocmd("QuickFixCmdPost", {
  group = augroup("quickfix_auto", { clear = true }),
  pattern = "[^l]*",
  command = "cwindow",
})
autocmd("QuickFixCmdPost", {
  group = augroup("quickfix_auto", {}),
  pattern = "l*",
  command = "lwindow",
})

-- Keymaps
local keymap = vim.keymap.set

-- Terminal escape
keymap("t", "<esc>", "<C-\\><C-n>")

-- Command line history
keymap("c", "<C-p>", "<Up>")
keymap("c", "<C-n>", "<Down>")

-- Dot command in visual mode
keymap("v", ".", ":norm.<CR>")

-- System clipboard
keymap("n", "'", '"+')
keymap("v", "'", '"+')

-- Y behaves like D and C
keymap("n", "Y", "y$")

-- Jump to first character or column
keymap("n", "0", function()
  local current_col = vim.fn.virtcol(".")
  vim.cmd("normal! ^")
  local first_char = vim.fn.virtcol(".")
  if current_col == first_char then
    vim.cmd("normal! 0")
  end
end, { silent = true })

-- Window movement
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-l>", "<C-w>l")

-- Quit window
keymap("n", "Q", "<C-w>c")

-- Semicolon as colon
keymap("n", ";", ":")

-- Terminal
keymap("n", "gtt", ":term<CR>i")
keymap("n", "gtp", ":term ")

-- Save and clear search highlight
keymap("n", "<space>", ":nohlsearch <bar> w<CR>")

-- Registers
keymap("n", '""', ':registers "0123456789abcdefghijklmnopqrstuvwxyz*+.<CR>', { silent = true })

-- Switch to last file
keymap("n", "<tab>", "<c-^>")

-- FZF
keymap("n", "gb", ":Buffers<CR>")
keymap("n", "gp", ":Files<CR>")

-- Grep
if vim.fn.executable("rg") == 1 then
  vim.opt.grepprg = "rg --vimgrep"
  vim.opt.grepformat = "%f:%l:%c:%m"
elseif vim.fn.executable("ag") == 1 then
  vim.opt.grepprg = "ag --vimgrep"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
elseif vim.fn.executable("ack") == 1 then
  vim.opt.grepprg = "ack --nogroup --nocolor --ignore-case --column"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
end

keymap("n", "gss", ":silent grep ")
keymap("v", "gss", '"vy:silent grep "<C-R>v" ')

-- Git
keymap("n", "gst", ":Git<CR>")
keymap("v", "gst", ":Git<CR>")

-- Indent in visual mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Open URL
if vim.fn.executable("xdg-open") == 1 then
  keymap("n", "gx", ":silent !xdg-open <cWORD><CR>", { silent = true })
elseif vim.fn.executable("open") == 1 then
  keymap("n", "gx", ":silent !open <cWORD><CR>", { silent = true })
end

-- Commands
vim.api.nvim_create_user_command("JSONFormat", "%!jq '.'", {})
vim.api.nvim_create_user_command("RC", function()
  vim.cmd("e " .. vim.fn.resolve(vim.fn.expand("~/.config/nvim/init.lua")))
end, {})
vim.api.nvim_create_user_command("Todo", function()
  vim.cmd("e " .. vim.fn.resolve(vim.fn.expand("~/todo.md")))
end, {})

-- Log shortcuts for different languages
local function setup_js_log()
  keymap("n", "gl", "^iconsole.log(<esc>l$a);<esc>==", { buffer = true })
  keymap("v", "gl", "cconsole.log(<esc>pa);<esc>", { buffer = true })
  keymap("n", "gjl", "^iconsole.log(JSON.stringify(<esc>lxx$a, null, 2));<esc>", { buffer = true })
  keymap("v", "gjl", "cconsole.log(JSON.stringify(<esc>pa, null, 2));<esc>", { buffer = true })
end

local function setup_go_log()
  keymap("n", "gl", "^ifmt.Println(<esc>l$a)<esc>==", { buffer = true })
  keymap("v", "gl", "cfmt.Println(<esc>pa)<esc>", { buffer = true })
end

local function setup_python_log()
  keymap("n", "gl", "^iprint(<esc>l$a)<esc>==", { buffer = true })
  keymap("v", "gl", "cprint(<esc>pa)<esc>", { buffer = true })
end

autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = setup_js_log,
})
autocmd("FileType", { pattern = "go", callback = setup_go_log })
autocmd("FileType", { pattern = "python", callback = setup_python_log })

-- Plugin configs

-- Golang (vim-go)
vim.g.go_diagnostics_enabled = 0
vim.g.go_metalinter_enabled = {}
vim.g.go_jump_to_error = 0
vim.g.go_fmt_command = "goimports"
vim.g.go_auto_sameids = 0
vim.g.go_highlight_types = 1
vim.g.go_highlight_fields = 1
vim.g.go_highlight_functions = 1
vim.g.go_highlight_function_calls = 1
vim.g.go_highlight_operators = 1
vim.g.go_highlight_extra_types = 1
vim.g.go_highlight_build_constraints = 1
vim.g.go_highlight_generate_tags = 1

-- TypeScript
vim.g.typescript_compiler_binary = "tsc"
vim.g.typescript_compiler_options = ""

-- JSON
vim.g.vim_json_syntax_conceal = 0

-- Fugitive
vim.opt.diffopt = { "filler", "vertical" }

-- Markdown
vim.opt.conceallevel = 2
vim.g.vim_markdown_frontmatter = 1
autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.opt_local.spell = true
  end,
})

-- Astro
vim.g.astro_typescript = "enable"

-- Mason setup (LSP installer)
require("mason").setup({
  ui = {
    border = "rounded",
  },
})

require("mason-lspconfig").setup({
  -- Only install what you need - saves disk space and memory
  ensure_installed = {
    "ts_ls",    -- TypeScript/JavaScript
    "gopls",    -- Go
    "pyright",  -- Python
    "marksman", -- Markdown
    "lua_ls",   -- Lua
    -- "html",         -- HTML (only if you need)
    -- "cssls",        -- CSS (only if you need)
  },
  automatic_installation = false, -- Don't auto-install to save battery
})

-- Completion setup
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer", keyword_length = 3 }, -- Only trigger after 3 chars
    { name = "path" },
  }),
  -- Reduce completion frequency to save CPU
  performance = {
    debounce = 150, -- Wait 150ms before triggering (default: 60ms)
    throttle = 60,  -- Throttle to 60ms
    fetching_timeout = 200,
  },
})

-- LSP setup
local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local capabilities = ok_cmp and cmp_nvim_lsp.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

-- Reduce LSP overhead
vim.lsp.log.set_level(vim.log.levels.ERROR)

local on_attach = function(client, bufnr)
  local opts = { buffer = bufnr, silent = true }

  -- LSP keymaps
  keymap("n", "gd", vim.lsp.buf.definition, opts)
  keymap("n", "gr", vim.lsp.buf.references, opts)
  keymap("n", "gi", vim.lsp.buf.implementation, opts)
  keymap("n", "gt", vim.lsp.buf.type_definition, opts)
  keymap("n", "[g", vim.diagnostic.goto_prev, opts)
  keymap("n", "]g", vim.diagnostic.goto_next, opts)
  keymap("n", "K", vim.lsp.buf.hover, opts)

  -- Format on save
  if client.server_capabilities.documentFormattingProvider then
    autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr, timeout_ms = 1000 })
      end,
    })
  end
end

-- Configure LSP servers using modern vim.lsp.config API
local servers = {
  ts_ls = {},
  gopls = {},
  pyright = {},
  marksman = {},
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
}

-- Setup each LSP server with modern API (nvim 0.11+)
for server, config in pairs(servers) do
  local server_config = vim.tbl_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
    -- Reduce CPU usage
    flags = {
      debounce_text_changes = 150, -- Wait 150ms before sending changes
    },
  }, config)

  vim.lsp.config[server] = server_config
  vim.lsp.enable(server)
end

-- Diagnostic configuration (reduce visual noise and CPU)
vim.diagnostic.config({
  virtual_text = false,     -- Disable inline diagnostics to save rendering
  signs = true,
  update_in_insert = false, -- Don't update diagnostics while typing
  underline = true,
  severity_sort = true,
})
