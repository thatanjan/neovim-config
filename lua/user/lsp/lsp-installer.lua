local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end
local initial_servers = {
	"sumneko_lua",
	"cssls",
	"html",
	"tsserver",
	"pyright",
	"bashls",
	"jsonls",
	"yamlls",
	"intelephense",
	"marksman",
	"eslint",
	"sqls",
}

lsp_installer.setup({
	ensure_installed = initial_servers,
})

local installed_servers = lsp_installer.get_installed_servers()

local server_names = {}

for _, server in pairs(installed_servers) do
	table.insert(server_names, server.name)
end

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(server_names) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	if server == "tsserver" then
		local tsserver_opts = require("user.lsp.settings.tsserver")
		opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
	end

	if server == "sumneko_lua" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("user.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server == "intelephense" then
		local intelephense_opts = require("user.lsp.settings.intelephense")
		opts = vim.tbl_deep_extend("force", intelephense_opts, opts)
	end

	lspconfig[server].setup(opts)
end
