return {
  'nedpranson/omarchy-themer',
  dependencies = {
    { dir = '~/.config/nvim/plugin/LightVim', name = 'LazyVim' },
  },
  opts = {
    -- path to linked theme module
    -- see 'Linking Omarchy Themes' section for more details
    theme_module = 'plugins.theme',

    -- optional post-processing hook
    -- transparency example shown below in 'Post Processing'
    theme_changed = function()
      ApplyTransparency()
    end,
  },
}
