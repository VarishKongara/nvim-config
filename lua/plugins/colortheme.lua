return {
  -- 'shaunsingh/nord.nvim',
  -- lazy = false,
  -- priority = 1000,
  -- config = function()
  --   -- Example config in lua
  --   vim.g.nord_contrast = true
  --   vim.g.nord_borders = false
  --   vim.g.nord_disable_background = true
  --   vim.g.nord_italic = false
  --   vim.g.nord_uniform_diff_background = true
  --   vim.g.nord_bold = false
  --
  --   -- Load the colorscheme
  --   require('nord').set()
  --
  --   -- Toggle background transparency
  --   local bg_transparent = true
  --
  --   local toggle_transparency = function()
  --     bg_transparent = not bg_transparent
  --     vim.g.nord_disable_background = bg_transparent
  --     vim.cmd [[colorscheme nord]]
  --   end
  --
  --   vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
  -- end,
  'EdenEast/nightfox.nvim', -- Nightfox theme plugin
  lazy = false, -- Load immediately
  priority = 1000, -- High priority to ensure it's loaded first
  config = function()
    -- You can customize some Nightfox settings here (optional)
    require('nightfox').setup {
      options = {
        styles = {
          comments = 'italic', -- comments are italic
        },
      },
    }

    -- set theme
    local theme = 'duskfox'
    vim.cmd('colorscheme ' .. theme)

    -- Toggle Transparency
    local bg_transparent = false
    local toggle_transparency = function()
      bg_transparent = not bg_transparent
      vim.g.nightfox_transparent = bg_transparent
      vim.cmd('colorscheme ' .. theme)
    end

    vim.keymap.set('n', '<leader>bg', toggle_transparency, { noremap = true, silent = true })
  end,
}
