require('todo-comments').setup {
  signs = false,
  highlight = {
    keyword="bg",
    before="",
    after="fg",
    -- Allow parenthesis after keyword. e.g.:
    -- TODO(lahavs): ...
    -- pattern = [[.*<(KEYWORDS)\s*:]],
    pattern = [[.*<(KEYWORDS)\s*(\(.*\))?\s*:]],
  },
}
