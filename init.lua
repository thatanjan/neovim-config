local modules = {
    "user.options",
    "user.keymaps",
    "user.plugins",
    "user.autocommands",
    "user.colorscheme",
    "user.cmp",
    "user.telescope",
    "user.treesitter",
    "user.autopairs",
    "user.comment",
    "user.gitsigns",
    "user.nvim-tree",
    "user.bufferline",
    "user.lualine",
    "user.toggleterm",
    "user.project",
    "user.impatient",
    "user.illuminate",
    "user.indentline",
    "user.alpha",
    "user.lsp",
    "user.dap",
    "user.whichKey",
    -- "user.copilot",
    "user.trouble",
    "user.emmet",
    "user.formatter",
    "user.todo",
    "user.renamer",
    "user.lightbulb",
    "user.colorizer",
    "user.nvim-ufo",
    "user.lspsaga",
    "user.nvim-lint",
    "user.undotree",
}

if vim.g.neovide then
    vim.o.guifont = "Fira Code:h14" -- text below applies for VimScript
    vim.g.neovide_scale_factor = 0.7
end

for _, v in pairs(modules) do
    package.loaded[v] = nil
    require(v)
end
