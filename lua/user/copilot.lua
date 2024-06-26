-- use this table to disable/enable filetypes
vim.g.copilot_filetypes = { xml = false, markdown = true, markdownjsx = true }

-- since most are enabled by default you can turn them off
-- using this table and only enable for a few filetypes
vim.g.copilot_filetypes = { ["*"] = true, python = true }

-- vim.g.copilot_no_tab_map = true
vim.cmd [[imap <silent><script><expr> <A-j> copilot#Accept("\<CR>")]]
vim.g.copilot_no_tab_map = true

vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-accept-word)", { silent = true })

vim.cmd [[highlight CopilotSuggestion guifg=#555555 ctermfg=8]]

vim.g.copilot_workspace_folders = { "~/git_projects/", "~/.config/nvim" }
