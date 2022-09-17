local status_ok, formatter = pcall(require, "formatter")
if not status_ok then
	return
end

local status_ok_util, util = pcall(require, "formatter.util")
if not status_ok_util then
	return
end

local prettierConfig = {
	require("formatter.filetypes.typescript").prettier,

	function(parser)
		if not parser then
			return {
				exe = "prettier",
				args = {
					"--stdin-filepath",
					"--no-semi",
					"--single-quote",
					"--jsx-single-quote",
					"--arrow-parens",
					"avoid",
					"--use-tabs",
					"--tab-width",
					"1",
					util.escape_path(util.get_current_buffer_file_path()),
				},
				stdin = true,
				try_node_modules = true,
			}
		end

		return {
			exe = "prettier",
			args = {
				"--stdin-filepath",
				"--no-semi",
				"--single-quote",
				"--jsx-single-quote",
				"--arrow-parens",
				"avoid",
				"--use-tabs",
				"--tab-width",
				"1",
				util.escape_path(util.get_current_buffer_file_path()),
				"--parser",
				parser,
			},
			stdin = true,
			try_node_modules = true,
		}
	end,
}

-- Utilities for creating configurations

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
formatter.setup({
	-- Enable or disable logging
	logging = true,
	-- Set the log level
	log_level = vim.log.levels.WARN,
	-- All formatter configurations are opt-in
	filetype = {
		-- Formatter configurations for filetype "lua" go here
		-- and will be executed in order
		lua = {
			-- "formatter.filetypes.lua" defines default configurations for the
			-- "lua" filetype
			require("formatter.filetypes.lua").stylua,

			-- You can also define your own configuration
			function()
				-- Supports conditional formatting
				if util.get_current_buffer_file_name() == "special.lua" then
					return nil
				end

				-- Full specification of configurations is down below and in Vim help
				-- files
				return {
					exe = "stylua",
					args = {
						"--search-parent-directories",
						"--stdin-filepath",
						util.escape_path(util.get_current_buffer_file_path()),
						"--",
						"-",
					},
					stdin = true,
				}
			end,
		},
		typescript = prettierConfig,
		typescriptreact = prettierConfig,
		css = {
			require("formatter.filetypes.css").prettier,
		},
		less = {
			require("formatter.filetypes.css").prettier,
			function()
				return {
					exe = "prettier",
					args = { "--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), "--single-quote" },
					stdin = true,
				}
			end,
		},
		javascript = prettierConfig,
		javascriptreact = prettierConfig,
		json = {
			function()
				return {
					exe = "prettier",
					args = {
						"--stdin-filepath",
						vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
						"--double-quote",
						"--use-tabs",
						"--tab-width",
						"1",
					},
					stdin = true,
				}
			end,
		},

		-- Use the special "*" filetype for defining formatter configurations on
		-- any filetype
		["*"] = {
			-- "formatter.filetypes.any" defines default configurations for any
			-- filetype
			require("formatter.filetypes.any").remove_trailing_whitespace,
		},
	},
})
