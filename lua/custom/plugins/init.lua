-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- Use two spaces for tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Show vertical line at 140 characters
vim.opt.colorcolumn = '140'

vim.api.nvim_create_autocmd('FileType', {
  pattern = '*', -- Run on every file type
  callback = function()
    vim.opt.formatoptions:remove { 'r', 'o' } -- Avoid auto commenting new lines (add c here as well if auto commenting continues where it shouldn't)
  end,
})

-- Bind bd to close buffer
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = '[B]uffer [D]elete' })

-- Bind gd to go to definition
vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', { desc = 'Go to [D]efinition' })

-- Bind s to show surround which-key menu
vim.keymap.set('n', 's', '<Cmd>lua require("which-key").show("s", {mode="n", auto=true})<CR>', { desc = 'Surround' })
vim.keymap.set('x', 's', '<Cmd>lua require("which-key").show("s", {mode="v", auto=true})<CR>', { desc = 'Surround' })

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

  { -- Add a statusline to the bottom of the window
    'hoob3rt/lualine.nvim',
    config = function()
      require('lualine').setup {
        options = {
          theme = 'gruvbox',
          section_separators = { '', '' },
          component_separators = { '', '' },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { { 'filename', path = 1 } },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
      }
    end,
  },

  {
    'f-person/git-blame.nvim',
    -- load the plugin at startup
    event = 'VeryLazy',
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin wil only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
      -- your configuration comes here
      -- for example
      enabled = false, -- if you want to enable the plugin
      message_template = ' <author> • <date> • <summary>', -- template for the blame message, check the Message template section for more options
      date_format = '%r', -- template for the date, check Date format section for more options
      virtual_text_column = 1, -- virtual text start column, check Start virtual text at column section for more options
    },

    vim.keymap.set('n', '<leader>cb', ':GitBlameToggle<CR>', { desc = 'Toggle Git [B]lame' }),
    vim.keymap.set('n', '<leader>cc', ':GitBlameCopyCommitURL<CR>', { desc = '[C]opy commit URL' }),
  },
}
