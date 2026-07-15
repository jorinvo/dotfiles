# Telescope Troubleshooting

## Fixed Issues

### ✅ Treesitter Preview Error
**Error:** `attempt to call field 'ft_to_lang' (a nil value)`

**Cause:** Telescope tries to use Treesitter for syntax highlighting in previews, but Treesitter was being lazy-loaded only on buffer open.

**Solution:** Disabled Treesitter in Telescope previews with `preview = { treesitter = false }`. Telescope now uses regular vim syntax highlighting for previews.

**Result:** 
- No more errors
- Treesitter stays lazy-loaded (performance preserved)
- Previews still have syntax highlighting (via vim)
- When you open files, Treesitter gives you better highlighting in actual buffers

**Trade-off:** Previews use vim syntax (good) instead of Treesitter syntax (slightly better). This is worth it to keep lazy-loading benefits.

## Common Issues

### Slow First Open
**Symptom:** First time you use `gp` takes a moment

**Why:** Telescope + Treesitter + fzf-native are loading together on first use

**Solution:** This is normal! Subsequent uses are instant. This is actually faster than loading everything at startup.

### fzf-native Build Failed
**Symptom:** Warning about fzf-native during plugin install

**Check:** Do you have `make` and a C compiler installed?

**Fix:**
```bash
# On Manjaro/Arch
sudo pacman -S base-devel

# Then in nvim
:Lazy build telescope-fzf-native.nvim
```

**Impact:** If it fails, Telescope still works, just slightly slower sorting.

### No Syntax Highlighting in Previews
**Symptom:** Files show in preview but no colors

**Check:** Is Treesitter installed for that file type?

**Fix:** In nvim, run `:TSInstall <language>` (e.g., `:TSInstall typescript`)

### Hidden Files Not Showing
**Symptom:** Dotfiles don't appear in `gp`

**Check:** You have ripgrep installed?

**Verify:** `which rg` should show `/usr/bin/rg`

**If missing:**
```bash
sudo pacman -S ripgrep
```

## Performance

Your config is optimized for:
- ✅ Lazy loading (plugins load when needed)
- ✅ Treesitter limited to specific languages
- ✅ Large file handling (skips treesitter for files >100KB)
- ✅ Reduced diagnostic updates
- ✅ Debounced LSP and completion

First `gp`/`gb` loads Telescope + Treesitter, then everything is instant!

## Validation

Test that everything works:

```vim
" Basic functionality
gp          " Should open without errors
gb          " Should show buffers with syntax highlighting
gf          " Should search with live results

" Check health
:checkhealth telescope
:checkhealth treesitter

" Verify extensions loaded
:Telescope
```

## Still Having Issues?

1. **Check Lazy status:** `:Lazy` - ensure all plugins show green checkmarks
2. **Update plugins:** `:Lazy sync`
3. **Rebuild native extensions:** `:Lazy build telescope-fzf-native.nvim`
4. **Check logs:** `:messages`
5. **Health check:** `:checkhealth telescope`
