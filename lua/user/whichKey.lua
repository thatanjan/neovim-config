local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
    return
end

local makeCommand = require("user.utils").makeCommand

local builtin = require "telescope.builtin"
local telescopeThemes = require "telescope.themes"

local dropdown_without_preview = telescopeThemes.get_dropdown { previewer = false }

local setup = {
    layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 30, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = "center", -- align columns left, center or right
    },
}

which_key.setup(setup)

local make_keymap = function(mapping)
    local prefix = "<leader>"

    mapping[1] = prefix .. mapping.key
    mapping[2] = mapping.command
    mapping["nowait"] = true
    mapping["remap"] = false

    mapping["key"] = nil
    mapping["command"] = nil

    return mapping
end

local new_mappings_table = {
    { key = "a", command = makeCommand "Alpha", desc = "Alpha" },
    { key = "b", group = "BufferLine" },
    { key = "bP", command = makeCommand "BufferLinePick", desc = "Pick Tabs" },
    { key = "bh", command = makeCommand "BufferLineMovePrev", desc = "Move tab to left" },
    { key = "bl", command = makeCommand "BufferLineMoveNext", desc = "Move tab to right" },
    { key = "bp", command = makeCommand "BufferLineTogglePin", desc = "Pin tab" },
    { key = "c", group = "Config" },
    { key = "cp", command = makeCommand "Copilot panel", desc = "Open copilot panel" },
    { key = "cr", command = makeCommand "lua dofile(vim.fn.stdpath('config') .. '/init.lua')", desc = "Reload Config" },
    { key = "e", command = makeCommand "NvimTreeToggle", desc = "Explorer" },
    { key = "f", group = "Telescope Find" },
    { key = "fC", command = makeCommand "Telescope commands", desc = "Commands" },
    { key = "fF", command = makeCommand "Telescope live_grep theme=ivy", desc = "Find Text" },
    { key = "fH", command = makeCommand "Telescope help_tags", desc = "Find Help" },
    { key = "fM", command = makeCommand "Telescope man_pages", desc = "Man Pages" },
    { key = "fP", command = makeCommand "Telescope projects", desc = "Projects" },
    { key = "fR", command = makeCommand "Telescope registers", desc = "Registers" },
    { key = "fb", command = makeCommand "Telescope buffers theme=dropdown previewer=false", desc = "Buffers" },
    { key = "fc", command = makeCommand "Telescope colorscheme", desc = "Colorscheme" },
    {
        key = "ff",
        command = makeCommand "Telescope frecency workspace=CWD theme=dropdown previewer=false hidden=true",
        desc = "Find files",
    },
    { key = "fh", command = makeCommand "Telescope harpoon marks", desc = "Find harpoon files" },
    { key = "fk", command = makeCommand "Telescope keymaps", desc = "Keymaps" },
    { key = "fr", command = makeCommand "Telescope oldfiles", desc = "Open Recent File" },
    { key = "fs", command = makeCommand "Telescope luasnip", desc = "Find snippets" },
    { key = "ft", command = makeCommand "Telescope current_buffer_fuzzy_find", desc = "Find text on current buffer" },
    { key = "g", group = "Git" },
    { key = "gR", command = makeCommand "lua require 'gitsigns'.reset_buffer()", desc = "Reset Buffer" },
    { key = "gS", command = makeCommand "lua require 'gitsigns'.stage_buffer()", desc = "Stage Buffer" },
    { key = "gb", command = makeCommand "Telescope git_branches", desc = "Checkout branch" },
    { key = "gc", command = makeCommand "Telescope git_commits", desc = "Checkout commit" },
    { key = "gd", command = makeCommand "Gitsigns diffthis HEAD", desc = "Diff" },
    { key = "gg", command = makeCommand "lua _LAZYGIT_TOGGLE()", desc = "Lazygit" },
    { key = "gj", command = makeCommand "lua require 'gitsigns'.next_hunk()", desc = "Next Hunk" },
    { key = "gk", command = makeCommand "lua require 'gitsigns'.prev_hunk()", desc = "Prev Hunk" },
    { key = "gl", command = makeCommand "lua require 'gitsigns'.blame_line()", desc = "Blame" },
    { key = "gn", command = makeCommand "Neogit", desc = "Open Neogit" },
    { key = "go", command = makeCommand "Telescope git_status", desc = "Open changed file" },
    { key = "gp", command = makeCommand "lua require 'gitsigns'.preview_hunk()", desc = "Preview Hunk" },
    { key = "gr", command = makeCommand "lua require 'gitsigns'.reset_hunk()", desc = "Reset Hunk" },
    { key = "gs", command = makeCommand "lua require 'gitsigns'.stage_hunk()", desc = "Stage Hunk" },
    { key = "gu", command = makeCommand "lua require 'gitsigns'.undo_stage_hunk()", desc = "Undo Stage Hunk" },
    { key = "h", command = makeCommand "nohlsearch", desc = "No Highlight" },
    { key = "l", group = "LSP" },
    { key = "lF", command = makeCommand "Telescope lsp_references", desc = "Reference with Telescope" },
    { key = "lP", command = makeCommand "Lspsaga peek_type_definition", desc = "Peek type Definition" },
    { key = "lQ", command = makeCommand "Trouble loclist", desc = "Quickfix with Trouble" },
    { key = "lR", command = makeCommand "Lspsaga rename ++project", desc = "Rename in workspace" },
    { key = "lS", command = makeCommand "Telescope lsp_dynamic_workspace_symbols", desc = "Workspace Symbols" },
    { key = "la", command = makeCommand "Lspsaga code_action", desc = "Code Actions" },
    { key = "ld", command = makeCommand "Telescope diagnostics bufnr=0", desc = "Document Diagnostics with Telescope" },
    { key = "lf", command = makeCommand "Lspsaga finder", desc = "Lsp finder" },
    { key = "li", command = makeCommand "Telescope import", desc = "Find imports" },
    { key = "lj", command = makeCommand "Lspsaga diagnostic_jump_next", desc = "Next Diagnostic" },
    { key = "lk", command = makeCommand "Lspsaga diagnostic_jump_prev", desc = "Prev Diagnostic" },
    { key = "ll", command = makeCommand "lua vim.lsp.codelens.run()", desc = "CodeLens Action" },
    { key = "lo", command = makeCommand "Lspsaga outline", desc = "Symbols outline" },
    { key = "lp", command = makeCommand "Lspsaga peek_definition", desc = "Peek Definition" },
    { key = "lq", command = makeCommand "Telescope loclist", desc = "Quickfix with Telescope" },
    { key = "lr", command = makeCommand "Lspsaga rename", desc = "Rename" },
    { key = "ls", command = makeCommand "Telescope lsp_document_symbols", desc = "Document Symbols" },
    { key = "lw", command = makeCommand "Telescope diagnostics", desc = "Workspace Diagnostics" },
    { key = "p", group = "Packer" },
    { key = "pS", command = makeCommand "PackerStatus", desc = "Status" },
    { key = "pc", command = makeCommand "PackerCompile", desc = "Compile" },
    { key = "pi", command = makeCommand "PackerInstall", desc = "Install" },
    { key = "ps", command = makeCommand "PackerSync", desc = "Sync" },
    { key = "pu", command = makeCommand "PackerUpdate", desc = "Update" },
    { key = "q", group = "Quit" },
    { key = "qa", command = makeCommand "bufdo bd", desc = "Quit All Buffers" },
    { key = "qb", command = makeCommand "bw", desc = "Quit Current Buffer" },
    { key = "qq", command = makeCommand "q", desc = "Quit Editor" },
    { key = "s", group = "Session" },
    { key = "sS", command = makeCommand "SSave", desc = "Save the session" },
    { key = "sf", command = makeCommand "Telescope possession list", desc = "Get all the sessions" },
    { key = "ss", command = makeCommand "SSave!", desc = "Save the current session" },
    { key = "t", group = "Trouble" },
    { key = "td", command = makeCommand "Trouble document_diagnostics", desc = "Document Diagnostics with Trouble" },
    { key = "th", command = makeCommand "ToggleTerm direction=horizontal size=10", desc = "Horizontal Terminal" },
    { key = "tq", command = makeCommand "Trouble quickfix", desc = "Quickfix with Trouble" },
    { key = "tr", command = makeCommand "Trouble lsp_references", desc = "LSP References with Trouble" },
    { key = "tw", command = makeCommand "Trouble workspace_diagnostics", desc = "Workspace Diagnostics with Trouble" },
    { key = "w", group = "Write" },
    { key = "wq", command = makeCommand "wqa!", desc = "Save and Quit All" },
    { key = "ww", command = makeCommand "wa!", desc = "Save All" },
}

local new_mappings = {}

for _, mapping in pairs(new_mappings_table) do
    local keymap_table = make_keymap(mapping)
    table.insert(new_mappings, keymap_table)
end

which_key.add(new_mappings)
