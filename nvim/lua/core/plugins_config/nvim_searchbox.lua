local Saved_pos = {}

require('searchbox').setup {
  hooks = {
    before_mount = function(_)
      Saved_pos = vim.fn.getpos('.')
    end,
    on_done = function(value, search_type)
      if search_type == "replace" and value ~= nil then
        vim.fn.setpos('.', Saved_pos)
      end
    end
  }
}

vim.keymap.set('n', '<leader>se', '<cmd>SearchBoxReplace modifier=very-no-magic<CR>')
