" vim-numbertoggle - Automatic toggling between 'hybrid' and absolute line numbers
" Maintainer:        <https://jeffkreeftmeijer.com>
" Version:           2.1.1

augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu | hi CursorLineNr term=bold ctermfg=11 | endif
  " autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | hi CursorLineNr term=bold ctermfg=248 | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | hi CursorLineNr term=bold ctermfg=11 | endif
augroup END
