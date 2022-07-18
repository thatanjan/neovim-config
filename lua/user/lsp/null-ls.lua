local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local function format(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
		timeout_ms = 3000,
	})
end

local lsp_formatting = function(bufnr)
	format(bufnr)
end

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})

		vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async=true})' ]])
	end
end

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup({
	debug = true,
	sources = {
		formatting.prettier.with({
			extra_args = {
				"--no-semi",
				"--single-quote",
				"--jsx-single-quote",
				"--arrow-parens",
				"avoid",
				"--use-tabs",
				"--tab-width",
				"4",
			},
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"vue",
				"css",
				"scss",
				"less",
				"html",
				"json",
				"yaml",
				"markdown",
				"graphql",
			},
		}),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		formatting.google_java_format,
		diagnostics.flake8,
		formatting.phpcbf,
	},
	on_attach = on_attach,
})
