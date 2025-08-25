-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', 'B', '0')
vim.keymap.set('n', 'E', '$')
vim.keymap.set('n', 'gm', '`')

-- Command -> ctrl remappings
vim.keymap.set('n', '<D-d>', '<C-d>')
vim.keymap.set('n', '<D-u>', '<C-u>')
vim.keymap.set('n', '<D-o>', '<C-o>')
vim.keymap.set('n', '<D-i>', '<C-i>')

-- Buffers
vim.keymap.set('n', '<leader>bp', '<cmd>bprev<CR>', { desc = 'Go to [P]revious buffer' })
vim.keymap.set('n', '<leader>bn', '<cmd>bnext<CR>', { desc = 'Go to [N]ext buffer' })

-- Splits
vim.keymap.set('n', '<leader>vs', '<cmd>vsplit<CR>', { desc = 'Open new vertical split' })
vim.keymap.set('n', '<leader>hs', '<cmd>split<CR>', { desc = 'Open new horizontal split' })

-- Make ctrl/cmd-backspace delete the last word
vim.keymap.set('i', '<C-BS>', '<C-w>')
vim.keymap.set('i', '<D-BS>', '<C-w>')

-- Make option-backspace delete the last word
vim.g.neovide_input_macos_alt_is_meta = true
vim.keymap.set('i', '<M-BS>', '<C-w>')

-- Terminal hotkey
vim.keymap.set('n', '<C-\\>', '<cmd>tab terminal<CR>')
vim.keymap.set('n', '<D-\\>', '<cmd>tab terminal<CR>')
vim.keymap.set('n', '^\\>', '<cmd>tab terminal<CR>')

-- Tabs
vim.keymap.set('n', '<S-h>', 'gT')
vim.keymap.set('n', '<S-l>', 'gt')

vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste without yanking' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
