-- I like the old 'Gblame' command :)
vim.api.nvim_create_user_command('Gblame', ':Git blame', {})

-- Automatically fold modified files when opening patch with ':Git blame'
-- https://github.com/tpope/vim-fugitive/issues/146
local fugitive_git_fold_group = vim.api.nvim_create_augroup('fugitive-git-fold', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = fugitive_git_fold_group,
  pattern = 'git',
  command = "set foldmethod=syntax",
})
