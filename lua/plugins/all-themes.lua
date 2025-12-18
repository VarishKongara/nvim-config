return {
  -- Load all theme plugins but don't apply them
  -- This ensures all colorschemes are available for hot-reloading
  {
    'ribru17/bamboo.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'bjarneo/aether.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'bjarneo/ethereal.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'bjarneo/hackerman.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = true,
    priority = 1000,
  },
  {
    'sainnhe/everforest',
    lazy = true,
    priority = 1000,
  },
  {
    'kepano/flexoki-neovim',
    lazy = true,
    priority = 1000,
  },
  {
    'ellisonleao/gruvbox.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'tahayvr/matteblack.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'loctvl842/monokai-pro.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'shaunsingh/nord.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = true,
    priority = 1000,
  },
  {
    'folke/tokyonight.nvim',
    lazy = true,
    priority = 1000,
  },
  {
    'EdenEast/nightfox.nvim', -- Nightfox theme plugin
    lazy = true, -- Load immediately
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
  },
}
