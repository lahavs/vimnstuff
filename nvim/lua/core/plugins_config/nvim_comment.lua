require('Comment').setup({
  -- Don't comment empty lines or lines with just spaces
  ignore = '^%s*$',
})

-- Use '#' as comments on gitconfig files
local gitconfig_comment_group = vim.api.nvim_create_augroup('gitconfig-comment-str', { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = gitconfig_comment_group,
  pattern = 'gitconfig',
  callback = function()
    vim.api.nvim_buf_set_option(0, "commentstring", "# %s")
  end
})
