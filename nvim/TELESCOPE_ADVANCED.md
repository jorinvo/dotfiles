# Advanced Telescope Workflows

## Power User Patterns

### 1. Project-Wide Refactoring
```
1. gf (live grep) → search for pattern
2. <C-q> → send to quickfix
3. :cdo %s/old/new/gc | update → interactive replace across files
```

### 2. Code Archaeology
```
1. gsc → browse commit history with diff preview
2. Navigate commits, see full diffs
3. <CR> on commit → jump to that point in history
```

### 3. Debug Session
```
1. gle → see all diagnostics
2. <C-j>/<C-k> → preview each error
3. <CR> → jump to fix
4. g. → resume diagnostic list after fix
```

### 4. Symbol Navigation
```
1. glw → search workspace symbols (e.g., type "auth")
2. See all matching functions/types across project
3. Navigate with preview before committing to jump
```

### 5. Multi-File Editing
```
1. gp → find files
2. <Tab> → select multiple files
3. <C-q> → send to quickfix
4. :cfdo %s/pattern/replacement/g | update
```

### 6. Git Integration Workflow
```
# Branch switching with preview
gsb → see all branches → <CR> to switch

# Review changes before commit
gsf → preview all diffs → navigate staged/unstaged

# Find when bug introduced
gsc → browse history → see what changed when
```

## Custom Telescope Functions

Add these to your `init.lua` for even more power:

### Search in Git Root
```lua
keymap("n", "gpr", function()
  require("telescope.builtin").find_files({
    cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
  })
end, { desc = "Find files from git root" })
```

### Search Open Buffers Only
```lua
keymap("n", "gfb", function()
  require("telescope.builtin").live_grep({
    grep_open_files = true
  })
end, { desc = "Live grep in open buffers" })
```

### Search File History
```lua
keymap("n", "gsh", function()
  require("telescope.builtin").git_bcommits()
end, { desc = "Current file git history" })
```

## Telescope + Your Existing Tools

### With Fugitive
- Your `gst` (`:Git`) for staging
- `gsf` for preview before staging
- `gsc` for commit history

### With LSP
- Standard `gd` (LSP definition) for simple jumps
- `gld` (Telescope LSP) when you want to preview before jumping
- `glr` better than `gr` for seeing all references

### With Grep
- Your `gss` still works for simple grep
- `gf` (live grep) for interactive search with preview
- `gw` for instant search of current word

## Performance Tips

1. **Use specific pickers**: `gp` is faster than `gf` for finding files
2. **Narrow search first**: Type a few chars before waiting for results
3. **Use git files**: In git repos, telescope automatically uses `git ls-files` (fast!)
4. **Close when done**: `<Esc>` to free resources

## Customization Ideas

### Change Layout
```lua
-- Add to telescope setup defaults
layout_strategy = "vertical",  -- or "horizontal", "center"
```

### Show Hidden Files
Already configured! Your `gp` shows dotfiles.

### Custom File Ignores
```lua
-- In telescope defaults
file_ignore_patterns = {
  "node_modules",
  ".git/",
  "dist/",
  "build/",
  "*.pyc",  -- Add your patterns
}
```

## Combining with Vim Commands

### After Telescope Selection
```
gp → find file → <CR> to open
:vs → split
gp → find another → <CR> (opens in split)
```

### Build Dynamic Quickfix
```
gf → search pattern
<Tab> → select relevant results
<C-q> → send to quickfix
:cdo normal @q → run macro on all
```

## Telescope Extensions to Consider

### Already Included
- ✅ fzf-native (performance)

### Worth Adding Later
- `telescope-ui-select.nvim` - Better UI for vim.ui.select
- `telescope-file-browser.nvim` - File browser in telescope
- `telescope-live-grep-args.nvim` - Pass args to ripgrep

## Keybinding Philosophy

Your setup follows a pattern:
- `g*` prefix for "go to" actions
- `gl*` for LSP operations
- `gs*` for git operations

New additions follow this same pattern for consistency!

## Comparison with FZF

| Feature | FZF | Telescope |
|---------|-----|-----------|
| Speed | Very Fast | Fast (with fzf-native) |
| Preview | Basic | Rich (git diffs, LSP, etc) |
| LSP Integration | ❌ | ✅ |
| Git Integration | Basic | Advanced |
| Multi-select | ✅ | ✅ |
| Customization | Limited | Extensive |
| Native Lua | ❌ | ✅ |

## Real-World Examples

### "I need to update all API calls"
```
gf → search "apiCall"
<C-q> → quickfix
:cdo %s/apiCall/newApiCall/g | update
```

### "Which files import this module?"
```
gw (on import statement)
See all files with preview
<C-q> if you need to edit multiple
```

### "I broke something, find the commit"
```
gsc → browse commits
Preview diffs until you find the culprit
Note the commit hash
```

### "Navigate large file"
```
gls → document symbols
Type function name
Jump directly to it
```

## Muscle Memory Tips

- Replace `ctrl+p` mental model with `gp`
- Think "telescope = better preview" vs fzf
- Use `g.` when you close picker too early
- `<C-q>` is your friend for batch operations
