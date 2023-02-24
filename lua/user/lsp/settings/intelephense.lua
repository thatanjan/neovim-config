local status_ok, util = pcall(require, "lspconfig.util")
if not status_ok then
    return
end

return {
    cmd = { "intelephense", "--stdio" },
    filetypes = { "php" },
    root_dir = util.root_pattern("composer.json", ".git", vim.loop.cwd()),
}
