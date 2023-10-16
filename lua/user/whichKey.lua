local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local makeCommand = require("user.utils").makeCommand

local builtin = require "telescope.builtin"
local telescopeThemes = require "telescope.themes"

local dropdown_without_preview = telescopeThemes.get_dropdown { previewer = false }

-- function makeCommand(command)
--     local finalCommand = "<cmd> " .. command .. " <CR>"
--     return finalCommand
-- end

local setup = {
    plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
        spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
        },
    },
    -- add operators that will trigger motion and text object completion
    -- to enable all native operators, set the preset / operators plugin above
    -- operators = { gc = "Comments" },
    key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ["<space>"] = "SPC",
        -- ["<cr>"] = "RET",
        -- ["<tab>"] = "TAB",
    },
    icons = {
        breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
        separator = "➜", -- symbol used between a key and it's label
        group = "+", -- symbol prepended to a group
    },
    popup_mappings = {
        scroll_down = "<c-d>", -- binding to scroll down inside the popup
        scroll_up = "<c-u>", -- binding to scroll up inside the popup
    },
    window = {
        border = "rounded", -- none, single, double, shadow
        position = "bottom", -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "left", -- align columns left, center or right
    },
    ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
    show_help = true, -- show help message on the command line when the popup is visible
    triggers = "auto", -- automatically setup triggers
    -- triggers = {"<leader>"} -- or specify a list manually
    triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { "j", "k" },
        v = { "j", "k" },
    },
}

local opts = {
    mode = "n", -- NORMAL mode
    prefix = "<leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
    a = { makeCommand "Alpha", "Alpha" },
    b = {
        name = "BufferLine",
        p = {
            makeCommand "BufferLineTogglePin",
            "Pin tab",
        },
        P = { makeCommand "BufferLinePick", "Pick Tabs" },
        h = {
            makeCommand "BufferLineMovePrev",
            "Move tab to left",
        },
        l = {
            makeCommand "BufferLineMoveNext",
            "Move tab to left",
        },
    },
    e = { makeCommand "NvimTreeToggle", "Explorer" },
    c = {
        name = "Config",
        r = { makeCommand "lua dofile(vim.fn.stdpath('config') .. '/init.lua')", "Reload Config" },
    },
    h = { makeCommand "nohlsearch", "No Highlight" },

    f = {
        name = "Telescope Find",
        b = {
            makeCommand "Telescope buffers theme=dropdown previewer=false",
            "Buffers",
        },
        c = { makeCommand "Telescope colorscheme", "Colorscheme" },
        f = {
            makeCommand "Telescope find_files theme=dropdown previewer=false hidden=true",
            "Find files",
        },
        h = { makeCommand "Telescope help_tags", "Find Help" },
        M = { makeCommand "Telescope man_pages", "Man Pages" },
        r = { makeCommand "Telescope oldfiles", "Open Recent File" },
        k = { makeCommand "Telescope keymaps", "Keymaps" },
        R = { makeCommand "Telescope registers", "Registers" },
        C = { makeCommand "Telescope commands", "Commands" },
        F = { makeCommand "Telescope live_grep theme=ivy", "Find Text" },
        P = { makeCommand "Telescope projects", "Projects" },
        t = { makeCommand "Telescope current_buffer_fuzzy_find", "Find text on current buffer" },
        s = { makeCommand "Telescope luasnip", "Find snippets" },
    },

    w = {
        name = "Write",
        w = { "<cmd>wa!<CR>", "Save All" },
        q = { "<cmd>wqa!<CR>", "Save and Quit All" },
    },

    q = {
        name = "Quit",
        b = { "<cmd>bw<CR>", "Quit Current Buffer" },
        a = { "<cmd>bufdo bd<CR>", "Quit All Buffers" },
        q = { "<cmd>q<CR>", "Quit Editor" },
    },

    p = {
        name = "Packer",
        c = { "<cmd>PackerCompile<cr>", "Compile" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
        s = { "<cmd>PackerSync<cr>", "Sync" },
        S = { "<cmd>PackerStatus<cr>", "Status" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

    g = {
        name = "Git",
        g = { makeCommand "lua _LAZYGIT_TOGGLE()", "Lazygit" },
        j = { makeCommand "lua require 'gitsigns'.next_hunk()", "Next Hunk" },
        k = { makeCommand "lua require 'gitsigns'.prev_hunk()", "Prev Hunk" },
        l = { makeCommand "lua require 'gitsigns'.blame_line()", "Blame" },
        p = { makeCommand "lua require 'gitsigns'.preview_hunk()", "Preview Hunk" },
        r = { makeCommand "lua require 'gitsigns'.reset_hunk()", "Reset Hunk" },
        R = { makeCommand "lua require 'gitsigns'.reset_buffer()", "Reset Buffer" },
        s = { makeCommand "lua require 'gitsigns'.stage_hunk()", "Stage Hunk" },
        S = { makeCommand "lua require 'gitsigns'.stage_buffer()", "Stage Buffer" },
        u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
            "Undo Stage Hunk",
        },
        o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
        b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
        c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
        d = {
            makeCommand "Gitsigns diffthis HEAD",
            "Diff",
        },
        n = { "<cmd>Neogit<cr>", "Open Neogit" },
    },

    l = {
        name = "LSP",
        a = { makeCommand "Lspsaga code_action", "Code Actions" },

        d = { makeCommand "Telescope diagnostics bufnr=0", "Document Diagnostics with Telescope" },

        w = {
            makeCommand "Telescope diagnostics",
            "Workspace Diagnostics",
        },

        j = {
            makeCommand "Lspsaga diagnostic_jump_next",
            "Next Diagnostic",
        },
        k = {
            makeCommand "Lspsaga diagnostic_jump_prev",
            "Prev Diagnostic",
        },

        l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },

        q = { makeCommand "Telescope loclist", "Quickfix with Telescope" },
        Q = { makeCommand "Trouble loclist", "Quickfix with Trouble" },

        r = { makeCommand "Lspsaga rename", "Rename" },
        R = { makeCommand "Lspsaga rename ++project", "Rename in workspace" },

        s = { makeCommand "Telescope lsp_document_symbols", "Document Symbols" },
        S = {
            makeCommand "Telescope lsp_dynamic_workspace_symbols",
            "Workspace Symbols",
        },

        p = {
            makeCommand "Lspsaga peek_definition",
            "Peek Definition",
        },
        P = {
            makeCommand "Lspsaga peek_type_definition",
            "Peek type Definition",
        },
        f = {
            makeCommand "Lspsaga finder",
            "Lsp finder",
        },
        F = {
            makeCommand "Telescope lsp_references",
            "Reference with Telescope",
        },

        o = {
            makeCommand "Lspsaga outline",
            "Symbols outline",
        },
        i = {
            makeCommand "Telescope import",
            "Find imports",
        },
    },

    t = {
        name = "Trouble",
        w = {
            makeCommand "Trouble workspace_diagnostics",
            "Workspace Diagnostics with Trouble",
        },
        d = {
            makeCommand "Trouble document_diagnostics",
            "Document Diagnostics with Trouble",
        },
        r = {
            makeCommand "Trouble lsp_references",
            "LSP Reference",
        },
        q = {
            makeCommand "Trouble quickfix",
            "Quickfix ",
        },
        h = { makeCommand "ToggleTerm size=80 direction=horizontal", "horizontal" }, -- Exception
    },

    s = {
        name = "Session",
        S = {
            makeCommand "SSave",
            "Save the session",
        },
        s = {
            makeCommand "SSave!",
            "Save the current session",
        },
        f = {
            makeCommand "Telescope possession list",
            "Get all the sessions",
        },
    },
}

which_key.setup(setup)
which_key.register(mappings, opts)
