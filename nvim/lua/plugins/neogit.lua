return {
  'NeogitOrg/neogit',
  dependencies = {
    'nvim-lua/plenary.nvim', -- required
    'sindrets/diffview.nvim', -- optional - Diff integration
    'nvim-telescope/telescope.nvim', -- optional
  },
  keys = {
    { '<leader>gg', '<cmd>Neogit<cr>', desc = 'Neogit' },
  },
  opts = {
    mappings = {
      popup = {
        ['F'] = 'PullPopup',
        ['p'] = 'PushPopup',
      },
      status = {
        ['gz'] = 'RefreshBuffer',
      },
    },
  },
  config = true,
}
