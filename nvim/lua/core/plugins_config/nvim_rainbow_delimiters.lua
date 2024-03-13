require('rainbow-delimiters.setup').setup {
  query = {
    'rainbow-delimiters'
  },
  highlight = {
    -- Replace order of Yellow and Red, since Red is a bit harsh
    'TSRainbowYellow',
    'TSRainbowRed',
    'TSRainbowBlue',
    'TSRainbowOrange',
    'TSRainbowGreen',
    'TSRainbowViolet',
    'TSRainbowCyan',
  },
  -- Highlight the entire buffer all at once
  strategy = {
    [''] = require('rainbow-delimiters').strategy['global'],
  },
}
