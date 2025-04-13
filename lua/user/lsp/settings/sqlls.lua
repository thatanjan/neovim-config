local status_ok, util = pcall(require, "lspconfig.util")
if not status_ok then
    return
end

return {
    default_config = {
        cmd = { "sql-language-server", "up", "--method", "stdio" },
        filetypes = { "sql", "mysql" },
        root_dir = util.root_pattern("package.json", ".git", vim.loop.cwd()),
        settings = {},
    },
    docs = {
        description = [[
https://github.com/joe-re/sql-language-server

This LSP can be installed via  `npm`. Find further instructions on manual installation of the sql-language-server at [joe-re/sql-language-server](https://github.com/joe-re/sql-language-server).
<br>
    ]],
    },
}
