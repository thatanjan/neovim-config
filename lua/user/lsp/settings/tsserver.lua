local status_ok, util = pcall(require, "lspconfig.util")
if not status_ok then
    return
end

return {
    root_dir = util.root_pattern("package.json", "tsconfig.json", "jsconfig.json", ".git", vim.loop.cwd()),
}
