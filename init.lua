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
    "user.refactoring",
    "user.noice",
    "user.rainbow",
}

for _, v in pairs(modules) do
    package.loaded[v] = nil
    require(v)
end
