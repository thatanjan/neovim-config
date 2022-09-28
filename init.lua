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
	"user.copilot",
	"user.trouble",
	"user.emmet",
	"user.formatter",
	"user.todo",
}

for _, v in pairs(modules) do
	package.loaded[v] = nil
	require(v)
end
