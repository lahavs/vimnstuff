local abolish_words_group = vim.api.nvim_create_augroup('abolish-words', { clear = true })

vim.api.nvim_create_autocmd('BufEnter', {
  group = abolish_words_group,
  command = "Abolish {despa,sepe}rat{e,es,ed,ing,ely,ion,ions,or}  {despe,sepa}rat{}"
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = abolish_words_group,
  command = "Abolish statuc static"
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = abolish_words_group,
  command = "Abolish functiokn function"
})

vim.api.nvim_create_autocmd('BufEnter', {
  group = abolish_words_group,
  command = "Abolish wawy away"
})
