# Telescope.nvim Migration Guide

## Your Main Shortcuts

- `gp` - **Find buffers & files** - Search through both open buffers and all project files
  - Open buffers are marked with `●` and sorted to the top
  - Great for quickly switching between what you have open and finding new files
- `gb` - **List buffers only** - Just your open buffers (like the old `:Buffers`)

## New Powerful Features

### File & Text Search
- `gf` - **Live grep** - Search text across entire project (interactive)
- `gw` - **Grep word under cursor** - Instantly search for word under cursor
- `go` - **Recent files** - Quick access to recently opened files
- `gq` - **Quickfix list** - Browse quickfix entries with preview

### Git Integration
- `gsc` - **Git commits** - Browse commit history with diff preview
- `gsb` - **Git branches** - Switch branches interactively
- `gsf` - **Git status** - See changed files (enhances your `gst`)

### LSP Integration (Super Useful!)
- `gld` - **LSP definitions** - Find definitions with preview
- `glr` - **LSP references** - Find all references to symbol
- `gli` - **LSP implementations** - Find implementations
- `glt` - **LSP type definitions** - Jump to type definitions
- `gls` - **Document symbols** - Navigate functions/classes in current file
- `glw` - **Workspace symbols** - Search symbols across entire project
- `gle` - **Diagnostics** - Browse all errors/warnings with preview

### Utilities
- `gh` - **Help tags** - Search vim help (way better than `:help`)
- `gc` - **Commands** - Search available commands
- `gk` - **Keymaps** - See all your keybindings
- `gm` - **Marks** - List all marks
- `g.` - **Resume** - Reopen last picker (very handy!)

## Inside Telescope Pickers

### Insert Mode
- `<Esc>` - Close picker
- `<C-j>/<C-k>` - Move down/up (matches your window navigation!)
- `<C-q>` - Send results to quickfix list
- `<C-d>` - Delete buffer (in buffer picker)
- `<Tab>` - Toggle selection (for multi-select)
- `<C-/>` - Show keybindings help

### Normal Mode
- `j/k` - Move down/up
- `<C-q>` - Send to quickfix
- `gg/G` - First/last entry

## Workflow Examples

### 1. Find & Replace Across Project
1. `gf` to live grep for text
2. `<C-q>` to send results to quickfix
3. `:cdo s/old/new/g | update` to replace in all files

### 2. Navigate Codebase
1. `gw` on a function name to see all usages
2. Navigate with `j/k` and preview
3. `<CR>` to jump to selected usage
4. `g.` to resume picker if needed

### 3. Git Workflow
1. `gsf` to see changed files with diff preview
2. `gsc` to browse commit history
3. `gsb` to switch branches

### 4. LSP Navigation
1. `glw` to search for any symbol in workspace
2. Type partial name, see matches with preview
3. `glr` to find all references to symbol under cursor
4. `gle` to see all diagnostics across project

### 5. Debug Workflow
1. Place cursor on error/warning
2. `gle` to see all diagnostics
3. Navigate and preview each one
4. Fix issues and repeat

## Performance Features

- **FZF native sorting** - Super fast fuzzy finding
- **Hidden file support** - See dotfiles with `gp`
- **Smart case** - Case-insensitive until you type uppercase
- **File ignore patterns** - Skips node_modules, .git, dist, build
- **Ripgrep integration** - Blazingly fast text search

## Tips

1. **Combine with your existing workflow**: Your `gst` (fugitive) + `gsf` (telescope git status) = powerful git workflow
2. **Use `g.` often**: Resume last search to continue where you left off
3. **LSP + Telescope**: Better than default LSP commands (preview before jumping!)
4. **Quickfix integration**: Use `<C-q>` to build quickfix lists for batch operations
5. **Preview everything**: All pickers show preview - no blind jumps

## Advantages Over FZF

1. **Native Lua** - Faster, better Neovim integration
2. **Rich previews** - See file contents, git diffs, help docs
3. **LSP integration** - Deep code intelligence
4. **Extensible** - Easy to customize and extend
5. **Multi-select** - Select multiple items with `<Tab>`
6. **Better sorting** - FZF native algorithm + smart ranking
