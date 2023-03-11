-- Disable auto-jumping to the first match
require('leap').opts.safe_labels = {}

vim.keymap.set('n', '<leader>s', function ()
  local current_window = vim.fn.win_getid()
  require('leap').leap { target_windows = { current_window } }
end,
  { desc = "Leap forward/backward to"})
