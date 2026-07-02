# Jorin’s dotfiles

***If you are looking for the MacOS specific files, they are still available at [this tag](https://github.com/jorinvo/dotfiles/tree/mac)***

## Usage

This a highly customized setup and no one should just copy it and use it as is.
Please take your time to pick what you need and change everything to your liking.

Run `./setup` to link dotfiles and install packages.
Can also be run to update dependencies.

The setup mostly links my dotfiles and sets up [neovim](https://neovim.io/)


## Requirements

- bash
- [neovim](https://neovim.io/) (v0.9+)
- git

## Neovim Setup

The config uses modern native LSP with these features:
- **lazy.nvim** - Fast plugin manager
- **nvim-lspconfig** - Native LSP (TypeScript, Go, Elixir, Lua, Markdown)
- **nvim-treesitter** - Better syntax highlighting
- **nvim-cmp** - Fast completion
- **mason.nvim** - LSP server installer

After running `./setup`, open nvim and run `:Mason` to install language servers.

Old vim-plug config is backed up in `vimrc.old-vim-plug`.


## Notes

Thanks to [Mathias](https://github.com/mathiasbynens/dotfiles) for inspiration!


__Licence *MIT*__
