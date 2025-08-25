return {
  'unblevable/quick-scope',
  init = function()
    vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    vim.g.qs_max_chars = 120
    -- vim.cmd [[
    --   augroup qs_colors
    --     autocmd!
    --     autocmd ColorScheme * highlight QuickScopeSecondary guifg=#5fffff gui=underline ctermfg=81 cterm=underline
    --     autocmd ColorScheme * highlight QuickScopePrimary guifg=#afff5f gui=underline ctermfg=155 cterm=underline
    --   augroup end
    -- ]]
  end,
}
