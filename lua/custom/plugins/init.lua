-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Use two spaces for tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Custom plugins
return {

  { -- GitHub Copilot
    'github/copilot.vim',
    event = 'BufWinEnter',
    require('which-key').add {
      { '<leader>c', group = '[C]ode' },
    },
    vim.keymap.set('n', '<leader>cd', ':Copilot disable<CR>', { desc = '[D]isable Copilot' }),
    vim.keymap.set('n', '<leader>ce', ':Copilot enable<CR>', { desc = '[E]nable Copilot' }),
  },

  { -- Telescope custom options
    'nvim-telescope/telescope.nvim',
    pickers = {
      find_files = {
        hidden = true,
        cwd_only = true,
      },
      buffers = {
        theme = 'dropdown',
        initial_mode = 'normal',
      },
    },
  },

  { -- Add prettier to JavaScript and TypeScript files
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
      },
    },
  },

  { -- Neovim Theme
    'ellisonleao/gruvbox.nvim',
    priority = 1000,
    config = function()
      vim.o.background = 'dark'
      vim.cmd [[colorscheme gruvbox]]
    end,
  },

  { -- Neotree
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
    vim.keymap.set('n', '<leader>e', ':Neotree<CR>', { desc = 'File [E]xplorer' }),
  },

  -- Treesitter context
  { 'nvim-treesitter/nvim-treesitter-context', after = 'nvim-treesitter' },

  { -- Treesitter textobjects
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',
              ['ac'] = '@class.outer',
              ['ic'] = '@class.inner',
              ['ai'] = '@conditional.outer',
              ['ii'] = '@conditional.inner',
              ['al'] = '@loop.outer',
              ['il'] = '@loop.inner',
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = '@function.outer',
              [']f'] = '@function.outer',
              [']c'] = '@class.outer',
              [']i'] = '@conditional.outer',
              [']l'] = '@loop.outer',
            },
            goto_previous_start = {
              ['[m'] = '@function.outer',
              ['[f'] = '@function.outer',
              ['[c'] = '@class.outer',
              ['[i'] = '@conditional.outer',
              ['[l'] = '@loop.outer',
            },
          },
        },
      }
    end,
  },
}
