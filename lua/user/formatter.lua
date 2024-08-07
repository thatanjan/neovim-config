local status_ok, formatter = pcall(require, "formatter")
if not status_ok then
    return
end

local status_ok_util, util = pcall(require, "formatter.util")
if not status_ok_util then
    return
end

local function starts_with(str, start)
    return str:sub(1, #start) == start
end

local is_in_droppe = starts_with(vim.loop.cwd(), "/home/anjan/git_projects/droppe-one/frontend")

local prettierConfig = {
    require("formatter.filetypes.typescript").prettier,

    function(parser)
        if not parser then
            return {
                exe = "prettier",
                args = {
                    "--stdin-filepath",
                    util.escape_path(util.get_current_buffer_file_path()),
                    -- "--use-tabs",
                },
                stdin = true,
                try_node_modules = true,
            }
        end

        return {
            exe = "prettier",
            args = {
                "--stdin-filepath",
                util.escape_path(util.get_current_buffer_file_path()),
                -- "--use-tabs",
                "--parser",
                parser,
            },
            stdin = true,
            try_node_modules = true,
        }
    end,
}

local js_config = (is_in_droppe and {}) or prettierConfig

local filetype = {
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
                    "--indent-width",
                    "4",
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
    css = {
        require("formatter.filetypes.css").prettier,
    },
    less = {
        require("formatter.filetypes.css").prettier,
        function()
            return {
                exe = "prettier",
                args = {
                    "--stdin-filepath",
                    vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                    "--single-quote",
                },
                stdin = true,
            }
        end,
    },
    javascript = js_config,
    javascriptreact = js_config,
    typescript = js_config,
    typescriptreact = js_config,
    json = {
        require("formatter.filetypes.json").prettier,
    },
    prisma = {
        function()
            return {
                exe = "prettier",
                args = {
                    "--stdin-filepath",
                    vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)),
                    "--use-tabs",
                    "--tab-width",
                    "4",
                    "--plugin=prettier-plugin-prisma",
                },
                stdin = true,
            }
        end,
    },
    php = {
        require("formatter.filetypes.php").php_cs_fixer,
    },
    markdown = {
        require("formatter.filetypes.markdown").prettier,
    },
    sh = {
        require("formatter.filetypes.sh").shfmt,
    },
    yaml = {
        require("formatter.filetypes.yaml").prettier,
    },
    python = {
        require("formatter.filetypes.python").autopep8,
    },

    -- Use the special "*" filetype for defining formatter configurations on
    -- any filetype
    ["*"] = {
        -- "formatter.filetypes.any" defines default configurations for any
        -- filetype
        require("formatter.filetypes.any").remove_trailing_whitespace,
    },
}

-- Utilities for creating configurations

-- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
formatter.setup {
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = filetype,
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        if filetype[vim.bo.filetype] ~= nil then
            vim.cmd.FormatWrite()
        else
            vim.lsp.buf.format()
        end
    end,
})
