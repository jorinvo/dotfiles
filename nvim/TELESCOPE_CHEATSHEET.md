# Telescope Quick Reference

## Your Main Shortcuts
| Key | Action | Details |
|-----|--------|---------|
| `gp` | Find buffers & files | Combined search (buffers marked with ●) |
| `gb` | List buffers only | Just open buffers |

## Essential New Shortcuts
| Key | Action | Why Use It |
|-----|--------|------------|
| `gf` | Live grep | Search text across project (interactive) |
| `gw` | Grep word under cursor | Instant search for symbol |
| `go` | Recent files | Quick access to recently opened |
| `g.` | Resume last picker | Reopen last telescope window |

## Inside Telescope
| Key | Action |
|-----|--------|
| `<Esc>` | Close |
| `<C-j>/<C-k>` | Move down/up |
| `<C-q>` | Send to quickfix |
| `<Tab>` | Select multiple |
| `<C-/>` | Show help |

## LSP (Code Navigation)
| Key | Action |
|-----|--------|
| `gle` | All diagnostics (errors/warnings) |
| `gld` | Definitions with preview |
| `glr` | All references |
| `gls` | Symbols in current file |
| `glw` | Search all symbols in workspace |

## Git Integration
| Key | Action |
|-----|--------|
| `gsf` | Git status with diff preview |
| `gsc` | Browse commit history |
| `gsb` | Switch branches |

## Common Workflows

### Find & Replace
```
gf → search text
<C-q> → to quickfix
:cdo s/old/new/g | update
```

### Debug Errors
```
gle → see all errors
<C-j>/<C-k> → navigate
<CR> → jump to fix
```

### Explore Codebase
```
glw → search symbols
Type partial name
Preview & jump
```

## Pro Tips
- Use `g.` to reopen last search
- `<C-q>` for batch operations
- LSP pickers show previews before jumping
- All searches include hidden files
