# Netrw Override: `gp` for Telescope

## What Changed

By default, `gp` in netrw (vim's file browser) changes permissions. We've overridden this to use your Telescope picker instead.

## Why This Is Better

Now you have **consistent navigation** everywhere:
- Normal buffers: `gp` → Telescope buffers & files
- Netrw (file browser): `gp` → Telescope buffers & files  
- Terminal: `gp` → Telescope buffers & files

## Usage in Netrw

```bash
# Open netrw (file browser)
:Explore
# or just
-

# Now press gp
gp  → Opens Telescope picker

# Find any file
Type to search → <CR> to open

# Exit netrw
<CR> on a file or press gp
```

## Why Override This?

**Original `gp` in netrw:** Change file permissions (rarely used)
**New `gp` in netrw:** Search files with Telescope (super useful!)

You probably never used `gp` for permissions anyway, and if you need to change permissions, you can:
- Use shell: `!chmod ...`
- Use netrw's menu: press `m` then `p`

## Muscle Memory Benefits

Now `gp` is **universal**:
- Editing a file? `gp` → find files
- In netrw? `gp` → find files
- In terminal buffer? `gp` → find files

One shortcut, works everywhere!

## If You Want the Old Behavior

If you actually use netrw's permission change feature, remove lines from `init.lua`:

```lua
-- Remove or comment out this section:
autocmd("FileType", {
  pattern = "netrw",
  callback = function()
    vim.keymap.set("n", "gp", buffers_and_files, { buffer = true, desc = "Find buffers & files" })
  end,
})
```

## Other Netrw Shortcuts Still Work

All your netrw shortcuts remain:
- `-` to open netrw
- `<CR>` to open file/directory
- `-` to go up a directory
- `%` to create new file
- `d` to create directory
- `D` to delete

Only `gp` is changed!
