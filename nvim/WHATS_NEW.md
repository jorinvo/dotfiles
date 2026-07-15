# What's New: Combined Buffers & Files

## 🎉 New Feature

Your `gp` command now searches **both buffers AND files** at the same time!

## Quick Summary

```
BEFORE (FZF):
gp → :Files (only files)
gb → :Buffers (only buffers)

AFTER (Telescope):
gp → Buffers & Files (● markers show open buffers at top)
gb → Buffers only
```

## Visual Example

Press `gp` and you'll see:
```
> ● init.lua          ← Open buffer (has ● marker)
  ● README.md         ← Open buffer
    package.json      ← File (not open)
    src/main.js       ← File (not open)
```

## Why This Is Great

1. **One command does it all** - No need to switch between `gp` and `gb`
2. **Buffers prioritized** - Open files appear first (what you usually want)
3. **Visual feedback** - The `●` marker shows what's already open
4. **Still fast** - Fuzzy search works across everything
5. **Context aware** - See if a file is open before opening it again

## How to Use It

### Quick buffer switch
```
gp → type partial filename → <CR>
```

### Find any file
```
gp → type to filter all files → <CR>
```

### See what's open
```
gp → look at top entries with ●
```

## If You Want Different Behavior

The current setup (`gp` = buffers + files) is what most people prefer, but you have options:

### Keep them separate (like FZF)
Edit line ~316 in `init.lua`:
```lua
keymap("n", "gp", telescope.find_files, { desc = "Find files only" })
```

### Files only, buffers separate
This would make:
- `gp` → files only
- `gb` → buffers only

Just let me know if you want this changed!

## What Didn't Change

- `gb` still shows only buffers (if you want to focus on open files)
- All your other shortcuts (`gf`, `gw`, `gle`, etc.) work the same
- All the LSP and git integrations remain the same

## Try It Now

1. Open a few files in nvim
2. Press `gp`
3. You'll see your open buffers at the top with `●` markers
4. Type to filter across both buffers and all project files
5. Press `<CR>` to open

## Documentation

- `BUFFERS_AND_FILES.md` - Detailed guide
- `TELESCOPE_CHEATSHEET.md` - Updated quick reference
- `TELESCOPE_FEATURES.md` - Full feature list

Enjoy! 🚀
