vim.o.foldcolumn = "2" -- '0' is not bad
vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

local M = {
    "kevinhwang91/nvim-ufo",
    dependencies = {
        "kevinhwang91/promise-async",
        {
            "luukvbaal/statuscol.nvim",
            config = function()
                local builtin = require "statuscol.builtin"
                require("statuscol").setup {
                    relculright = true,
                    segments = {
                        { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
                        { text = { "%s" }, click = "v:lua.ScSa" },
                        { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
                    },
                }
            end,
        },
    },
}

return M
