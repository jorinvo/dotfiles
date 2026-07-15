# Combined Buffers & Files Picker

## Overview

Your `gp` command now shows **both buffers and files** in a single picker!

## How It Works

When you press `gp`, you'll see:

```
Buffers & Files
──────────────────────────────────────────
> ● nvim/init.lua                    ← Most recently used buffer
  ● term://zsh:12345                 ← Terminal buffer
  ● README.md                        ← Open buffer
  ● alacritty.toml                   ← Open buffer
    package.json                     ← File (not open)
    src/main.js                      ← File (not open)
    src/utils.js                     ← File (not open)
    .gitignore                       ← File (not open)
```

## Key Features

### 1. Buffers First (By Recency)
- Open buffers appear at the top
- **Sorted by last used** - most recent buffer is first
- Includes terminal buffers (shown as `term://...`)
- Marked with `●` so you can easily spot them
- Regular files appear below (alphabetically)

### 2. All Files Included
- Every file in your project is searchable
- Uses ripgrep for fast searching
- Includes hidden files (like `.env`)

### 3. Fuzzy Search Works on Both
Type to filter:
- `init` → finds `● nvim/init.lua` (buffer) and `init.sql` (file)
- `read` → finds `● README.md` (buffer) and `reader.js` (file)

## Common Workflows

### Quick Buffer Switch
```
gp → start typing filename → <CR> to jump
```
Even though files are shown, buffers appear first, so you'll likely hit a buffer first.

### Open New File While Keeping Buffer Context
```
gp → see your open buffers at top
   → type to find new file
   → <CR> to open it
```

### See What's Open vs What Exists
The `●` marker lets you quickly see what you already have open versus what you need to open.

## Comparison

| Command | Shows | Use When |
|---------|-------|----------|
| `gp` | Buffers (marked) + All files | Default - best of both worlds |
| `gb` | Only open buffers | Want to focus only on what's open |
| `go` | Recently opened files | Want to reopen something you closed |

## Alternatives if You Want Different Behavior

If you prefer separate commands:

### Option 1: Buffers First, Then Files (Current)
```lua
gp → buffers & files (buffers at top with ●)
gb → buffers only
```

### Option 2: Keep Them Separate
If you want `gp` to be **only files** (no buffers), change line ~316:
```lua
keymap("n", "gp", telescope.find_files, { desc = "Find files only" })
keymap("n", "gb", telescope.buffers, { desc = "List buffers" })
```

### Option 3: Smart Toggle
Press `gp` for files, `<C-b>` inside picker to add buffers.

## Why This Is Better Than FZF

With FZF, you had to choose:
- `:Files` → only files
- `:Buffers` → only buffers

Now with `gp`:
- See both in one view
- Buffers prioritized (what you likely want)
- Still filter across everything
- Visual marker shows what's open

## Tips

1. **Quick buffer jump**: `gp` → type partial filename → `<CR>`
2. **Visual scan**: `gp` → see all open buffers at top before searching
3. **Context aware**: See if a file is already open (●) before opening again
4. **Keep `gb` for focus**: Use `gb` when you only want to see open buffers

## Performance

- ✅ Fast: Uses ripgrep for file listing
- ✅ Efficient: Buffer check is instant (in-memory)
- ✅ Scales: Works great with large projects
- ✅ No lag: Fuzzy matching is native (fzf-native extension)
