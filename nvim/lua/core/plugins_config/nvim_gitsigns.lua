local gs = package.loaded.gitsigns

vim.keymap.set("n", "]c", "<cmd>Gitsigns next_hunk<CR>")
vim.keymap.set("n", "[c", "<cmd>Gitsigns prev_hunk<CR>")
vim.keymap.set({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
vim.keymap.set({'n', 'v'}, '<leader>hu', ':Gitsigns reset_hunk<CR>')
vim.keymap.set('n', '<leader>hr', gs.undo_stage_hunk)
-- Can run '<leader>hp' twice to enter the preview window, then exit it normally (ZQ)
vim.keymap.set("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
