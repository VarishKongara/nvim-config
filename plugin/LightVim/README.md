# LightVim

Built for users who want Omarchy-style theme loading without needing the full [LazyVim](https://github.com/LazyVim/LazyVim) setup.

Works alongside [Omarchy Themer](https://github.com/nedpranson/omarchy-themer) — see its documentation for theme linking and usage.

# Quickstart

First clone this repository to any directory:

```sh
git clone https://github.com/nedpranson/LightVim.git ~/.local/share/nvim/LightVim
```

Then you can update `omarchy-themer` plugin specification:

```lua
return {
  "nedpranson/omarchy-themer",
  dependencies = {
    { dir = "~/.local/share/nvim/LightVim", name = "LazyVim" },
  },
  -- rest of plugin spec...
```
