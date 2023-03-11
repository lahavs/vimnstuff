-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  -- TODO(lahavs): This plugins sets shiftwidth=2 for C code (???)
  -- 'tpope/vim-sleuth',

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          -- TODO(lahavs): This fails..
          -- return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- If you want to add a bunch of pre-configured snippets,
      --    you can use this plugin to help you. It even has snippets
      --    for various frameworks/libraries/etc. but you will have to
      --    set up the ones that are useful for you.
      -- 'rafamadriz/friendly-snippets',
    }
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  -- NOTE: NOT using 'lewis6991/gitsigns.nvim' since gitsigns preview_hunk
  --   opens the hunk in a floating window, while vim-gitgutter opens in a
  --   preview window, which I like better
  {
    'airblade/vim-gitgutter',
    init = function()
      vim.g.gitgutter_preview_win_floating = false
    end,
  },

  -- NOTE: gitsigns is a newer, better alternative to 'airblade/vim-gitgutter'
  -- { -- Adds git releated signs to the gutter, as well as utilities for managing changes
  --   'lewis6991/gitsigns.nvim',
  --   opts = {
  --     -- See `:help gitsigns.txt`
  --     signs = {
  --       add = { text = '+' },
  --       change = { text = '~' },
  --       delete = { text = '_' },
  --       topdelete = { text = '‾' },
  --       changedelete = { text = '~' },
  --     },
  --   },
  -- },

  {
    'HiPhish/nvim-ts-rainbow2',
  },

  {
    'windwp/nvim-autopairs',
  },

  { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'onedark'
      -- The default guibg is gray, having the same color as a comment.
      -- Meaning highlighting parenthesis in a comment made it invisible.
      -- Add a RED foreground to make it more visible
      vim.cmd.hi('MatchParen guifg=red')
    end,
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
  },

  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim' },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
  },

  {
    'chentoast/marks.nvim',
  },

  -- Clear search result highlighting when moving the cursor or entering insert mode
  {
    'lahavs/vim-evanesco',
  },

  -- Disable relativenumber when it doesn't "make sense" (outside focused split, entering commands etc..)
  {
    'sitiom/nvim-numbertoggle',
  },

  -- Not using 'vim.highlight.on_yank()' since it doesn't clear highlighted yanked
  --   lines when entering insert mode..
  {
    'machakann/vim-highlightedyank',
  },

  -- Fast switching between source (.c, .cpp ..) to header file (.h, .hpp ..) and back
  {
    'derekwyatt/vim-fswitch',
  },

  -- Replace surrounding delimiter (e.g. "123" -> '123')
  {
    'kylechui/nvim-surround',
  },

  -- Smooth scrolling
  {
    'karb94/neoscroll.nvim'
  },

  -- Dim inactive windows
  -- DONT USE 'sunjon/Shade.nvim', it messes with the Mason window (makes it invisible)!!
  -- DONT USE 'blueyed/vim-diminactive' since tint.nvim colors are better
  -- NOTE: Using vim-gitgutter together with tint.nvim causes the line numbers of changed
  --   files to become white..
  -- Fix this with:
  -- diff --git a/lua/tint.lua b/lua/tint.lua
  -- index e955063..702ae40 100644
  -- --- a/lua/tint.lua
  -- +++ b/lua/tint.lua
  -- @@ -138,8 +138,10 @@ local function setup_namespaces()
  --
  --      -- Ensure we only have valid keys copied over
  --      hl_def = ensure_valid_hl_keys(hl_def)
  -- -    set_default_ns(hl_group_name, hl_def)
  -- -    set_tint_ns(hl_group_name, hl_def)
  -- +    if hl_group_name ~= "NONE" then
  -- +      set_default_ns(hl_group_name, hl_def)
  -- +      set_tint_ns(hl_group_name, hl_def)
  -- +    end
  --    end
  --  end
  {
    'levouh/tint.nvim',
  },

  -- Fix common spelling mistakes by defining a 'Abolish' command, which provides
  --   a way to define multiple 'iabbrev' rules in a single command
  {
    'tpope/vim-abolish',
    init = function ()
      -- Don't define cr(x) mappings
      vim.g.abolish_no_mappings = true
    end,
  },

  -- Align text around some character with 'ga'
  -- e.g. 'vipga=' to align block of text around '='
  {
    'junegunn/vim-easy-align',
  },

  -- Press 'f/t' after 'f/t{character}' to repeat last command.
  -- Also highlights the occurrences of {character} in the current line
  {
    'rhysd/clever-f.vim',
  },

  -- Undo quitting a window
  {
    'AndrewRadev/undoquit.vim',
    init = function ()
      vim.g.undoquit_mapping='<leader>u'
    end,
  },

  -- Add text-objects triggered by 'a_' and 'i_'.
  -- Imagine:
  -- foo_b*ar_baz
  -- Then 'di_' will result in
  -- foo__baz
  {
    'lucapette/vim-textobj-underscore',
    dependencies = {
      'kana/vim-textobj-user',
    },
  },

  -- Adds 'ac', 'ic', 'aC' and 'iC' as text-objects
  -- https://github.com/coderifous/textobj-word-column.vim/blob/master/doc/textobj-word-column.txt
  -- e.g. 'viC' to select in (v)isual block (i)nner (C)OLUMN
  {
    'coderifous/textobj-word-column.vim',
  },

  -- echo opening line of a matching bracket. e.g. with
  -- if (condition)
  -- {
  --     ...
  -- }^
  -- With cursor at ^, the text 'if (condition)' will be echoed to the status line
  {
    'vim-scripts/matchparenpp',
  },

  -- 1. Trigger 'cursorcolumn' when entering insert mode at the beginning of line
  -- 2. Active 'cursorline' in normal mode, and turn off in insert mode
  -- 3. Disable 'cursorcolumn' and 'cursorline' in non-focused windows
  -- 4. Add the following mappings:
  --    '-' toggle 'cursorline'
  --    '|' toggle 'cursorcolumn'
  {
    'mtth/cursorcross.vim',
  },

  -- Open a man page in a new window. e.g. ':Man printf'
  -- NOTE: Works better than 'paretje/nvim-man' as that plugin opens the new
  --   split in TERMINAL mode, which messes with 'levouh/tint.nvim' (in contrast
  --   vim-man opens in NORMAL mode with VIM as the pager)
  {
    'vim-utils/vim-man',
  },

  -- Map 'GV' to open git commit browers
  -- 'GV!' Only lists commits affecting current file
  -- 'GV?' Fills the location list with revisions of the current file
  {
    'junegunn/gv.vim',
  },

  -- Changes command line to be more bash-like:
  -- <c-w> to erase whole word
  -- <M-BS> to erase until previous '/' etc.
  {
    'ryvnf/readline.vim',
  },

  -- Show colors in neovim. e.g. the following is blue:
  -- #0000ff
  {
    'brenoprata10/nvim-highlight-colors'
  },

  -- Running ':Lost' will echo the context of the current line. e.g.
  -- int main()
  -- {
  --     ...
  --     x = 3;^
  --     ...
  -- }
  -- Running ':Lost' while at ^ will print 'int main()'
  {
    'frioux/vim-lost',
  },

  -- When opening a file with a swapfile, adds options to see a diff between
  --   the swap file and the actual content of the file
  {
    'chrisbra/Recover.vim',
  },

  {
    'folke/todo-comments.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
  },

  {
    'lahavs/vim-better-whitespace',
    init = function ()
      vim.g.strip_whitespace_on_save=1
      vim.g.strip_whitelines_at_eof=1
      vim.g.strip_whitespace_confirm=0
    end
  },

  -- Adds more text objects to operate on
  -- For example 'da,', similar to 'di"' but for commas
  {
    'wellle/targets.vim',
  },

  -- Open search and replace window from the upper right corner
  {
    'VonHeikemen/searchbox.nvim',
    dependencies = {
      'MunifTanjim/nui.nvim',
    },
  },

  -- Motion plugin, pressing s{ch1}{ch2}{label} to jump anywhere on screen
  {
    'ggandor/leap.nvim',
  },

  -- Convert word under cursor to decimal and display it at end of line
  -- NOTE: Also supports converting between bases with 'NibblerTo{Hex,Bin,Dec}', but these
  --   don't work well if the same number appears multiple times in the current line. e.g.:
  -- ```
  -- 0x100 0x100^
  -- ```
  -- If the cursor it at '^' (second 0x100) then running 'NibblerToDec' will change the
  --   first occurrence 0x100.
  {
    'Skosulor/nibbler',
  },

  -- Similar to nibbler, with the exceptions:
  -- Display 4 bases (dec,bin,hex,oct) of number under cursor in statusline
  -- Functions to convert between bases.
  --
  -- The displaying part is not as good as nibbler's, but the conversion is
  --   better (and doesn't have the bug mentioned at nibbler).
  -- So this plugin is used just for base conversions
  {
    'glts/vim-radical',
    dependencies = {
      'glts/vim-magnum',
    },
    init = function()
      vim.g.radical_no_mappings = true
    end
  },

  -- Glorious fzf
  {
    'junegunn/fzf.vim',
    dependencies = {
      { 'junegunn/fzf', dir = '~/.fzf', build = './install --all' },
    },
    config = function()
      vim.g.fzf_layout = { down = '~40%' }
      vim.g.fzf_preview_window = {}
      vim.g.fzf_history_dir = '~/.local/share/fzf-history'
    end
  },

  -- Pasting in Vim with indentation adjusted to destination context.
  -- For example consider the following C code:
  --
  -- int x = 1;
  -- int main() {
  -- }
  --
  -- If you copy the "int x = 1;" line and paste it while the cursor it at "int main() {" line, we get
  --
  -- int x = 1;
  -- int main() {
  -- int x = 1;
  -- }
  --
  -- With vim-pasta the line will be auto-indented:
  --
  -- int x = 1;
  -- int main() {
  --     int x = 1;
  -- }
  'ku1ik/vim-pasta',

  -- inline function signatures
  {
    "ray-x/lsp_signature.nvim",
    -- TODO(lahavs): With the VeryLazy event it doesn't work..
    -- event = "VeryLazy",
    opts = {
      -- Get signatures (and _only_ signatures) when in argument lists.
      doc_lines = 0,
      -- handler_opts = {
      --   border = "none"
      -- },
    },
    config = function(_, opts)
      require "lsp_signature".setup(opts)
    end
  },
}, {
  ui = {
    -- If you have a Nerd Font, set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
