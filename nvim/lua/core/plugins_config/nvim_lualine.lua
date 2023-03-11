local function get_search_occurrences_count()
  -- Taken from https://www.reddit.com/r/neovim/comments/wrj7eu/comment/ikswlfo/
  if vim.v.hlsearch == 1 then
	local sinfo = vim.fn.searchcount { maxcount = 0 }
	local search_stat = sinfo.incomplete > 0 and '[?/?]'
		or sinfo.total > 0 and ('[%s/%s]'):format(sinfo.current, sinfo.total)
		or nil

	if search_stat ~= nil then
      return search_stat
	end
  end
  return ''
end

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    -- component_separators = '|',
    -- section_separators = '',
    refresh = {
      -- By default it's 1000
      -- Refresh faster for 'get_search_occurrences_count()' to be more responsive
      statusline = 100,
    },
    disabled_filetypes = {
      statusline = {'NvimTree'}
    }
  },
  sections = {
    -- By default its:
    -- lualine_x = {'encoding', 'fileformat', 'filetype'},
    -- Remove encoding, it's annoying..
    -- Also add the number of search occurrences (e.g. "[1/20]")
    lualine_x = { get_search_occurrences_count, 'fileformat', 'filetype' },

    -- By default its:
    -- lualine_z = {'location'}
    -- Include the number of lines in the buffer. Syntax:
    -- <line_number_min_width_3>/<number_lines_in_buffer> : <column_number>
    -- See :help statusline
    lualine_z = {'%3l/%L : %c'},
  },
}
