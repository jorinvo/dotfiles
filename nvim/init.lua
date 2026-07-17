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
  { "catppuccin/nvim",       name = "catppuccin" },

  -- Navigation
  { "tpope/vim-vinegar" },
  { "tpope/vim-rsi" },
  { "google/vim-searchindex" },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },

  -- Git
  { "tpope/vim-fugitive" },
  { "tpope/vim-rhubarb" },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add          = { text = "┃" },
        change       = { text = "┃" },
        delete       = { text = "_" },
        topdelete    = { text = "‾" },
        changedelete = { text = "~" },
        untracked    = { text = "┆" },
      },
      current_line_blame = true,
      current_line_blame_opts = {
        delay = 500,
        virt_text_pos = "eol",
      },
      on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end
          vim.schedule(function()
            gitsigns.nav_hunk("next")
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Next git hunk" })

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end
          vim.schedule(function()
            gitsigns.nav_hunk("prev")
          end)
          return "<Ignore>"
        end, { expr = true, desc = "Previous git hunk" })
      end,
    },
  },

  -- Shortcuts
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
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
    event = { "BufReadPost", "BufNewFile" }, -- Lazy load on buffer open
    config = function()
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
  { "preservim/vim-markdown", ft = "markdown" },
})

-- Theme
vim.cmd.colorscheme "catppuccin-nvim"

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

-- Telescope
local telescope_ok, telescope = pcall(require, "telescope.builtin")

-- Combined buffers + files picker (buffers first, including terminals)
-- Define outside the if so it's available for netrw autocmd
local buffers_and_files = function()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  local entry_display = require("telescope.pickers.entry_display")

  -- Get ALL buffers including terminals, sorted by last used
  local bufnrs = vim.tbl_filter(function(b)
    return vim.api.nvim_buf_is_loaded(b)
  end, vim.api.nvim_list_bufs())

  -- Sort by last used (most recent first)
  table.sort(bufnrs, function(a, b)
    return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
  end)

  -- Build buffer entries
  local results = {}
  local buffer_paths = {}

  for _, bufnr in ipairs(bufnrs) do
    local info = vim.fn.getbufinfo(bufnr)[1]
    local name = info.name
    local buftype = vim.bo[bufnr].buftype

    local display_name
    if buftype == "terminal" then
      -- Terminal buffer
      display_name = "term://" .. (name:match("term://.*:(%d+)") or name)
      table.insert(results, {
        bufnr = bufnr,
        display = "● " .. display_name,
        ordinal = "0" .. display_name,
        is_buffer = true,
        is_terminal = true,
      })
    elseif name ~= "" then
      -- Regular file buffer
      local path = vim.fn.fnamemodify(name, ":.")
      buffer_paths[path] = true
      table.insert(results, {
        bufnr = bufnr,
        path = path,
        display = "● " .. path,
        ordinal = "0" .. path,
        is_buffer = true,
        is_terminal = false,
      })
    end
  end

  -- Add all files (excluding ones already in buffers)
  local files = vim.fn.systemlist({ "rg", "--files", "--hidden", "--glob", "!.git/*" })
  for _, file in ipairs(files) do
    if not buffer_paths[file] then
      table.insert(results, {
        path = file,
        display = "  " .. file,
        ordinal = "1" .. file, -- Sort after buffers
        is_buffer = false,
        is_terminal = false,
      })
    end
  end

  pickers.new({}, {
    prompt_title = "Buffers & Files",
    finder = finders.new_table({
      results = results,
      entry_maker = function(entry)
        return {
          value = entry.path or tostring(entry.bufnr),
          display = entry.display,
          ordinal = entry.ordinal,
          filename = entry.path, -- nil for terminals, which disables preview
          bufnr = entry.bufnr,
          is_terminal = entry.is_terminal,
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    previewer = false,
    attach_mappings = function(prompt_bufnr, map)
      local actions = require("telescope.actions")
      local action_state = require("telescope.actions.state")

      actions.select_default:replace(function()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)

        if selection.is_terminal then
          -- Jump to terminal buffer
          vim.cmd("buffer " .. selection.bufnr)
        elseif selection.bufnr then
          -- Jump to existing buffer (non-terminal)
          vim.cmd("buffer " .. selection.bufnr)
        elseif selection.filename then
          -- Open file
          vim.cmd("edit " .. vim.fn.fnameescape(selection.filename))
        end
      end)

      return true
    end,
  }):find()
end

if telescope_ok then
  -- Your shortcuts
  keymap("n", "gp", buffers_and_files, { desc = "Find buffers & files" })
  keymap("n", "gb", telescope.buffers, { desc = "List buffers only" })

  -- New powerful shortcuts
  keymap("n", "gf", telescope.live_grep, { desc = "Live grep in project" })
  keymap("n", "gw", telescope.grep_string, { desc = "Grep word under cursor" })
  keymap("n", "gh", telescope.help_tags, { desc = "Search help" })
  keymap("n", "go", telescope.oldfiles, { desc = "Recent files" })
  keymap("n", "gc", telescope.commands, { desc = "Search commands" })
  keymap("n", "gk", telescope.keymaps, { desc = "Search keymaps" })
  keymap("n", "gm", telescope.marks, { desc = "List marks" })
  keymap("n", "gq", telescope.quickfix, { desc = "Quickfix list" })

  -- Git shortcuts (enhance your existing git workflow)
  keymap("n", "gsc", telescope.git_commits, { desc = "Git commits" })
  keymap("n", "gsb", telescope.git_branches, { desc = "Git branches" })
  keymap("n", "gsf", telescope.git_status, { desc = "Git status" })

  -- LSP shortcuts (super useful with your LSP setup)
  keymap("n", "gld", telescope.lsp_definitions, { desc = "LSP definitions" })
  keymap("n", "glr", telescope.lsp_references, { desc = "LSP references" })
  keymap("n", "gli", telescope.lsp_implementations, { desc = "LSP implementations" })
  keymap("n", "glt", telescope.lsp_type_definitions, { desc = "LSP type definitions" })
  keymap("n", "gls", telescope.lsp_document_symbols, { desc = "LSP document symbols" })
  keymap("n", "glw", telescope.lsp_workspace_symbols, { desc = "LSP workspace symbols" })
  keymap("n", "gle", telescope.diagnostics, { desc = "LSP diagnostics" })

  -- Resume last picker (very handy)
  keymap("n", "g.", telescope.resume, { desc = "Resume last picker" })
end

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

-- Override netrw's gp mapping to use telescope
autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    -- Override gp in netrw buffers to use our telescope picker
    vim.keymap.set("n", "gp", buffers_and_files, { buffer = true, desc = "Find buffers & files" })
  end,
})

-- Plugin configs

-- Telescope
local telescope_config_ok, telescope_config = pcall(require, "telescope")
if telescope_config_ok then
  telescope_config.setup({
    defaults = {
      previewer = false,
      -- Better sorting and filtering
      file_ignore_patterns = { "node_modules", ".git/", "dist/", "build/" },
      -- Use layout that matches your workflow
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          preview_width = 0.55,
          results_width = 0.8,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      -- Better visual appearance
      borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
      -- Use vim syntax instead of treesitter for previews to avoid lazy-load errors
      preview = {
        treesitter = false,
      },
      -- Mappings inside telescope
      mappings = {
        i = {
          -- Close with single ESC
          ["<esc>"] = require("telescope.actions").close,
          -- Better navigation
          ["<C-j>"] = require("telescope.actions").move_selection_next,
          ["<C-k>"] = require("telescope.actions").move_selection_previous,
          -- Send to quickfix
          ["<C-q>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
        },
        n = {
          ["<C-q>"] = require("telescope.actions").send_to_qflist + require("telescope.actions").open_qflist,
        },
      },
    },
    pickers = {
      find_files = {
        hidden = true, -- Show hidden files
        find_command = { "rg", "--files", "--hidden", "--glob", "!.git/*" },
      },
      buffers = {
        sort_lastused = true,
        mappings = {
          i = {
            -- Delete buffer with C-d
            ["<C-d>"] = require("telescope.actions").delete_buffer,
          },
          n = {
            ["<C-d>"] = require("telescope.actions").delete_buffer,
          },
        },
      },
      live_grep = {
        additional_args = function()
          return { "--hidden", "--glob", "!.git/*" }
        end,
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })

  -- Load fzf native extension for better performance
  pcall(telescope_config.load_extension, "fzf")
end

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
