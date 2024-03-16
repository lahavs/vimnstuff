-------------
-- keymaps --
-------------

-- Kindly taken from https://medium.com/@haya14busa/incsearch-vim-is-dead-long-live-incsearch-2b7070d55250
-- https://gist.github.com/haya14busa/b8fde67641aa2f7f924749af653771e3
local vimrc_incsearch_highlight_group = vim.api.nvim_create_augroup('vimrc-incsearch-highlight', { clear = true })

vim.api.nvim_create_autocmd("CmdlineEnter", {
  group = vimrc_incsearch_highlight_group,
  pattern = "[/\\?]",
  command = ":set hlsearch",
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
  group = vimrc_incsearch_highlight_group,
  pattern = "[/\\?]",
  command = ":set nohlsearch",
})

-- Easier moving between splits
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

-- Quickly save and reload buffer
vim.keymap.set('n', ';w', '<cmd>w<cr>')
vim.keymap.set('n', ';e', '<cmd>e<cr>')

-- Disable arrow keys
vim.keymap.set({ 'n', 'i' }, '<up>', '<nop>')
vim.keymap.set({ 'n', 'i' }, '<down>', '<nop>')
vim.keymap.set({ 'n', 'i' }, '<left>', '<nop>')
vim.keymap.set({ 'n', 'i' }, '<right>', '<nop>')

-- Use C-{hjkl} in insert mode to move around
vim.keymap.set('i', '<c-k>', '<up>')
vim.keymap.set('i', '<c-j>', '<down>')
vim.keymap.set('i', '<c-h>', '<left>')
vim.keymap.set('i', '<c-l>', '<right>')

-- Disable J (Join line)
vim.keymap.set("n", "J", "<nop>")

-- Clear highlighted search
vim.keymap.set('n', '<leader>h', '<cmd>nohlsearch<cr>')

-- Make 's' act like 'd', except it doesn't save the test to a register
vim.keymap.set('n', 's', '"_d')
vim.keymap.set('n', 'ss', '"_dd')
vim.keymap.set('n', 'S', '"_D')

-- Go to file under cursor, open in new tab
vim.keymap.set('n', 'tgf', '<C-w>gf')

-- Space is now the leader key
-- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Helper for the mapping below
function NewImpl()
  vim.cmd(':new')
  vim.cmd(':winc j')
  vim.cmd(':q')
end

-- Close the current tab, and open a new (Empty) one.
vim.keymap.set('n', '<leader>ew', '<cmd>lua NewImpl()<cr>')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- In visual mode, pressing K/J will move text up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Disable Q
vim.keymap.set("n", "Q", "<nop>")

-- Disable q:
vim.keymap.set("n", "q:", "<nop>")

vim.keymap.set("v", ">", ">gv", { silent = true })
vim.keymap.set("v", "<", "<gv", { silent = true })

-- Make 'n' and 'N' always search forward/backwards, regardless if searched with / or ?
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- TODO(lahavs): This doesn't work correctly with vim-evanesco (the highlight is removed
--                 when moving to next match)
-- vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Bash-like keys for the command line
vim.keymap.set("c", "<c-a>", "<home>")
vim.keymap.set("c", "<c-e>", "<end>")

-- Maximize current split
vim.keymap.set("n", "<leader>m", "<C-w>_<C-w><Bar>", { desc = "Maximize current split" })

function SwapCase(str)
  if str == string.upper(str) then
    return string.lower(str)
  end
  return string.upper(str)
end

Saved_pos = {}

function SavePos()
  Saved_pos = vim.fn.getpos('.')
end

function RestorePos()
  vim.fn.setpos('.', Saved_pos)
end

-- Swap upper/lower case of word
vim.keymap.set("n", "cu", "<cmd>lua SavePos()<CR>ciw<c-o>y<cmd>lua vim.fn.setreg('a', SwapCase(vim.fn.getreg('\"')))<CR><c-o>\"aP<esc><cmd>lua RestorePos()<CR>", { desc = "Swap upper/lower case of word", silent = true })

-- Helper for the map below
function MoveTabImpl(s)
  for _ = 1, s, 1 do
    vim.cmd(':tabn')
  end
end

-- Use <count>gt to move <count> tabs. Be consistent with <count>gT
-- By default <count>gt moves to page number {count}
vim.keymap.set("n", 'gt', '<cmd>lua MoveTabImpl(vim.v.count1)<cr>')


-------------
-- options --
-------------

-- Don't show the search count message when searching.
-- We show it in the statusline with LuaLine
vim.o.shortmess = vim.o.shortmess .. 'S'

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- .. but disable linue numbers in Terminal windows (e.g. fzf :Files)
vim.api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber")

-- Disable when in Terminal windows (e.g. fzf :Files):
-- 1. tablines (for some reason it's done automatically in vim..)
-- 2. statusline
vim.api.nvim_command("autocmd TermOpen * setlocal showtabline=0 laststatus=0")
vim.api.nvim_command("autocmd TermClose * setlocal showtabline=1 laststatus=2")

vim.o.title = true

-- Minimum number of columns to use for the line number
-- Default is 4 which is too large for files with not a lot of lines..
vim.o.numberwidth = 1

-- Allow the cursor to move one char at the end of the line.
-- Useful as then entering insert mode will place cursor at the end of the line
vim.o.virtualedit = 'onemore'

-- String to put at the start of wrapped lines
vim.o.showbreak = '↪'

-- Enable mouse mode
-- vim.o.mouse = 'a'
vim.o.mouse = ''

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Number of screen lines to keep above and below the cursor
vim.o.scrolloff = 5

-- Number of screen lines to keep to the left and right of the cursor,
-- In case 'wrap' is set to false.
vim.o.sidescrolloff = 5

-- Highlight current line
vim.o.cursorline = true

-- Make the cursor underline
vim.o.guicursor = 'a:hor20-Cursor'
-- Together cursor above guicursor, make cursor always white.
-- Needed since with 'set cursorline', the first column in each line (with indentations) is barely visible
-- Plugin at fault is 'indent-blankline.nvim' which shows these lines at indentations..
-- https://github.com/lukas-reineke/indent-blankline.nvim/discussions/165
vim.cmd('highlight Cursor gui=nocombine')

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Incremental highlighting when searching
vim.o.incsearch = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smarttab = true

-- Round indent to multiple of 'shiftwidth' when using > or <
vim.o.shiftround = true

-- Don't show current mode (e.g. --INSERT--) in the ruler, we use Lualine
vim.o.showmode = false

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Make <,> pairs.
-- This e.g. means pressing '%' will jump from one to the other
vim.o.matchpairs = vim.o.matchpairs .. ",<:>"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Make spelling mistakes more visible - Make them red.
vim.cmd('hi SpellBad ctermfg=NONE ctermbg=NONE gui=NONE guibg=Red')

-- Delete all marks on entry, as all marks are saved in the shada file
local vimenter_delmarks_group = vim.api.nvim_create_augroup('vimenter-delmarks', { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
  group = vimenter_delmarks_group,
  command = "delmarks 0-9 a-z"
})

-- override mark setting to be a toggle.
-- i.e., setting an existing mark on the same line it exists, will delete it
local set_mark = function()
  local err, mark = pcall(function()
    return string.char(vim.fn.getchar())
  end)
  if not err then
    return
  end

  local utils = require('marks.utils')
  if not utils.is_valid_mark(mark) then
    return
  end

  local curr_line = vim.fn.getcurpos()[2]
  local mark_line = vim.fn.getpos("'" .. mark)[2]

  if mark_line == curr_line then
    vim.cmd("delmark " .. mark)
  else
    vim.cmd("mark " .. mark)
  end
end

vim.keymap.set('n', 'm', set_mark)

--- NOTE: Disables since we have machakann/vim-highlightedyank
-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
-- local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   callback = function()
--     vim.highlight.on_yank{
--       timeout=-1
--     }
--   end,
--   group = highlight_group,
--   pattern = '*',
-- })
