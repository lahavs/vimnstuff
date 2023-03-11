vim.b.fswitchlocs = './'

vim.keymap.set('n', '<leader>oF', function() vim.cmd('FSHere') end, { desc = "Switch to/from header this split" })
vim.keymap.set('n', '<leader>oL', function() vim.cmd('FSSplitRight') end, { desc = "Switch to/from header right split" })
vim.keymap.set('n', '<leader>oH', function() vim.cmd('FSSplitLeft') end, { desc = "Switch to/from header left split" })
vim.keymap.set('n', '<leader>oK', function() vim.cmd('FSSplitAbove') end, { desc = "Switch to/from header above split" })
vim.keymap.set('n', '<leader>oJ', function() vim.cmd('FSSplitBelow') end, { desc = "Switch to/from header below split" })
