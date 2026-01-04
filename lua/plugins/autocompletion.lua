return {
  'saghen/blink.cmp',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      build = function()
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end,
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },
  },
  version = '*',

  config = function()
    local blink = require 'blink.cmp'
    local cmpEnabled = true

    local function cmp_toggle()
      cmpEnabled = not cmpEnabled
      vim.diagnostic.enable(cmpEnabled)
    end
    vim.api.nvim_create_user_command('CmpToggle', function()
      cmp_toggle()
    end, {})

    blink.setup {
      sources = {
        default = function()
          if cmpEnabled then
            return { 'lsp', 'path', 'snippets', 'buffer' }
          end
          return {}
        end,
      },
      keymap = {
        preset = 'default',
        ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
        ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
        ['<C-y>'] = { 'select_and_accept' }, -- wrap in array
        ['<C-Space>'] = { 'show_and_insert_or_accept_single' },
        ['<C-f>'] = { 'scroll_documentation_down' },
        ['<C-b>'] = { 'scroll_documentation_up' },
      },
    }
  end,
}
