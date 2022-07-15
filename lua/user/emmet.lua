vim.g.user_emmet_mode = "i"
vim.g.user_emmet_leader_key = ","

vim.cmd([[
  nnoremap <silent><CR> :call emmet#expandAbbr(0,"")<cr>h:call emmet#splitJoinTag()<cr>ww
]])
