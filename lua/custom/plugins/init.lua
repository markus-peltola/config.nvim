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
              ['af'] = { query = '@function.outer', desc = 'Select outer function' },
              ['if'] = { query = '@function.inner', desc = 'Select inner function' },
              ['ac'] = { query = '@class.outer', desc = 'Select outer class' },
              ['ic'] = { query = '@class.inner', desc = 'Select inner class' },
              ['ai'] = { query = '@conditional.outer', desc = 'Select outer conditional' },
              ['ii'] = { query = '@conditional.inner', desc = 'Select inner conditional' },
              ['al'] = { query = '@loop.outer', desc = 'Select outer loop' },
              ['il'] = { query = '@loop.inner', desc = 'Select inner loop' },
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              [']m'] = { query = '@function.outer', desc = 'Next outer method' },
              [']f'] = { query = '@function.outer', desc = 'Next outer function' },
              [']c'] = { query = '@class.outer', desc = 'Next outer class' },
              [']i'] = { query = '@conditional.outer', desc = 'Next outer conditional' },
              [']l'] = { query = '@loop.outer', desc = 'Next outer loop' },
            },
            goto_previous_start = {
              ['[m'] = { query = '@function.outer', desc = 'Previous outer method' },
              ['[f'] = { query = '@function.outer', desc = 'Previous outer function' },
              ['[c'] = { query = '@class.outer', desc = 'Previous outer class' },
              ['[i'] = { query = '@conditional.outer', desc = 'Previous outer conditional' },
              ['[l'] = { query = '@loop.outer', desc = 'Previous outer loop' },
            },
          },
        },
      }
    end,
  },
}
