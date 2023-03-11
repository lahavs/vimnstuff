local nvim_tree_default_width = 30

function ToggleNvimTreeZoom()
    if vim.g.nvim_tree_zoomed == 1 then
        vim.cmd('NvimTreeResize ' .. nvim_tree_default_width)
        vim.g.nvim_tree_zoomed = 0
    else
        vim.cmd('NvimTreeResize 10000')
        vim.g.nvim_tree_zoomed = 1
    end
end

local function nvim_tree_on_attach(bufnr)
    local api = require('nvim-tree.api')
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    api.config.mappings.default_on_attach(bufnr)
    vim.keymap.set('n', 't', api.node.open.tab,                     opts('Open: New Tab'))
    vim.keymap.del('n', '<C-T>', opts('Open: New Tab'))

    -- Add 'A' mapping to toggle window zoom, like in NERDTree
    vim.keymap.set('n', 'A', ToggleNvimTreeZoom, opts('Toggle Zoom'))
end

require("nvim-tree").setup {
  on_attach = nvim_tree_on_attach,
  view = {
    width = nvim_tree_default_width
  },
  actions = {
    open_file = {
      quit_on_open = true,
    }
  }
}

-- close nvim-tree if it's the last tab
-- https://github.com/nvim-tree/nvim-tree.lua/issues/1005#issuecomment-1115831363
local nvimtree_autoclose_group = vim.api.nvim_create_augroup('nvimtree-autoclose', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  group = nvimtree_autoclose_group,
  command = "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif",
  nested = true,
})

local function open_nvim_tree(data)

  -- buffer is a directory
  local directory = vim.fn.isdirectory(data.file) == 1

  if not directory then
    return
  end

  -- change to the directory
  vim.cmd.cd(data.file)

  -- open the tree
  require("nvim-tree.api").tree.open()
end

local nvim_tree_diropen_group = vim.api.nvim_create_augroup('nvim-tree-diropen-group', { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = nvim_tree_diropen_group,
  callback = open_nvim_tree,
})

vim.keymap.set('n', '<C-n>', "<cmd>NvimTreeToggle<cr>")
vim.keymap.set('n', '<C-m>', "<cmd>NvimTreeFindFileToggle<cr>")
