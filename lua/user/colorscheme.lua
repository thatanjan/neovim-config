local status_ok, themery = pcall(require, "themery")

if not status_ok then
    return
end

themery.setup {
    themes = { "pywal", "catppuccin-macchiato", "tokyonight-night", "catppuccin-mocha" },
    livePreview = true,
}
