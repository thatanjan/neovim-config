local status_ok, themery = pcall(require, "themery")

if not status_ok then
    return
end

local all_colors = vim.fn.getcompletion("", "color")
local vimruntime = vim.env.VIMRUNTIME
local user_colors = {}
for _, name in ipairs(all_colors) do
    -- Check if the colorscheme exists in the default VIMRUNTIME directory
    local is_default_vim = vim.fn.glob(vimruntime .. "/colors/" .. name .. ".vim") ~= ""
    local is_default_lua = vim.fn.glob(vimruntime .. "/colors/" .. name .. ".lua") ~= ""
    -- If it's not found in the default location, it must be user-installed
    if not (is_default_vim or is_default_lua) then
        table.insert(user_colors, name)
    end
end

themery.setup {
    -- themes = { "pywal", "catppuccin-macchiato", "tokyonight-night", "catppuccin-mocha" },
    themes = user_colors,
    livePreview = true,
}
