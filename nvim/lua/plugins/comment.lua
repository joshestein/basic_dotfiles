return {
  'numToStr/Comment.nvim',
  opts = {},
  lazy = false,
  keys = {
    { '<D-/>', '<Plug>(comment_toggle_linewise_current)', desc = 'Toggle comment current line' },
    { '<C-/>', '<Plug>(comment_toggle_linewise_current)', desc = 'Toggle comment current line' },
    { '<D-/>', '<Plug>(comment_toggle_linewise_visual)', mode = 'v', desc = 'Visual toggle comment current line' },
    { '<C-/>', '<Plug>(comment_toggle_linewise_visual)', mode = 'v', desc = 'Visual toggle comment current line' },
  },
}
