return {
  -- LSP configuration
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Mason to install LSPs and related tools
      { 'mason-org/mason.nvim', config = true },
      'mason-org/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- LSP status updates
      {
        'j-hui/fidget.nvim',
        opts = {
          notification = {
            window = {
              winblend = 0,
            },
          },
        },
      },
    },
    config = function()
      local servers = {
        clangd = {},
        gopls = {},
        ts_ls = {},
        ruff = {},
        pylsp = {
          settings = {
            pylsp = {
              plugins = {
                pyflakes = { enabled = false },
                pycodestyle = { enabled = false },
                autopep8 = { enabled = false },
                yapf = { enabled = false },
                mccabe = { enabled = false },
                pylsp_mypy = { enabled = false },
                pylsp_black = { enabled = false },
                pylsp_isort = { enabled = false },
              },
            },
          },
        },
        html = { filetypes = { 'html', 'twig', 'hbs' } },
        cssls = {},
        tailwindcss = {},
        dockerls = {},
        sqlls = {},
        terraformls = {},
        jsonls = {},
        yamlls = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = { callSnippet = 'Replace' },
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                library = vim.api.nvim_get_runtime_file('', true),
              },
              diagnostics = { globals = { 'vim' }, disable = { 'missing-fields' } },
              format = { enable = false },
            },
          },
        },
      }

      -- Setup Mason
      require('mason').setup()
      local ensure_installed = vim.tbl_keys(servers)
      vim.list_extend(ensure_installed, { 'stylua' })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- LSP attach function
      local on_attach = function(client, bufnr)
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
        end

        -- Useful mappings
        map('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
        map('gr', require('telescope.builtin').lsp_references, 'References')
        map('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
        map('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
        map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')
        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
        map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })
        map('gD', vim.lsp.buf.declaration, 'Goto Declaration')

        -- Inlay hints toggle
        if client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = bufnr })
          end, 'Toggle Inlay Hints')
        end
      end

      -- Setup LSP servers
      for server, cfg in pairs(servers) do
        cfg.on_attach = on_attach
        cfg.capabilities = vim.lsp.protocol.make_client_capabilities()
        vim.lsp.config(server, cfg)
        vim.lsp.enable(server)
      end
    end,
  },

  -- Snippets + Blink completion
  {
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
    config = function()
      local blink = require 'blink.cmp'
      local luasnip = require 'luasnip'

      local kind_icons = {
        Text = '󰉿',
        Method = 'm',
        Function = '󰊕',
        Constructor = '',
        Field = '',
        Variable = '󰆧',
        Class = '󰌗',
        Interface = '',
        Module = '',
        Property = '',
        Unit = '',
        Value = '󰎠',
        Enum = '',
        Keyword = '󰌋',
        Snippet = '',
        Color = '󰏘',
        File = '󰈙',
        Reference = '',
        Folder = '󰉋',
        EnumMember = '',
        Constant = '󰇽',
        Struct = '',
        Event = '',
        Operator = '󰆕',
        TypeParameter = '󰊄',
      }

      blink.setup {
        snippets = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = { default = { 'lsp', 'path', 'snippets', 'buffer', 'lazydev' } },
        keymap = {
          preset = 'default',
          ['<Tab>'] = 'select_next',
          ['<S-Tab>'] = 'select_prev',
          ['<C-y>'] = 'select_and_accept',
          ['<C-Space>'] = 'show_and_insert_or_accept_single',
          ['<C-b>'] = 'scroll_documentation_up',
          ['<C-f>'] = 'scroll_documentation_down',
          ['<C-l>'] = 'snippet_forward',
          ['<C-h>'] = 'snippet_backward',
        },
        formatting = {
          fields = { 'kind', 'abbr', 'menu' },
          format = function(entry, vim_item)
            vim_item.kind = kind_icons[vim_item.kind] or vim_item.kind
            vim_item.menu = ({
              lsp = '[LSP]',
              snippets = '[Snippet]',
              buffer = '[Buffer]',
              path = '[Path]',
              lazydev = '[LazyDev]',
            })[entry.source_name]
            return vim_item
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },
      }
    end,
  },
}
